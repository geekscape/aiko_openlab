/* event.pde
 * ~~~~~~~~~
 * Please do not remove the following notices.
 * License: GPLv3. http://geekscape.org/static/arduino_license.html
 * ----------------------------------------------------------------------------
 *
 * To Do
 * ~~~~~
 * - None, yet.
 */

void buttonEventOkay(void) {
  Serial.println("buttonEventOkay()");
  stopwatchRunning = !stopwatchRunning;
}

void buttonEventCancel(void) {
  Serial.println("buttonEventCancel()");
  stopwatchCounter=0;
}

void buttonEventLeft(void) {
  Serial.println("buttonEventLeft()");
}

void buttonEventDown(void) {
  Serial.println("buttonEventDown()");
}

void buttonEventUp(void) {
  Serial.println("buttonEventUp()");
}

void buttonEventRight(void) {
  Serial.println("buttonEventRight()");
}
