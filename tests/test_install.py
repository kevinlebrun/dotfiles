"""Exercise file replacement without changing the real home or installing packages."""
import os
from pathlib import Path
import shutil
import subprocess
import tempfile
import unittest

REPO = Path(__file__).resolve().parents[1]

class InstallTests(unittest.TestCase):
    def setUp(self):
        self.temp = tempfile.TemporaryDirectory(prefix="dotfiles-install-")
        self.addCleanup(self.temp.cleanup)
        self.root = Path(self.temp.name)
        self.user_root = self.root / "user files"
        self.user_root.mkdir()
        self.checkout = self.root / "checkout files"
        shutil.copytree(REPO, self.checkout, ignore=shutil.ignore_patterns(".git", "__pycache__"))
        # Substitute only the home variable in a test copy; never change HOME.
        script = self.checkout / "install.sh"
        script.write_text(script.read_text().replace('$HOME', '$DOTFILES_TEST_USER_ROOT'))
        self.env = dict(os.environ, DOTFILES_TEST_USER_ROOT=str(self.user_root))

    def run_setup(self, *args):
        return subprocess.run(['bash', str(self.checkout / 'install.sh'), *args],
                              env=self.env, text=True, capture_output=True, check=True)

    def test_dry_run_changes_nothing(self):
        self.run_setup('--dry-run')
        self.assertEqual(list(self.user_root.iterdir()), [])

    def test_preserves_overrides_backups_and_repeated_install(self):
        original = self.user_root / '.zshrc'
        original.write_text('old settings\n')
        override = self.user_root / '.shellrc_local'
        override.write_text('# machine-local sentinel\n')
        broken = self.user_root / '.curlrc'
        broken.symlink_to(self.user_root / 'missing-target')
        self.run_setup()
        backups = list((self.user_root / '.local/state/dotfiles/backups').iterdir())
        self.assertEqual(len(backups), 1)
        self.assertEqual((backups[0] / '.zshrc').read_text(), 'old settings\n')
        self.assertTrue((backups[0] / '.curlrc').is_symlink())
        self.assertTrue(original.is_symlink())
        self.assertEqual(override.read_text(), '# machine-local sentinel\n')
        self.assertEqual((self.user_root / '.gitconfig_local').stat().st_mode & 0o777, 0o600)
        self.run_setup()
        self.assertEqual(list((self.user_root / '.local/state/dotfiles/backups').iterdir()), backups)
        self.assertFalse((self.user_root / '.vimrc').exists())

if __name__ == '__main__':
    unittest.main()
