/* screen.pde
 * ~~~~~~~~~~
 * Please do not remove the following notices.
 * License: GPLv3. http://geekscape.org/static/arduino_license.html
 * ----------------------------------------------------------------------------
 *
 * To Do
 * ~~~~~
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

/* ------------------------------------------------------------------------- *
 * Power supply screen
 */

void screenRenderTest1() {
  if (screenChange) {
    drawString("Volt", WHITE,  0, 55, 32);
    drawString("Amp",  WHITE, 64, 55, 32);
  }

  drawString("3.3V", BLACK, 32, 55, 32);
  drawString("1.5A", BLACK, 95, 55, 32);        // TODO: Used "95", not "96" :(
}

/* ------------------------------------------------------------------------- *
 * Wave generation screen
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

/* ------------------------------------------------------------------------- *
 * Scribble screen
 * ~~~~~~~~~~~~~~~
 * Drawing routine adapted from TellyMate scribble Video sketch
 * http://www.batsocks.co.uk/downloads/tms_scribble_001.pde
 */

float sr3_g_head_pos = 0.0;

void screenRenderTest3() {
  const int duration = 100;  // milliseconds
  const float tick = 1 / 128.0;
 
  for (unsigned long start = millis();  millis() - start < duration; ) {
    sr3_g_head_pos += tick;

    float head = sr3_g_head_pos;
    float tail = head - (256 * tick);

    // set the pixels at the 'head' of the line...
    byte x = fn_x(head);
    byte y = fn_y(head);
    GLCD.SetDot(x, y, BLACK);

    // clear the pixel at the 'tail' of the line...
    x = fn_x(tail);
    y = fn_y(tail); 
    GLCD.SetDot(x, y, WHITE);
  }
}

byte fn_x(float tick) {
  return (byte)
   (GLCD.Width/2 + (GLCD.Width/2-1) * sin(tick * 1.8) * cos(tick * 3.2));
}

byte fn_y(float tick) {
  return (byte)
    ((GLCD.Height-11) / 2 + ((GLCD.Height-11) / 2 - 1) *
      cos(tick * 1.2) * sin(tick * 3.1));
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
