/* aiko_arduinolab.pde
 * ~~~~~~~~~~~~~~~~~~~
 * Please do not remove the following notices.
 * License: GPLv3. http://geekscape.org/static/arduino_license.html
 * Version: 0.0
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
 * - None, yet.
 *
 * Notes
 * ~~~~~
 * - None, yet.
 */

#include <glcd.h>
#include "fonts/SystemFont5x7.h"

#include <AikoEvents.h>

using namespace Aiko;

void setup() {
  Serial.begin(38400);

  pinMode(3, OUTPUT);     // Turn on LCD backlight
  digitalWrite(3, HIGH);  // Paul's prototype hardware

  GLCD.Init();
  GLCD.ClearScreen();
  GLCD.SelectFont(System5x7);

//Events.addHandler(clockHandler, 1000);
}

unsigned long startMillis;
unsigned int iter = 0;

void loop() {
  Events.loop();

  startMillis = millis();

  while (millis() - startMillis < 1000) {
    GLCD.DrawRect(0, 0, 64, 61, BLACK);
    GLCD.DrawRoundRect(68, 0, 58, 61, 5, BLACK);

    for (int i = 0;  i < 62;  i += 4) {
      GLCD.DrawLine(1, 1, 63, i, BLACK);
    }

    GLCD.DrawCircle(32, 31, 30, BLACK);
    GLCD.FillRect(92, 40, 16, 16, WHITE);
    GLCD.CursorTo(5, 5);
    GLCD.PrintNumber(++ iter);
  }
}

/* ------------------------------------------------------------------------- */
