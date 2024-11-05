#!/usr/bin/env zsh 

# borrowed mostly from https://github.com/CoreyMSchafer/dotfiles/brew.sh

# Install homebrew if it isn't already installed
# https://brew.sh
if ! command -v brew &>/dev/null; then
  echo "Homebrew isn't installed. Installing Homebrew..."
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

  # Attempt to set up Homebrew PATH automatically for this session
  if [ -x "/opt/homebrew/bin/brew" ]; then
    # For Apple Silicon Macs
    echo "Configuring Homebrew in PATH for Apple Silicon Mac..."
    export PATH="/opt/homebrew/bin:$PATH"
  fi
else
  echo "Homebrew is already installed."
fi

# Verify brew is now accessible
if ! command -v brew &>/dev/null; then
  echo "Failed to configure Homebrew in PATH. Please add Homebrew to your PATH manually."
  exit 1
fi

# Update Homebrew and Upgrade any already-installed formulae
brew update
brew upgrade
brew upgrade --cask
brew cleanup

# Define an array of packages to install using Homebrew.
packages=(
  "dockutil"
  "neovim"
)

# Loop over the array to install each package.
for package in "${packages[@]}"; do
  if brew list --formulae | grep -q "^$package\$"; then
    echo "$package is already installed. Skipping..."
  else
    echo "Installing $package"
    brew install "$package"
  fi
done

# Define an array of applications to install using Homebrew cask.
apps=(
  "sublime-text"
  "rectangle"
  "suspicious-package"
  "postman"
  "cirruslabs/cli/tart"
)

# Loop over the array to install each application.
for app in "${apps[@]}"; do
  if brew list --cask | grep -q "^$app\$"; then
    echo "$app is already installed. Skipping..."
else
    echo "Installing $app..."
    brew install --cask "$app"
  fi
done

