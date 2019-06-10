NAME="Ben Hicks"
EMAIL="bhicks329@gmail.com"
PROFILE=work
HOSTNAME=smackbook


# Install all brewfiles
brew_install:
	brew update	
	brew bundle --file=config/$(PROFILE)/Brewfile
	brew cleanup

brew_upgrade:
	brew update	
	brew upgrade
	brew cleanup

brew_clean:
	brew bundle cleanup --force --file=config/$(PROFILE)/Brewfile

mac_config:
	sh config/$(PROFILE)/config.sh

mac_setup:
	sudo scutil --set HostName $(HOSTNAME)
	make install_brewfiles
	make config_git
	make config_mac

git_config:
	git config --global user.name $(NAME)
	git config --global user.email $(EMAIL)