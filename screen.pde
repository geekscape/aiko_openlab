/* screen.pde
 * ~~~~~~~~~~
 * Please do not remove the following notices.
 * License: GPLv3. http://geekscape.org/static/arduino_license.html
 * ----------------------------------------------------------------------------
 *
 * To Do
 * ~~~~~
 * - Define a typedef for each struct.
 * - Break into individual screen files.
 * - Break out widgets into own file.
 * - Provide a "textarea" table to avoid duplication of dimension parameters.
 * - Only clear screen as required, use a flag.
 * - Only render screen as required, if an event has occurred ?
 * - Only display title/menu as required, up-to 10 seconds after screen change ?
 * - Provide "addScreen(title, renderFunction)".
 */

#include <glcd.h>
#include "cchs_logo.h"
#include "fonts/SystemFont5x7.h"

const Font_t font = System5x7;

struct screenType {
  char *title;
  void (*render)(void);
};

const struct screenType screens[] = {
  "1] Power Supply",   screenRenderTest1,
  "2] Wave Generator", screenRenderTest2,
  "3] Scribble",       screenRenderTest3
};

const byte screenCount = sizeof(screens) / sizeof(screenType);

byte screenInitialized = false;
byte currentScreen = 0;
byte screenChange = true;

void screenInitialize(void) {
  GLCD.Init();
  GLCD.SelectFont(font);
  screenInitialized = true;

  displaySplashScreen(cchs_logo);
}

void screenChangeHandler(void) {      // TODO: Temporary until navigation works
  currentScreen = (currentScreen + 1) % screenCount;
  screenChange = true;
}

void screenOutputHandler(void) {
  if (! screenInitialized) screenInitialize();

  if (secondCounter >= 3) {
    if (screenChange) GLCD.ClearScreen();
    screens[currentScreen].render();

    if (screenChange) displayTitle(screens[currentScreen].title);
//  displayMenu(); ?

    screenChange = false;
  }
}

PROGSTRING(sArduinoLab) = "ArduinoLab";
PROGSTRING(sGGHC) = "GGHC";
PROGSTRING(s2011) = "2011";
PROGSTRING(sHackMelbourneOrg) = "hackmelbourne.org";

void displaySplashScreen(
  Image_t icon) {

  GLCD.ClearScreen();
  GLCD.DrawBitmap(icon, 0, 0);
  GLCD.DrawString_P(sArduinoLab,       68,  0);
  GLCD.DrawString_P(sGGHC,             86, 20);
  GLCD.DrawString_P(s2011,             86, 36);
  GLCD.DrawString_P(sHackMelbourneOrg, 26, 56);
}

void displayTitle(char *title) {              // TODO: title should use PROGMEM
  gText titleArea;

  titleArea.DefineArea(0, 0, GLCD.Width-1, 8);
  titleArea.SelectFont(font, WHITE);
  titleArea.ClearArea();
  titleArea.DrawString(title, 1, 1);
}

/* ------------------------------------------------------------------------- */

void drawString(
  char     *value,                            // TODO: value should use PROGMEM
  uint8_t   colour,
  byte      x,
  byte      y,
  byte      w) {

  gText textArea;

  textArea.DefineArea(x, y, x + w, y + 8);
  textArea.SelectFont(font, colour);
  textArea.ClearArea();
  textArea.DrawString(value, 1, 1);
}

/* ------------------------------------------------------------------------- */
