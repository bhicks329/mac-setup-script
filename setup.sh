#!/usr/bin/env bash

echo "Installing check and install brew + xcode"

# Check for Homebrew,
# Install if we don't have it
if test ! $(which brew); then
  prompt "Install Xcode"
  xcode-select --install

  prompt "Install Homebrew"
  echo "Installing homebrew..."
  ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
  brew update
  brew upgrade
else
  echo "Update Homebrew"
  brew update
  brew upgrade
fi

# Clone repo and run setup script
brew install git
git clone https://github.com/bhicks329/mac-setup-script.git
cd mac-setup-script
make setup_mac

#echo "Copying dotfiles from Github"
#cd ~
#git clone git@github.com:bradp/dotfiles.git .dotfiles
#cd .dotfiles
#sh symdotfiles

# echo "Grunting it up"
# npm install -g grunt-cli

#Install Zsh & Oh My Zsh
echo "Installing Oh My ZSH..."
curl -L http://install.ohmyz.sh | sh

echo "Setting up Oh My Zsh theme..."
#cd  /Users/bradparbs/.oh-my-zsh/themes
#curl https://gist.githubusercontent.com/bradp/a52fffd9cad1cd51edb7/raw/cb46de8e4c77beb7fad38c81dbddf531d9875c78/brad-muse.zsh-theme > brad-muse.zsh-theme

echo "Setting up Zsh plugins..."
cd ~/.oh-my-zsh/custom/plugins
git clone git://github.com/zsh-users/zsh-syntax-highlighting.git

echo "Setting ZSH as shell..."
chsh -s /bin/zsh

# echo "Please setup and sync Dropbox, and then run this script again."
# read -p "Press [Enter] key after this..."

# echo "Restoring setup from Mackup..."
#mackup restore @TODO uncomment
