# Install command-line tools using Homebrew
# Usage: `brew bundle Brewfile`

update

upgrade

install apple-gcc42
install autoconf
install cmake

# Install GNU core utilities (those that come with OS X are outdated)
# Don’t forget to add `$(brew --prefix coreutils)/libexec/gnubin` to `$PATH`.
install coreutils
# Install some other useful utilities like `sponge`
install moreutils
# Install GNU `find`, `locate`, `updatedb`, and `xargs`, `g`-prefixed
install findutils
# Install GNU `sed`, overwriting the built-in `sed`
install gnu-sed --default-names
# Install Bash 4
# Note: don’t forget to add `/usr/local/bin/bash` to `/etc/shells` before running `chsh`.
install bash
install bash-completion

# Install VIM

install lua
install vim --override-system-vi --with-lua
install cscope
install ctags
install reattach-to-user-namespace

# Install programming tools

install python
install pyenv
install pyenv-pip-rehash
install pyenv-virtualenv
install pyenv-virtualenvwrapper

install rbenv
install rbenv-gemset
install rbenv-gem-rehash
install ruby-build

install go
install node

install mit-scheme
install racket

install erlang

tap homebrew/binary
install packer

install cloc
install git
install mercurial
install sloccount

# Install other niceties

install ack
install archey
install boot2docker
install cgrep
install crunch
install curl
install docker
install dos2unix
install exiftool
install exiv2
install figlet
install fontconfig
install fontforge
install foremost
install gawk
install gd
install gettext
install gnu-getopt
install gnu-sed
install gnu-tar
install gnuplot
install graphviz
install hashpump
install hugo
install iftop
install imagemagick --with-webp
install jq
install lynx
install mcrypt
install md5sha1sum
install mhash
install mtr
install mycli
install netcat
install ngrep
install ngrok
install nmap
install openldap
install openssl
install optipng
install pcre
install pidof
install phantomjs
install pstree
install pv
install q
install rename
install rsync
install siege
install sqlmap
install ssh-copy-id
install sshuttle
install tcpflow
install tig
install tmux
install tree
install tsung
install watch
install wget --enable-iri
install xmlstarlet
install xz

# Install SGDB

install mongodb
install mysql
install redis
install sqlite

# OCR and QRCode

install gocr
install ocrad
install qrencode
install tesseract
install zbar

brew tap homebrew/science
brew install gcc r

# Remove outdated versions from the cellar
cleanup
