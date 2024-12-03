#!/bin/bash

#############################################################################
# Run using sudo so that things requiring elevated permissions can run.
#
#



USERNAME=`logname`
HOMEDIR="/home/$USERNAME"
PABLO_DIRECTORY="$HOMEDIR/pablo"

#############################################################################
# Make a working directory or alert if one already exists.
#
#

if [ -e $PABLO_DIRECTORY ]
then
	echo ""
	echo "$PABLO_DIRECTORY already exists. Exiting."
	echo ""
	exit
else
	mkdir $PABLO_DIRECTORY
	echo "Created $PABLO_DIRECTORY"
	echo ""
fi

cd $PABLO_DIRECTORY

mkdir -p $HOMEDIR/sketchbook/libraries


#############################################################################
# Figure out whether the architecture if 32-bit or 64-bit so that we can get the right download.
#
#

ARCH=`uname -p`
echo "Downloading the Processing application."
echo


if [[ "$ARCH" =~ 64 ]]
then
	echo "Arch is 64-bit"
	echo ""
	wget -O processing.tgz https://github.com/processing/processing/releases/download/processing-0227-2.2.1/processing-2.2.1-linux64.tgz
else
	echo "Arch is 32-bit"
	wget -O processing.tgz https://github.com/processing/processing/releases/download/processing-0227-2.2.1/processing-2.2.1-linux32.tgz
	echo ""
fi

tar -xzvf processing.tgz
rm processing.tgz


#############################################################################
# Get the polargraph library and copy relevant files to sketchbook directory.
#
#

if [ ! -e polargraph.zip ]
then
	wget -O polargraph.zip https://github.com/euphy/polargraphcontroller/releases/download/2017-11-01-20-30/Polargraph.2017-11-01.zip
fi

unzip -o polargraph.zip -d $PABLO_DIRECTORY
echo "Moving polargraph libraries and source to $HOMEDIR/sketchbook"
mv $PABLO_DIRECTORY/Polargraph\ 2017-11-01/processing-source/Processing\ libraries/* $HOMEDIR/sketchbook/libraries
mv $PABLO_DIRECTORY/Polargraph\ 2017-11-01/processing-source/polargraphcontroller/ $HOMEDIR/sketchbook
chown -R $USERNAME $HOMEDIR/sketchbook


#############################################################################
# Make Desktop Shortcut
#
#

if [ -e $HOMEDIR/Desktop/Pablo.desktop ]
then
	echo "Pablo desktop shortcut already exists. Not overwriting"
	echo ""
else
	read -r -d '' DESKTOP_SHORTCUT <<EOF
[Desktop Entry]
Type=Application
Name=Pablo
GenericName=Pablo
Comment=Open-source software prototyping platform
Exec=$HOMEDIR/pablo/processing-2.2.1/processing $HOMEDIR/sketchbook/polargraphcontroller/polargraphcontroller.pde
Icon=processing-pde
Terminal=false
Categories=Development;IDE;Programming;
MimeType=text/x-processing;x-scheme-handler/pde;
Keywords=sketching;software;animation;programming;coding;
StartupWMClass=processing-app-ui-Splash
EOF

	echo "$DESKTOP_SHORTCUT" > $HOMEDIR/Desktop/Pablo.desktop
	chmod ugo+x $HOMEDIR/Desktop/Pablo.desktop
fi

#############################################################################
# Set permissions for accessing the serial port.
#
#

if [ -e "$PABLO_DIRECTORY/serial-setup" ]; then
	echo ""
	echo "Serial permissions have already been set. Not resetting."
	echo ""
else
	touch "$PABLO_DIRECTORY/serial-setup"
	UDEV_PATH="/etc/udev/rules.d"
	UDEV_FILE_ROOT="usb-serial.rules"

	read -r -d '' UDEV_CONFIG <<'EOM'
KERNEL=="ttyACM[0-9]*",MODE="0666"\nKERNEL=="ttyS[0-9]*",MODE="0666"\nKERNEL=="ttyUSB[0-9]*",MODE="0666"
EOM

	for i in {10..31}; do
		UDEV_FILE="$UDEV_PATH/$i-$UDEV_FILE_ROOT"
        
		if [[ ! -e "$UDEV_FILE" ]]; then
			echo "Will write file: $UDEV_FILE"
			echo -e $UDEV_CONFIG > $UDEV_FILE
			break
        	fi
	done

	# User needs to be in the dialout group for serial port permissions to work.
	usermod -a -G dialout $USERNAME
fi

udevadm control --reload

#############################################################################
# Cleanup
#
#

chown -R $USERNAME $PABLO_DIRECTORY
rm -rf $PABLO_DIRECTORY/'Polargraph 2017-11-01'
rm -rf $PABLO_DIRECTORY/polargraph.zip
