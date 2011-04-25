/* screen.pde
 * ~~~~~~~~~~
 * Please do not remove the following notices.
 * License: GPLv3. http://geekscape.org/static/arduino_license.html
 * ----------------------------------------------------------------------------
 *
 * To Do
 * ~~~~~
 * - Only clear screen when required, use a flag
 * - Only render screen when required, if an event has occurred ?
 * - Only update title and menu when required, for up-to 10 seconds after screen change ?
 */

#include <glcd.h>
#include "fonts/SystemFont5x7.h"

#include "cchs_logo.h"

struct screenType {
  char *title;
  void (*render)(void);
};

const struct screenType screens[] = {
  "Test", screenRenderTest
};

byte currentScreen = 0;

byte screenInitialized = false;

void screenInitialize(void) {
  GLCD.Init();
  GLCD.SelectFont(System5x7);
  screenInitialized = true;

  displaySplashScreen(cchs_logo);
}

void screenOutputHandler() {
  if (! screenInitialized) screenInitialize();

  if (secondCounter > 2) {
    GLCD.ClearScreen();
    screens[currentScreen].render();

    displayTitle(screens[currentScreen].title);
//  displayMenu() ?
  }
}

void displaySplashScreen(
  Image_t icon) {

  GLCD.ClearScreen();
  GLCD.DrawBitmap(icon, 0, 0);
  GLCD.CursorToXY(68,  0);  GLCD.print("ArduinoLab");
  GLCD.CursorToXY(86, 20);  GLCD.print("GGHC");
  GLCD.CursorToXY(86, 36);  GLCD.print("2011");
  GLCD.CursorToXY(26, 56);  GLCD.print("hackmelbourne.org");
}

void displayTitle(char *title) {
  GLCD.CursorToXY(0, 0);
  GLCD.print(title);
}

void screenRenderTest(void) {
  GLCD.DrawBitmap(cchs_logo, 0, 0);
  GLCD.CursorToXY(0, 8);  GLCD.print("Test screen render");
}
