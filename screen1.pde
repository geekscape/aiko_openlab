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

void screenRenderTest1() {

  char valtmp[7];
  char *value;
  static int pinPot1 = 0;
  static int pinPot2 = 0;
  
  if (screenChange) {
    //drawString("Volt", WHITE,  0, 55, 32);
    displayPotLabel(1,"VLT");
    pinPot1 = 3;
    //drawString("Amp",  WHITE, 64, 55, 32);
    displayPotLabel(2,"AMP");
    pinPot1 = 1;
  }

  drawString("3.3V", BLACK, 32, 55, 31);
  pinPot1 = pinPot1 + 1;
  //value = char(pinPot1) + "V";
  //displayPotValue(1, strncpy(value,&(valtmp[0]),7););
  drawString("1.5A", BLACK, 95, 55, 31);        // TODO: Used "95", not "96" :(
  pinPot2 = pinPot2 + 1;
  //valtmp = char(pinPot2) + "A";
  //valtmp[0] = strcat(char(pinPot1), "V");
  //displayPotValue(2, value);
  delay(5000);
}
