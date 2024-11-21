#!/bin/bash

PABLO_DIRECTORY=~/pablo

#############################################################################
# Make a working directory or alert if one already exists.
#
#

if [ -e $PABLO_DIRECTORY ]
then
	echo "$PABLO_DIRECTORY already exists."
	echo ""
else
	mkdir $PABLO_DIRECTORY
	echo "Created $PABLO_DIRECTORY"
	echo ""
fi

cd $PABLO_DIRECTORY
mkdir -p ~/sketchbook/libraries


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
mv $PABLO_DIRECTORY/Polargraph\ 2017-11-01/processing-source/Processing\ libraries/* ~/sketchbook/libraries
mv $PABLO_DIRECTORY/Polargraph\ 2017-11-01/processing-source/polargraphcontroller ~/sketchbook


#############################################################################
# Make Desktop Shortcut
#
#

if [ -e ~/Desktop/Pablo.desktop ]
then
	echo "Pablo desktop shortcut already exists. Not overwriting"
	echo ""
else
	read -r -d '' DESKTOP_SHORTCUT <<'EOF'
[Desktop Entry]
Type=Application
Name=Pablo
GenericName=Pablo
Comment=Open-source software prototyping platform
Exec=~/pablo/processing-2.2.1/processing ~/sketchbook/polargraphcontroller/polargraphcontroller.pde
Icon=processing-pde
Terminal=false
Categories=Development;IDE;Programming;
MimeType=text/x-processing;x-scheme-handler/pde;
Keywords=sketching;software;animation;programming;coding;
StartupWMClass=processing-app-ui-Splash
EOF

	echo "$DESKTOP_SHORTCUT" > ~/Desktop/Pablo.desktop
	chmod ugo+x ~/Desktop/Pablo.desktop
fi


#############################################################################
# Cleanup
#
#

rm -rf ~/pablo/'Polargraph 2017-11-01'
rm -rf ~/pablo/polargraph.zip
