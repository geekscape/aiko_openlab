/* input.pde
 * ~~~~~~~~~
 * Please do not remove the following notices.
 * License: GPLv3. http://geekscape.org/static/arduino_license.html
 * ----------------------------------------------------------------------------
 *
 * Description
 * ~~~~~~~~~~~
 * - None, yet.
 *
 * To Do
 * ~~~~~
 * - Holding button down causes repetitive event generation.
 * - Holding button down for a long time performs some action, e.g preferences.
 */

struct buttonEventType {
  int  lowWaterMark;
  int  highWaterMark;
  void (*eventHandler)(void);
};

const struct buttonEventType buttonEventMap[] = {
  993, 1023, NULL,               // Normal: 1023
  762,  882, buttonEventSelect,  // Normal:  792
  652,  702, buttonEventCancel,  // Normal:  672
  456,  516, buttonEventDown,    // Normal:  486
  289,  349, buttonEventRight,   // Normal:  319
  101,  161, buttonEventUp,      // Normal:  131
    0,   30, buttonEventLeft     // Normal:    0
};

const byte BUTTON_EVENT_COUNT = sizeof(buttonEventMap)/sizeof(buttonEventType);

byte buttonIndex = 0;

void userInputHandler(void) {
  int  value = analogRead(PIN_BUTTONS);
  byte newIndex = 0;

  for (byte index = 0;  index < BUTTON_EVENT_COUNT;  index ++) {
    if (buttonEventMap[index].lowWaterMark  <= value  &&
        buttonEventMap[index].highWaterMark >= value) {

      newIndex = index;
    }
  }

  if (newIndex != buttonIndex) {
    buttonIndex = newIndex;

    if (buttonIndex > 0) (* buttonEventMap[buttonIndex].eventHandler)();
  }
}

// This function returns the analog value controlled by the knob 
//  potentiometers on the face of the unit.
//  INPUT - 1 or 2.  Any other value will return -1.
//  OUTPUT - A value between 0 and 1023, inclusive, as if you did
//            an analogRead() on the pot.
//  Notes - This function spends time restoring PIN_AN_MUX_SELECT 
//           to its original value.
int readPot(int potentiometerNumber){
  int oldAnMuxValue = digitalRead(PIN_AN_MUX_SELECT);
  // The analog multiplexer will read from Pot 1 if PIN_AN_MUX_SELECT is 0, and will
  //   read from Pot 2 if PIN_AN_MUX_SELECT is 1.  Makes it easy, no?
  potentiometerNumber--;
  digitalWrite(PIN_AN_MUX_SELECT, potentiometerNumber);
  int analogValue = analogRead(PIN_AN_MUX_INPUT_X);
  digitalWrite(PIN_AN_MUX_INPUT_X, oldAnMuxValue);
  return analogValue;
}

/* ------------------------------------------------------------------------- */
