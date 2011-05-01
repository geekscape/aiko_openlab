/* screen1.pde
 * ~~~~~~~~~~~
 * Please do not remove the following notices.
 * License: GPLv3. http://geekscape.org/static/arduino_license.html
 * ----------------------------------------------------------------------------
 *
 * Description
 * ~~~~~~~~~~~
 * Power supply screen
 *
 * To Do
 * ~~~~~
 * - None, yet.
 */

float pinPot1 = 0.0;
float pinPot2 = 0.0;
  
void screenRenderTest1() {
  if (screenChange) {
    displayPotLabel(1, "Vlt");
    pinPot1 = 3;

    displayPotLabel(2, "Amp");
    pinPot1 = 800;
  }

  pinPot1 ++;
  displayPotValueNew(1, pinPot1, 2, "V");

  pinPot2 --;
  displayPotValueNew(2, pinPot2, 0, "mA");
}


