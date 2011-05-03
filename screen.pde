/* screen.pde
 * ~~~~~~~~~~
 * Please do not remove the following notices.
 * License: GPLv3. http://geekscape.org/static/arduino_license.html
 * ----------------------------------------------------------------------------
 *
 * To Do
 * ~~~~~
 * - Automatically remove screen title after fixed time period.
 * - Screen backlight value in EEPROM, changeable via preferences screen.
 * - Initial screen value (specific index or most recent) in EEPROM,
 *     changable via preferences screen.
 * - Define a typedef for each struct.
 * - Only clear screen as required, use a flag.
 * - Only render screen as required, if an event has occurred ?
 * - Only display title/menu as required, up-to 10 seconds after screen change ?
 * - Provide "addScreen(title, renderFunction)".
 */

#include <glcd.h>
#include "cchs_logo.h"
#include "fonts/SystemFont5x7.h"

const Font_t FONT = System5x7;

struct screenType {
  char *title;
  void (*render)(void);
};

const struct screenType screens[] = {
  "1] Power Supply",   screenRenderTest1,
  "2] Wave Generator", screenRenderTest2,
  "3] Scribble",       screenRenderTest3,
  "4] Graph",          screenRenderTest4,
  "5] Stopwatch",      screenRenderTest5
};

const byte SCREEN_COUNT = sizeof(screens) / sizeof(screenType);

byte currentScreen = 0;
byte screenChange = true;
byte screenInitialized = false;

int  screenBacklightIncrement = 4;
const byte SCREEN_BACKLIGHT_COUNT = 255 / screenBacklightIncrement;
byte screenBacklightCounter = SCREEN_BACKLIGHT_COUNT;
byte screenBacklight = 0;

void screenInitialize(void) {
  pinMode(PIN_LCD_BACKLIGHT, OUTPUT);
  analogWrite(PIN_LCD_BACKLIGHT, 180);

  GLCD.Init();
  GLCD.SelectFont(FONT);
  screenInitialized = true;

  displaySplashScreen(cchs_logo);
}

void screenBacklightHandler(void) {
  if (screenBacklightIncrement > 0) {  // Only fade in, then stop at highest value
    if (screenBacklightCounter == 0) {
      screenBacklightCounter = SCREEN_BACKLIGHT_COUNT;
      screenBacklightIncrement = - screenBacklightIncrement;
    }

    screenBacklightCounter --;
    screenBacklight += screenBacklightIncrement;
  }

  analogWrite(PIN_LCD_BACKLIGHT, screenBacklight);
}

void screenChangeHandler(void) {      // TODO: Temporary until navigation works
  currentScreen = (currentScreen + 1) % SCREEN_COUNT;
  screenChange = true;
}

void screenOutputHandler(void) {
  if (! screenInitialized) screenInitialize();

  if (secondCounter >= 3) {         // Disable splash screen: change '3' to '0'
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
  titleArea.SelectFont(FONT, WHITE);
  titleArea.ClearArea();
  titleArea.DrawString(title, 1, 1);
}

void clearTitle() {
  gText titleArea;

  titleArea.DefineArea(0, 0, GLCD.Width-1, 8);
  titleArea.SelectFont(FONT, BLACK);
  titleArea.ClearArea();
}

