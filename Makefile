NAME="Ben Hicks"
EMAIL="bhicks329@gmail.com"
PROFILE=work
HOSTNAME=smackbook


# Install all brewfiles
install_brewfiles:
	brew update
	brew bundle --file=config/$(PROFILE)/Brewfile
	brew cleanup

clean_brewfiles:
	brew bundle cleanup --force --file=config/$(PROFILE)/Brewfile

config_mac:
	sh config/$(PROFILE)/config.sh

config_git:
	git config --global user.name $(NAME)
	git config --global user.email $(EMAIL)

setup_mac:
	sudo scutil --set HostName $(HOSTNAME)
	make install_brewfiles
	make config_git
	make config_mac
