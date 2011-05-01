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

  //drawString("3.3V", BLACK, 32, 55, 31);
  pinPot1++;
  displayPotValueNew(1, pinPot1, 2, "V");
  //drawString("1.5A", BLACK, 95, 55, 31);        // TODO: Used "95", not "96" :(
  pinPot2--;
  displayPotValueNew(2, pinPot2, 0, "mA");
}


