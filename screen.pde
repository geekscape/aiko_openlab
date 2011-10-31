/* screen.pde
 * ~~~~~~~~~~
 * Please do not remove the following notices.
 * License: GPLv3. http://geekscape.org/static/arduino_license.html
 * ----------------------------------------------------------------------------
 *
 * To Do
 * ~~~~~
 * - CHECK THIS Automatically remove screen title after fixed time period.
 *    - Edit openlab.pde to move constant time values into the .h file
 * - Screen backlight value in EEPROM, changeable via preferences screen.
 * - Initial screen value (specific index or most recent) in EEPROM,
 *     changable via preferences screen.
 * - Define a typedef for each struct.
 * - Provide a "textarea" table to avoid duplication of dimension parameters.
 * - Only clear screen as required, use a flag.
 * - Only render screen as required, if an event has occurred ?
 * - Only display title/menu as required, up-to 10 seconds after screen change ?
 * - Provide "addScreen(title, renderFunction)".
 */

#include <glcd.h>
#include "cchs_logo.h"
#include "fonts/SystemFont5x7.h"

const Font_t FONT = System5x7;

const byte SPLASH_SCREEN_PERIOD = 3;

struct screenType {
  char *title;
  void (*render)(void);
};

const struct screenType screens[] = {
  "Multimeter",     screenRenderTest1,
  "Wave Generator", screenRenderTest2,
//"Scribble",       screenRenderTest3,
//"Graph",          screenRenderTest4,
//"Stop Watch",     screenRenderTest5,
//"Preferences",    screenRenderTest6
};

const byte SCREEN_COUNT = sizeof(screens) / sizeof(screenType);

byte screenInitialized = false;
byte currentScreen = 0;
byte screenChange = true;

byte titleDisplayCountdown = 0;
// This is calculated as seconds to show title times how many
//  screen refreshes per second.
const byte REFRESH_CYCLES_TO_SHOW_TITLE = 100;

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

// This function is called at regular intervals (defined in aiko_openlab.pde)
//  It is the top level of screen display functions - it handles:
//   - Screen initialization at startup
//   - Clearing the screen on screen change
//   - Calling the current screen's render() function
//   - Displaying the screen's title
void screenOutputHandler(void) {
  if (! screenInitialized) screenInitialize();

  if (secondCounter >= SPLASH_SCREEN_PERIOD) {
    if (screenChange) GLCD.ClearScreen();
    screens[currentScreen].render();

    if (screenChange){
      displayTitle(screens[currentScreen].title);
      titleDisplayCountdown = REFRESH_CYCLES_TO_SHOW_TITLE;
    }
    if (titleDisplayCountdown > 0){
      if (titleDisplayCountdown == 1) clearTitle();
      titleDisplayCountdown--;
    }
    
// displayMenu(); ?

    screenChange = false;
  }
}

void changeScreen(byte increment) {
  cycleIncrement(currentScreen, increment, SCREEN_COUNT);
  screenChange = true;
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

/* ------------------------------------------------------------------------- */

PROGSTRING(sOpenLab) = "OpenLab";
PROGSTRING(sGGHC) = "GGHC";
PROGSTRING(s2011) = "2011";
PROGSTRING(sHackMelbourneOrg) = "hackmelbourne.org";

void displaySplashScreen(
  Image_t icon) {

  GLCD.ClearScreen();
  GLCD.DrawBitmap(icon, 0, 0);
  GLCD.DrawString_P(sOpenLab, 68, 0);
  GLCD.DrawString_P(sGGHC, 86, 20);
  GLCD.DrawString_P(s2011, 86, 36);
  GLCD.DrawString_P(sHackMelbourneOrg, 26, 56);
}

void clearTitle() {
  gText titleArea;

  titleArea.DefineArea(0, 0, GLCD.Width-1, 8);
  titleArea.SelectFont(FONT, BLACK);
  titleArea.ClearArea();
}

void displayTitle(char *title) { // TODO: title should use PROGMEM
  gText titleArea;

  titleArea.DefineArea(0, 0, GLCD.Width-1, 8);
  titleArea.SelectFont(FONT, WHITE);
  titleArea.ClearArea();
  titleArea.DrawString(title, 1, 1);
}

/* ------------------------------------------------------------------------- */

byte throbberIndex = 0;

char throbber[] = "|\0/\0-\0\\\0|\0/\0-\0\\";     // "\" is an escape character

const byte THROBBER_COUNT = sizeof(throbber) / sizeof(byte);

void throbberHandler(void) {
  if (secondCounter >= SPLASH_SCREEN_PERIOD) {
    GLCD.SelectFont(FONT, WHITE);
    GLCD.DrawString(& throbber[throbberIndex], GLCD.Width - 6, 1);

    cycleIncrement(throbberIndex, 2, THROBBER_COUNT);
  }
}

/* ------------------------------------------------------------------------- */

