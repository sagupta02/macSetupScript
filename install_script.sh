#!/bin/bash
# http://redsymbol.net/articles/unofficial-bash-strict-mode/
set -euo pipefail
IFS=$'\n\t'

# PRECONDITIONS
# 1)
# make sure the file is executable
# chmod +x osx_bootstrap.sh
#
# 2)
# Your password may be necessary for some packages
#
# 3)
# https://docs.brew.sh/Installation#macos-requirements
# xcode-select --install
# (_xcode-select installation_ installs git already, however git will be installed via brew packages as well to install as much as possible the brew way
#  this way you benefit from frequent brew updates)
# 
# 4) don't let the “Operation not permitted” error bite you
# Please make sure you system settings allow the termianl full disk access
# https://osxdaily.com/2018/10/09/fix-operation-not-permitted-terminal-error-macos/

# `set -eu` causes an 'unbound variable' error in case SUDO_USER is not set

SUDO_USER=$(whoami)

# Install oh my zsh
# sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# Check for Homebrew, install if not installed
if test ! $(which brew); then
    echo "Installing homebrew..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
fi

brew update
brew upgrade


# Next steps:
# - Run these three commands in your terminal to add Homebrew to your PATH:
echo '# Set PATH, MANPATH, etc., for Homebrew.' >> /Users/"$SUDO_USER"/.zprofile
echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> /Users/"$SUDO_USER"/.zprofile
eval "$(/opt/homebrew/bin/brew shellenv)"

# Install Java
brew install openjdk
brew install openjdk@11
brew install openjdk@17

PACKAGES=(
    coreutils
    gnu-sed
    gnu-tar
    gnu-indent
    gnu-which
    findutils
    git
    jq
    zsh
    make
    npm
    nvm
    node
    python
    python3
    pypy
    wget
)

echo "Installing packages..."
brew install ${PACKAGES[@]}

CASKS=(
    stats
    spectacle
    iterm2
    firefox
    google-chrome
    slack
    visual-studio-code
    zoom
    notion
    1password
    utm
)

echo "Installing cask apps..."
sudo -u $SUDO_USER brew install --cask ${CASKS[@]}

