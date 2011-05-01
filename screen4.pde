/* screen4.pde
 * ~~~~~~~~~~~
 * Please do not remove the following notices.
 * License: GPLv3. http://geekscape.org/static/arduino_license.html
 * ----------------------------------------------------------------------------
 *
 * Description
 * ~~~~~~~~~~~
 * George's test screen
 *
 * To Do
 * ~~~~~
 * - None, yet.
 */

void drawGeoAxes() {
  GLCD.DrawLine(10, (int)(GLCD.Height/2), GLCD.Width-10, (int)(GLCD.Height/2), BLACK); // Horizontal Line
  GLCD.DrawLine((int)(GLCD.Width/2), 10, (int)(GLCD.Width/2), 50 , BLACK); // Vertical Line
}

void screenRenderTest4() {
  if (screenChange) {
    drawGeoAxes();
    drawString("Volt", WHITE,  0, 55, 32);
  }

  int   result = analogRead(PIN_ANALOG_INPUT);
  float volt   = ((result * 5.0) / 1023);
  char  test[7];

  dtostrf(volt, 3, 2, test);
  strcat(test, "V");
  drawString(test, BLACK, 32, 55, 32);
}
