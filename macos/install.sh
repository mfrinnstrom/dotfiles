#!/bin/bash

# macOS Software Installation Script
# This script installs Homebrew and all necessary software packages

set -e  # Exit on error

echo "🍺 Installing Homebrew..."
if ! command -v brew &> /dev/null; then
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    
    # Add Homebrew to PATH for Apple Silicon Macs
    if [[ $(uname -m) == 'arm64' ]]; then
        echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> ~/.zprofile
        eval "$(/opt/homebrew/bin/brew shellenv)"
    fi
else
    echo "✅ Homebrew already installed"
fi

echo "📦 Updating Homebrew..."
brew update

echo "🔑 Installing 1Password..."
brew install --cask 1password

echo "🧹 Cleaning up..."
brew cleanup

echo "✅ Installation complete!"
echo ""
echo "⚠️  This script only installs 1Password for initial setup."
echo ""
echo "Next steps:"
echo "1. Clone the dotfiles repository: git clone <your-repo-url> ~/.dotfiles"
echo "2. cd ~/.dotfiles/macos"
echo "3. Install remaining packages: brew bundle --file=Brewfile"
echo "4. Run ./configure-macos.sh to configure macOS settings"
echo "5. Use stow to symlink dotfiles (e.g., 'stow nvim' from ~/.dotfiles)"
echo "6. Restart your terminal or run: source ~/.zshrc"
