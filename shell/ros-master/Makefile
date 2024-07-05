# Makefile for installing and removing ros-master.sh script

all:
	@echo 'No rule for make all existing. Please run "sudo make install" to install ros-master.sh'

install:
	@echo 'Installing ros-master.sh...'
	install -D -m755 ros-master.sh /usr/local/bin/ros-master
	@echo 'Installation complete.'

remove:
	@echo 'Removing ros-master.sh...'
	rm -f /usr/local/bin/ros-master
	@echo 'Removal complete.'
