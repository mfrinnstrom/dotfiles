# macOS Setup Scripts

Scripts for setting up a fresh macOS installation with dotfiles, software, and system configurations.

## Quick Start

On a fresh macOS installation:

```bash
# 1. Run the install script directly
bash <(curl -fsSL https://raw.githubusercontent.com/mfrinnstrom/dotfiles/master/macos/install.sh)

# 2. Set up SSH keys (e.g., through 1Password)
# Then clone the repository with SSH

# 3. Clone this repository
git clone git@github.com:mfrinnstrom/dotfiles.git ~/.dotfiles
cd ~/.dotfiles/macos

# 4. Configure macOS system settings
./configure-macos.sh

# 5. Use stow to symlink dotfiles
cd ~/.dotfiles
stow nvim
stow zsh
stow git
# etc...
```

## Scripts

### install.sh

Installs Homebrew (if not present) and all necessary software packages including:

- **CLI Tools**: git, stow, neovim, tmux, fzf, ripgrep, fd, bat, exa, zsh, tree, htop, wget, curl, jq, gh
- **GUI Applications**: iTerm2, VS Code, Chrome, Firefox, Slack, Spotify, Docker, Rectangle, Alfred, 1Password

**Customize**: Edit the `brew install` and `brew install --cask` sections to add/remove packages as needed.

### configure-macos.sh

Configures macOS system settings for an optimal developer experience:

- **General**: Faster key repeat, expanded save/print dialogs, save to disk by default
- **Trackpad/Keyboard**: Enable tap-to-click, fast key repeat rates
- **Screen**: Screenshots to Desktop in PNG format, require password after sleep
- **Finder**: Show hidden files, all extensions, path bar, status bar
- **Dock**: Smaller icons, auto-hide, faster animations, minimize to app icon
- **Safari**: Enable developer tools, show full URLs, Do Not Track
- **Activity Monitor**: Show all processes, sort by CPU usage
- **App Store**: Automatic updates for security patches

**Customize**: Edit the script to comment out or modify settings you don't want.

## Usage Notes

- Both scripts can be run multiple times safely
- `install.sh` will skip Homebrew installation if already present
- `configure-macos.sh` uses macOS `defaults` command to set preferences
- Some changes require logout/restart to take full effect
- Use `stow` manually for each application you want to configure (e.g., `stow nvim`)
