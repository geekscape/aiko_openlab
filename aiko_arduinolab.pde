/* aiko_arduinolab.pde
 * ~~~~~~~~~~~~~~~~~~~
 * Please do not remove the following notices.
 * License: GPLv3. http://geekscape.org/static/arduino_license.html
 * Version: 0.0
 *
 * Documentation:  http://geekscape.github.com/aiko_arduinolab
 * Documentation:  https://github.com/lukeweston/ArduinoLab   # Hardware design
 * ----------------------------------------------------------------------------
 *
 * Third-Party libraries
 * ~~~~~~~~~~~~~~~~~~~~~
 * These libraries are not included in the Arduino IDE and
 * need to be downloaded and installed separately.
 *
 * - Aiko framework
 *   https://github.com/geekscape/Aiko
 *
 * - Graphics LCD KS0108
 *   http://www.arduino.cc/playground/Code/GLCDks0108
 *   http://code.google.com/p/glcd-arduino (V3 RC1 2011-03-24)
 *
 * To Do
 * ~~~~~
 * - Break into multiple files for collaborative development.
 * - Multiple screens with title.
 *   - Multimeter: Voltage and frequency input and output on each channel.
 *   - Waveform display: Simple oscilloscope.
 *   - Waveform generator.
 *   - Ruben's Tube and EEG projects.
 * - Navigation between screens using 6-way button board.
 * - Communications to PC (over ZigBee).
 *
 * Notes
 * ~~~~~
 * - None, yet.
 */

#include <glcd.h>

#include <AikoEvents.h>
using namespace Aiko;

#include "aiko_arduinolab.h"
#include "cchs_logo.h"

void setup(void) {
  displaySplashScreen(cchs_logo);

  Events.addHandler(clockHandler,           1000);
  Events.addHandler(serialTestInputHandler,  100);
}

void loop(void) {
  Events.loop();
}

/* ------------------------------------------------------------------------- */

int secondCounter = 0;

void clockHandler(void) {
  ++ secondCounter;
}
