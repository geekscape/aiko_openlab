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
 * - In general, only update LCD values when they change (avoid flicker).
 * - Move pinMode() to the appropriate application initialization function.
 * - Navigation between screens using 6-way button board.
 * - Potentiometer input and widgets.
 * - Potential screens ...
 *   - Multimeter: Voltage and frequency input and output on each channel.
 *   - Graph: Waveform display: Simple oscilloscope.
 *   - Waveform generator.
 *   - Ruben's Tube and EEG projects.
 *   * Game, e.g GLCD example "Rocket", pong (easter egg).
 *   - Preferences/control screen, plus AVR temperature.
 *   - Battery charge screen (next hardware revision) ?
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

void setup(void) {
  pinMode(PIN_SPEAKER,       OUTPUT);
  pinMode(PIN_LCD_BACKLIGHT, OUTPUT);
  pinMode(PIN_FREQUENCY,     INPUT);
  pinMode(PIN_OUTPUT_1,      OUTPUT);
  pinMode(PIN_OUTPUT_2,      OUTPUT);
  pinMode(PIN_OUTPUT_3,      OUTPUT);
  pinMode(PIN_AN_MUX_SELECT, OUTPUT);
  pinMode(PIN_ZIGBEE_SLEEP,  OUTPUT);

  Events.addHandler(clockHandler,           1000);
//Events.addHandler(outputTestHandler,       100);  // Testing only
  Events.addHandler(serialTestInputHandler,  100);  // Testing only
//Events.addHandler(screenBacklightHandler,   50);  // Example only
  Events.addHandler(screenChangeHandler,    5000);
  Events.addHandler(screenOutputHandler,     100);
  Events.addHandler(stopwatchHandler,        100);
}

void loop(void) {
  Events.loop();
}

/* ------------------------------------------------------------------------- */

struct outputState {
  boolean output1;
  boolean output2;
  boolean output3;
};

const struct outputState outputStates[] = {
  HIGH, LOW,  LOW,
  LOW,  HIGH, LOW,
  LOW,  LOW,  HIGH,
  LOW,  HIGH, LOW
};

const byte OUTPUT_STATE_COUNT = sizeof(outputStates) / sizeof(outputState);

int outputStateIndex = 0;

void outputTestHandler(void) {
  digitalWrite(PIN_OUTPUT_1, outputStates[outputStateIndex].output1);
  digitalWrite(PIN_OUTPUT_2, outputStates[outputStateIndex].output2);
  digitalWrite(PIN_OUTPUT_3, outputStates[outputStateIndex].output3);

  outputStateIndex = (outputStateIndex + 1) % OUTPUT_STATE_COUNT;
}

/* ------------------------------------------------------------------------- */

long secondCounter = 0;

void clockHandler(void) {
  ++ secondCounter;
}
