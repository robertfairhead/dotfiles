#!/usr/bin/env bash
# Ask for the administrator password upfront.
sudo -v

# Keep-alive: update existing `sudo` time stamp until the script has finished.
while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &

# Check for Homebrew,
# Install if we don't have it
if ! command -v brew &>/dev/null; then
    echo "Installing homebrew..."
    ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi

brew update
brew upgrade

if ! command -v mas &>/dev/null; then
    echo "Install mas-cli for reinstalling App Store apps"
    brew install mas
fi

brew bundle
brew cleanup

# Installed the new shell, now we have to activate it
if [[ "$SHELL" != "/usr/local/bin/bash" ]]; then
    echo "Setting new bash as our shell"
    sudo bash -c 'echo /usr/local/bin/bash >> /etc/shells'
    # Change to the new shell, prompts for password
    chsh -s /usr/local/bin/bash
fi

# Install alacritty terminfo entries
if ! infocmp alacritty &>/dev/null; then
    curl -sSfo /tmp/alacritty.info https://raw.githubusercontent.com/jwilm/alacritty/master/extra/alacritty.info
    sudo tic -xe alacritty,alacritty-direct /tmp/alacritty.info
    rm -f /tmp/alacritty.info
fi

bins=(dircolors sed make tr fold)

for bin in ${bins[@]}; do
    sudo ln -sf /usr/local/bin/g${bin} /usr/local/bin/${bin}
done
