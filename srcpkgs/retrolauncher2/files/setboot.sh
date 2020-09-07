#!/usr/bin/env bash

# usage: setboot.sh sourcelauncher autostartapp

source=$1
app=$2

if [ $# -eq 0 ]; then
    echo "No arguments provided"
    exit 1
fi

if [ "source" = "app" ]; then
	echo "You are already booting from it!"
	exit 1
fi


if [ ! -e /etc/sv/$app ]; then
        echo "Doesn't exist"
        exit 1
fi

# ensure other booters aren't enabled
# this will also stop them
# add as many rm -f as booters installed


if [ "$source" = "retroarch" ]; then

	if [ -e /var/service/retrolauncher2 ]; then
		sudo rm -f /var/service/retrolauncher2
	fi

	if [ -e /var/service/emulationstation ]; then
		sudo rm -f /var/service/emulationstation
	fi

	if [ -e /var/service/wayland ]; then
                sudo rm -f /var/service/wayland
        fi

fi

if [ "$source" = "retrolauncher2" ]; then

        if [ -e /var/service/retroarch ]; then
                sudo rm -f /var/service/retroarch
        fi

        if [ -e /var/service/emulationstation ]; then
                sudo rm -f /var/service/emulationstation
        fi

        if [ -e /var/service/wayland ]; then
                sudo rm -f /var/service/wayland
        fi

fi


if [ "$source" = "emulationstation" ]; then

        if [ -e /var/service/retrolauncher2 ]; then
                sudo rm -f /var/service/retrolauncher2
        fi

        if [ -e /var/service/retroarch ]; then
                sudo rm -f /var/service/retroarch
        fi

        if [ -e /var/service/wayland ]; then
                sudo rm -f /var/service/wayland
        fi

fi

if [ "source" = "wayland" ]; then

        if [ -e /var/service/retrolauncher2 ]; then
                sudo rm -f /var/service/retrolauncher2
        fi

        if [ -e /var/service/retroarch ]; then
                sudo rm -f /var/service/retroarch
        fi

        if [ -e /var/service/emulationstation ]; then
                sudo rm -f /var/service/emulationstation
        fi

fi

# after killing other services running, let autostart process begin
sudo ln -sf /etc/sv/$app /var/service/

# create a filecheck used by rrvl.toml
touch /home/odroid/.config/autoboot_$app

# then finally kill the former launcher after deleting the filecheck
sudo rm -f /home/odroid/.config/autoboot_$source
sudo rm -f /var/service/$source 
