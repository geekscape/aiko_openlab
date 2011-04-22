/* aiko_arduinolab.pde
 * ~~~~~~~~~~~~~~~~~~~
 * Please do not remove the following notices.
 * License: GPLv3. http://geekscape.org/static/arduino_license.html
 * Version: 0.0
 * Documentation:  http://geekscape.github.com/aiko_arduinolab
 * Documentation:  https://github.com/lukeweston/ArduinoLab
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
 * To Do
 * ~~~~~
 * - None, yet.
 *
 * Notes
 * ~~~~~
 * - None, yet.
 */

#include <AikoEvents.h>

using namespace Aiko;

void setup() {
  Serial.begin(38400);
  Serial.println("[ArduinoLab 2011-04-22]");
}

void loop() {
  Events.loop();
}

/* ------------------------------------------------------------------------- */
