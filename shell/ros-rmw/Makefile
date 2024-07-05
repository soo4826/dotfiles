# Makefile for installing and removing ros-rmw.sh script

all:
	@echo 'No rule for make all existing. Please run "sudo make install" to install ros-rmw.sh'

install:
	@echo 'Installing ros-rmw.sh...'
	install -D -m755 ros-rmw.sh /usr/local/bin/ros-rmw
	@echo 'Installation complete.'

remove:
	@echo 'Removing ros-rmw.sh...'
	rm -f /usr/local/bin/ros-rmw
	@echo 'Removal complete.'
