# README
Pablo is a handy-dandy drawing machine housed by Knox Makers. It uses the Processing language/editor to send to a pair of stepper motors the code needed to have the motors create a drawing on a vertical(ish) notepad. From the motors depend small cables that hold a pen-holder. The code instructs the motors how to move so that the pen will create a drawing based on an svg file provided to the app.

Historically, Pablo has run on a tiny old Windows laptop. This repo includes an install file to make installing the necessary files onto a linux machine (tested on Ubuntu). It also includes some images that can be fed to Pablo to be drawn. The purpose of creating this repo is to shut down that Windows laptop so that we have all open-source software running at Knox Makers.

Pablo consists of three things:

* The [Processing](https://processing.org) software, which sends instructions to two stepper motors that control the drawing.
* A library/sketchbook called [polargraphcontroller](https://github.com/euphy/polargraphcontroller) that Processing uses to take an svg file as input and to send instructions to the stepper motors via a serial port.
* The hardware bits and bobs that make up the drawing apparatus itself. 

There's an [Instructables article](https://www.instructables.com/Polargraph-Drawing-Machine/) detailing how to build the drawing machine and set up the software. Simplified instructions for how to set up the software and run Pablo follow. Instructions are based on this [guide](https://github.com/euphy/polargraph/wiki/Running-the-controller-from-source-code).

Note that an older version of Processing (2.2.1) is required for this to work.

This script will create a directory named "pablo" in your home directory. This includes the processing application file required to run Pablo. It also creates a directory named "sketchbook" in your home directory. This is the default location in which Processing stores its sketchbooks. Finally, it adds a desktop icon that runs Processing and loads the polargraphcontroller sketchbook that works as an interface for sending a drawing to the hardware.

Sources for the images in this repo are unknown, and they should not be considered to be open source. The install script is open source, let's say GPL 3.

