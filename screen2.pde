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

PROGSTRING(sHelp2) = "This screen is used  "
                     "for generating wave  "
                     "forms that can be    "
                     "produced as sound via"
                     "the speaker output";

void screenRenderTest2() {
  gText textArea;

  if (screenChange) {
    textArea.DefineArea(0, 10, GLCD.Width-1, 54);
    textArea.SelectFont(font, BLACK);
    textArea.DrawString_P(sHelp2, 0, 0);

    drawString("Freq", WHITE,  0, 55, 32);
    drawString("Amp",  WHITE, 64, 55, 32);
  }

  drawString("2 KHz",  BLACK, 32, 55, 32);
  drawString("50 mA", BLACK, 95, 55, 32);      // TODO: Used "95", not "96" :(
}
