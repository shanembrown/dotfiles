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
