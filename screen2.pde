/* screen2.pde
 * ~~~~~~~~~~~
 * Please do not remove the following notices.
 * License: GPLv3. http://geekscape.org/static/arduino_license.html
 * ----------------------------------------------------------------------------
 *
 * Description
 * ~~~~~~~~~~~
 * Wave generation screen
 *
 * To Do
 * ~~~~~
 * - None, yet.
 */

PROGSTRING(sHelp2a) = "This screen is used  "
                      "for generating wave  "
                      "forms that can be    "
                      "produced as sound    ";
PROGSTRING(sHelp2b) = "via the speaker      ";

void screenRenderTest2() {
  gText textArea;

  char *helptext;
  
  if (screenChange) {
    //helptext = char(sHelp2a);
    //displayHelpText(helptext);
    displayPotLabel(1, "Frq");
    displayPotLabel(2, "Amp");
  }

  displayPotValue(1, 2, 2, "K");
  displayPotValue(2, 50, 0, "mA");
}
