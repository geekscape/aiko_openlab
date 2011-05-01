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
    displayPotLabel(2, "Amp");
    pinPot1 = 3;
    pinPot2 = 800;
  }

  //Retreive Pot inputs and set values to display;
  pinPot1++;
  pinPot2--;
  
  //Display Pot values;
  displayPotValue(1, pinPot1, 1, "V");
  displayPotValue(2, pinPot2, 0, "mA");
}


