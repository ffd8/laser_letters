# laser_letters
Audio-reactive Typography w/ LASERS VJ tool, built in Processing


### Info
BA 1. year course project at The Basel School of Design / Institute of Visual Communication for Intro to Interaction II. 
In this course, students learned Processing, while combining audio + typography (w/ libraries Minim + Geomerative) with the final result being output using a mixture of video projection and laser projection. A faux-library was created to send desired forms to the laser via OSC and a custom openFrameworks app that controlled the RGB animation-laser. With the two light sources combined, particular regions of the audio-reactive works shined via the especially bright light the laser creates. Please feel free to learn, remix, extend our source code and give credits where applicable.

https://vimeo.com/177851530


### Install
- Download the Releases/Binaries for immediate use, or run the source code from Processing.
- Optional: Run LaserLetters_controller to see what is being sent to laser, or controll it if you have one with same setup!? (EtherDream DAC)

### Use
- A-Z = Changes between sketches
- SHIFT + A-Z = Change letter within sketch
- Up/Down = adjust sound level sensitivity

### Tips
- Install Soundflower for rerouting internal audio if not using mic or external input

### Source Code Dependencies:
- Processing 3.1.1+ » https://processing.org
- minim » http://code.compartmental.net/tools/minim/ 
- Geomerative » http://www.ricardmarxer.com/geomerative/
- oscp5
http://www.sojamo.de/libraries/oscP5/
