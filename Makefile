NAME="Ben Hicks"
EMAIL="bhicks329@gmail.com"
PROFILE=work
HOSTNAME=smackbook


# Install all brewfiles
brew_install:
	brew update	
	brew bundle --file=config/$(PROFILE)/Brewfile
	brew cleanup

# Upgrade all brewfiles
brew_upgrade:
	brew update	
	brew upgrade
	brew cleanup

# Remove any brewfiles not in bundle
brew_clean:
	brew bundle cleanup --force --file=config/$(PROFILE)/Brewfile

# Run mac configuration script
mac_config:
	sh config/$(PROFILE)/config.sh

# Run all configuration and scripts
mac_setup:
	sudo scutil --set HostName $(HOSTNAME)
	make install_brewfiles
	make config_git
	make config_mac

# Configure Git
git_config:
	git config --global user.name $(NAME)
	git config --global user.email $(EMAIL)

# Todo:
# multiple profile support
# Backup and restore of app settings
# Backup and restore of dotfiles
# Automate VSCode restore of Settings Backup Plugin
# Credential backup and restore / Vault integration