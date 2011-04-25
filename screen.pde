/* screen.pde
 * ~~~~~~~~~~
 * Please do not remove the following notices.
 * License: GPLv3. http://geekscape.org/static/arduino_license.html
 * ----------------------------------------------------------------------------
 *
 * To Do
 * ~~~~~
 * - None, yet.
 */

#include <glcd.h>
#include "fonts/SystemFont5x7.h"

byte screenInitialized = false;

void screenInitialize(void) {
  GLCD.Init();
  GLCD.SelectFont(System5x7);

  screenInitialized = true;
}

void displaySplashScreen(
  Image_t icon) {

  if (! screenInitialized) screenInitialize();

  GLCD.ClearScreen();
  GLCD.DrawBitmap(icon, 0, 0);
  GLCD.CursorToXY(68,  0);  GLCD.print("ArduinoLab");
  GLCD.CursorToXY(86, 20);  GLCD.print("GGHC");
  GLCD.CursorToXY(86, 36);  GLCD.print("2011");
  GLCD.CursorToXY(26, 56);  GLCD.print("hackmelbourne.org");
}
