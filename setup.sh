#!/usr/bin/env bash

brews=(
  aws-shell
  chainsawbaby/formula/bash-snippets
  cheat
  coreutils
  dfc
  dnsmasq
  findutils
  fontconfig --universal
  fpp
  fzf
  git
  bash-completion
  git-extras
  git-fresh
  git-lfs
  gnuplot --with-qt
  gnu-sed --with-default-names
  go
  htop
  iftop
  imagemagick --with-webp
  lnav
  mackup
  macvim
  mas
  moreutils
  mtr
  ncdu
  nmap
  node
  poppler
  pgcli
  pv
  python
  python3
  osquery
  stormssh
  thefuck
  tmux
  tree
  trash
  vim --with-override-system-vi
  wget --with-iri
)

casks=(
  adobe-reader
  cakebrew
  cleanmymac
  docker
  dropbox
  firefox
  google-chrome
  github-desktop
  hosts
  handbrake
  hyper
  iina
  istat-menus
  istat-server  
  launchrocket
  licecap
  quicklook-json
  quicklook-csv
  macdown
  microsoft-office
  muzzle
  private-eye
  satellite-eyes
  sidekick
  skype
  slack
  spotify
  steam
  teleport
  transmission
  transmission-remote-gui
  tunnelbear
  visual-studio-code
  volumemixer
  webstorm
  xquartz
)

pips=(
  pip
  glances
  ohmu
  pythonpy
)

gems=(
  bundle
)

npms=(
  fenix-cli
  gitjk
  kill-tabs
  n
  nuclide-installer
)

git_configs=(
  "branch.autoSetupRebase always"
  "color.ui auto"
  "core.autocrlf input"
  "core.pager cat"
  "credential.helper osxkeychain"
  "merge.ff false"
  "pull.rebase true"
  "push.default simple"
  "rebase.autostash true"
  "rerere.autoUpdate true"
  "rerere.enabled true"
  "user.name bhicks329"
  "user.email bhicks329@gmail.com"
)

vscode=(
  lukehoban.Go
)

fonts=(
  font-source-code-pro
)

######################################## End of app list ########################################
set +e
set -x

function prompt {
  read -p "Hit Enter to $1 ..."
}

if test ! $(which brew); then
  prompt "Install Xcode"
  xcode-select --install

  prompt "Install Homebrew"
  ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
else
  prompt "Update Homebrew"
  brew update
  brew upgrade
fi
brew doctor
brew tap homebrew/dupes

function install {
  cmd=$1
  shift
  for pkg in $@;
  do
    exec="$cmd $pkg"
    prompt "Execute: $exec"
    if ${exec} ; then
      echo "Installed $pkg"
    else
      echo "Failed to execute: $exec"
    fi
  done
}

prompt "Update ruby"
ruby -v
brew install gpg
gpg --keyserver hkp://keys.gnupg.net --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3
curl -sSL https://get.rvm.io | bash -s stable
ruby_version='2.6.0'
rvm install ${ruby_version}
rvm use ${ruby_version} --default
ruby -v
sudo gem update --system

prompt "Install Java"
brew cask install java

prompt "Install packages"
brew info ${brews[@]}
install 'brew install' ${brews[@]}

prompt "Install software"
brew tap caskroom/versions
brew cask info ${casks[@]}
install 'brew cask install' ${casks[@]}

prompt "Installing secondary packages"
install 'pip install --upgrade' ${pips[@]}
install 'gem install' ${gems[@]}
install 'npm install --global' ${npms[@]}
install 'code --install-extension' ${vscode[@]}
brew tap caskroom/fonts
install 'brew cask install' ${fonts[@]}


prompt "Set git defaults"
for config in "${git_configs[@]}"
do
  git config --global ${config}
done
gpg --keyserver hkp://pgp.mit.edu --recv ${gpg_key}

prompt "Install mac CLI [NOTE: Say NO to bash-completions since we have fzf]!"
sh -c "$(curl -fsSL https://raw.githubusercontent.com/guarinogabriel/mac-cli/master/mac-cli/tools/install)"

prompt "Update packages"
pip3 install --upgrade pip setuptools wheel
mac update

prompt "Cleanup"
brew cleanup
brew cask cleanup

read -p "Run `mackup restore` after DropBox has done syncing ..."
echo "Done!"
