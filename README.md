= README =
Pablo is our handy-dandy drawing machine, which uses the Processing language/editor to send to a pair of stepper motors the code needed to have the motors create a drawing on a vertical(ish) notepad. From the motors depend small cables that hold a pen-holder. The code instructs the motors how to move so that the pen will create a drawing based on an svg file provided to the app.

Historically, Pablo has run on a tiny old Windows laptop. These instructions explain how to install it on a linux laptop, so that proprietary software isn't required to run the program.

Pablo consists of three things:

* The [Processing](https://processing.org) software, which sends instructions to two stepper motors that control the drawing.
* A library/sketchbook called [polargraphcontroller](https://github.com/euphy/polargraphcontroller) that Processing uses to take an svg file as input and to send instructions to the stepper motors via a serial port.
* The hardware bits and bobs that make up the drawing apparatus itself. 

There's an [Instructables article](https://www.instructables.com/Polargraph-Drawing-Machine/) detailing how to build the drawing machine and set up the software. Simplified instructions for how to set up the software and run Pablo follow. Instructions are based on this [guide](https://github.com/euphy/polargraph/wiki/Running-the-controller-from-source-code).

== Get the Software ==
The polargraph library works only with version 2.2.1 of Processing, so resist the urge to get the latest and greatest. 

1. Download version 2.2.1 of Processing from the [releases](https://processing.org/releases) page. 
2. Install and run it and observe where the "sketchbooks" directory is (check File -> Preferences -> Sketchbook Location). Or change the location if you'd like.
3. Download polargraphcontroller from [this page](https://github.com/euphy/polargraphcontroller/releases/tag/2017-11-01-20-30). Use the zip file.
4. Unzip the file and copy/move files from its
