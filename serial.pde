/* serial.pde
 * ~~~~~~~~~~
 * Please do not remove the following notices.
 * License: GPLv3. http://geekscape.org/static/arduino_license.html
 * ----------------------------------------------------------------------------
 *
 * Description
 * ~~~~~~~~~~~
 * Provides a test serial communications handler that translates specific received characters
 * into navigation events.
 *
 * To Do
 * ~~~~~
 * - None, yet.
 */

struct keyEventType {
  byte key;
  void (*eventHandler)(void);
};

const struct keyEventType keyEventMap[] = {
  'y', buttonEventOkay,
  'n', buttonEventCancel,
  'h', buttonEventLeft,
  'j', buttonEventDown,
  'k', buttonEventUp,
  'l', buttonEventRight
};

const byte keyEventCount = sizeof(keyEventMap) / sizeof(keyEventType);

byte serialInitialized = false;

void serialInitialize(void) {
  Serial.begin(DEFAULT_BAUD_RATE);

  serialInitialized = true;
}

void serialTestInputHandler(void) {
  if (! serialInitialized) serialInitialize();

  if (Serial.available() > 0) {
    byte key = Serial.read();

    for (byte index = 0;  index < keyEventCount;  index ++) {
      if (keyEventMap[index].key == key) (* keyEventMap[index].eventHandler)();
    }
  }
}
