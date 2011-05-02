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
    pinPot1 =   3.0;  // Test only

    displayPotLabel(2, "Amp");
    pinPot2 = 800.0;  // Test only
  }

  // TODO: Retreive Pot inputs and set values to display;

  displayPotValue(1, pinPot1 ++, 1, "V");
  displayPotValue(2, pinPot2 --, 0, "mA");
}
