/* event.pde
 * ~~~~~~~~~
 * Please do not remove the following notices.
 * License: GPLv3. http://geekscape.org/static/arduino_license.html
 * ----------------------------------------------------------------------------
 *
 * To Do
 * ~~~~~
 * - Comment-out serial console debugging diagnostics, when finished.
 */

void buttonEventSelect(void) {
  Serial.println("buttonEventSelect()");
}

void buttonEventCancel(void) {
  Serial.println("buttonEventCancel()");
}

void buttonEventLeft(void) {
  changeScreen(-1);

  Serial.println("buttonEventLeft()");
}

void buttonEventDown(void) {
  Serial.println("buttonEventDown()");
}

void buttonEventUp(void) {
  Serial.println("buttonEventUp()");
}

void buttonEventRight(void) {
  changeScreen(1);

  Serial.println("buttonEventRight()");
}

/* ------------------------------------------------------------------------- */
