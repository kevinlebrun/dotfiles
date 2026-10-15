#!/usr/bin/env bash
# Install this checkout without fetching, rebasing or changing system settings.
set -euo pipefail
REPO_DIR="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"
DRY_RUN=0
WITH_PACKAGES=0
LEGACY_VIM=0
for arg in "$@"; do
    case "$arg" in
        --dry-run) DRY_RUN=1 ;;
        --with-packages) WITH_PACKAGES=1 ;;
        --legacy-vim) LEGACY_VIM=1 ;;
        --help|-h)
            echo "Usage: bash install.sh [--dry-run] [--with-packages] [--legacy-vim]"
            echo "Links dotfiles, backs up replaced files and preserves local overrides."
            exit 0 ;;
        *) echo "Unknown option: $arg" >&2; exit 2 ;;
    esac
done
[[ "$(id -u)" != 0 ]] || { echo "Run without sudo." >&2; exit 1; }

# Shell startup uses a stable ~/dotfiles path, even for a differently named clone.
if [[ "$REPO_DIR" != "$HOME/dotfiles" ]]; then
    if [[ -e "$HOME/dotfiles" || -L "$HOME/dotfiles" ]]; then
        [[ "$(cd -- "$HOME/dotfiles" && pwd -P)" == "$(cd -- "$REPO_DIR" && pwd -P)" ]] || {
            echo "Another ~/dotfiles already exists; run its installer or choose one checkout." >&2
            exit 1
        }
    elif [[ "$DRY_RUN" == 0 ]]; then
        ln -s "$REPO_DIR" "$HOME/dotfiles"
    else
        echo "Would link $HOME/dotfiles -> $REPO_DIR"
    fi
fi

if [[ "$WITH_PACKAGES" == 1 ]]; then
    if [[ "$DRY_RUN" == 1 ]]; then
        echo "Would install Brewfile dependencies with brew bundle --no-upgrade."
    else
        if ! command -v brew >/dev/null 2>&1; then
            for brew_bin in /opt/homebrew/bin/brew /usr/local/bin/brew; do
                if [[ -x "$brew_bin" ]]; then eval "$("$brew_bin" shellenv)"; break; fi
            done
        fi
        command -v brew >/dev/null 2>&1 || { echo "Install Homebrew from https://brew.sh first." >&2; exit 1; }
        brew bundle install --no-upgrade --file="$REPO_DIR/Brewfile"
    fi
fi

umask 077
BACKUP_DIR="$HOME/.local/state/dotfiles/backups/$(date +%Y%m%d-%H%M%S)-$$"
link() {
    local src="$REPO_DIR/$1" dest="$HOME/${2:-$1}"
    [[ -e "$src" ]] || { echo "Missing source: $src" >&2; exit 1; }
    if [[ -L "$dest" && "$(readlink "$dest")" == "$src" ]]; then
        return
    fi
    if [[ "$DRY_RUN" == 1 ]]; then
        echo "Would back up any existing $dest and link -> $src"
        return
    fi
    if [[ -e "$dest" || -L "$dest" ]]; then
        mkdir -p "$BACKUP_DIR"
        mv "$dest" "$BACKUP_DIR/$(basename "$dest")"
    fi
    ln -s "$src" "$dest"
    echo "Linked $dest"
}
for file in .bashrc .bash_profile .zshrc .zprofile .inputrc .ripgreprc .gitconfig .gitattributes .gitignore .git-prompt.sh .editorconfig .curlrc .wgetrc .tmux.conf .hushlogin; do
    link "$file"
done
if [[ "$LEGACY_VIM" == 1 ]]; then
    link .vimrc
    link vim .vim
fi
for entry in 'shell/local.example:.shellrc_local' 'shell/gitconfig-local.example:.gitconfig_local'; do
    src="${entry%%:*}"
    dest="$HOME/${entry#*:}"
    if [[ ! -e "$dest" && ! -L "$dest" ]]; then
        if [[ "$DRY_RUN" == 1 ]]; then
            echo "Would create private local override: $dest"
        else
            install -m 600 "$REPO_DIR/$src" "$dest"
        fi
    fi
done
if [[ "$DRY_RUN" == 0 ]]; then
    echo "Done. Backups, if any: $BACKUP_DIR"
    echo "Open a new terminal. Local overrides are preserved; no credentials or system settings were copied."
fi
