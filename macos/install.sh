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

# Get the directory where this script is located
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

echo "� Installing packages from Brewfile..."
brew bundle --file="${SCRIPT_DIR}/Brewfile"

echo "🧹 Cleaning up..."
brew cleanup

echo "✅ Installation complete!"
echo ""
echo "Next steps:"
echo "1. Run ./configure-macos.sh to configure macOS settings"
echo "2. Use stow to symlink dotfiles (e.g., 'stow nvim' from ~/.dotfiles)"
echo "3. Restart your terminal or run: source ~/.zshrc"
