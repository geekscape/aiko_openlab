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
  if (screenChange) {
    drawString("Volt", WHITE,  0, 55, 32);
    drawString("Amp",  WHITE, 64, 55, 32);
  }

  drawString("3.3V", BLACK, 32, 55, 32);
  drawString("1.5A", BLACK, 95, 55, 32);        // TODO: Used "95", not "96" :(
}
