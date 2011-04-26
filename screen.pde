/* screen.pde
 * ~~~~~~~~~~
 * Please do not remove the following notices.
 * License: GPLv3. http://geekscape.org/static/arduino_license.html
 * ----------------------------------------------------------------------------
 *
 * To Do
 * ~~~~~
 * - Use text areas, e.g. gText.DefineArea() ?
 * - Only clear screen as required, use a flag
 * - Only render screen as required, if an event has occurred ?
 * - Only display title/menu as required, up-to 10 seconds after screen change ?
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
  "1] Power Supply", screenRenderTest1,
//"2] Screen 2",     screenRenderTest2,
//"3] Screen 3",     screenRenderTest3
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

void screenChangeHandler(void) {
  currentScreen = (currentScreen + 1) % screenCount;
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
/* Power supply screen
 */

void screenRenderTest1() {
  gText textArea;

  if (screenChange) {
    drawLabel("Volt", WHITE,  0, 55, 32);
    drawLabel("Amp",  WHITE, 64, 55, 32);
  }

  drawLabel("3.3V", BLACK, 32, 55, 32);
  drawLabel("1.5A", BLACK, 95, 55, 32);   // TODO: Had to use "95", not "96" :(
}

/* ------------------------------------------------------------------------- */

void drawLabel(
  char     *label,                            // TODO: label should use PROGMEM
  uint8_t   colour,
  byte      x,
  byte      y,
  byte      w) {

  gText textArea;

  textArea.DefineArea(x, y, x + w, y + 8);
  textArea.SelectFont(font, colour);
  textArea.ClearArea();
  textArea.DrawString(label, 1, 1);
}

/* ------------------------------------------------------------------------- */
/*
  textAreaGRAPH = MK_TareaToken(0, 0, DISPLAY_WIDTH - 1, DISPLAY_HEIGHT - 10),
  textAreaSCRTTLBDR = MK_TareaToken(0, 0, DISPLAY_WIDTH - 1, 8),
  textAreaSCRTTL = MK_TareaToken(1, 1, DISPLAY_WIDTH - 1, 7),
  textAreaHELP = MK_TareaToken(0, 10, DISPLAY_WIDTH - 1, DISPLAY_HEIGHT - 10),
  textAreaPOTLBLBDR1 = MK_TareaToken(0, DISPLAY_HEIGHT - 9, 18, DISPLAY_HEIGHT),
  textAreaPOTLBL1 = MK_TareaToken(1, DISPLAY_HEIGHT - 8, 18, DISPLAY_HEIGHT-1),
  textAreaPOTVALBDR1 = MK_TareaToken(19, DISPLAY_HEIGHT-9, 63, DISPLAY_HEIGHT),
  textAreaPOTVAL1 = MK_TareaToken(21, DISPLAY_HEIGHT - 8, 63, DISPLAY_HEIGHT-1),
  textAreaPOTLBLBDR2 = MK_TareaToken(64, DISPLAY_HEIGHT-9, 82, DISPLAY_HEIGHT),
  textAreaPOTLBL2 = MK_TareaToken(65, DISPLAY_HEIGHT - 8, 82, DISPLAY_HEIGHT-1),
  textAreaPOTVALBDR2 = MK_TareaToken(83, DISPLAY_HEIGHT-9, 127, DISPLAY_HEIGHT),
  textAreaPOTVAL2 = MK_TareaToken(85, DISPLAY_HEIGHT-8, 127, DISPLAY_HEIGHT-1),

void displayScreen2() {
  char *help_text="This screen is used "
            "for generating wave "
            "forms that can be   "
            "output as sound via "
            "the speaker output  ";

  setupScreen2(); 
  textArea.DefineArea(textAreaHELP);
  textArea.SetFontColor(BLACK); 
  textArea.ClearArea(); 
  textArea.print(help_text);
  delay(8000);
  textArea.DefineArea(textAreaGRAPH);
  textArea.SetFontColor(BLACK); 
  textArea.ClearArea(); 

  setPotValue(textAreaPOTVAL1,   "2", "Mhz", BLACK, true);
  setPotValue(textAreaPOTVAL2, "500",  "mA", BLACK, true);
}
 */

/* ------------------------------------------------------------------------- */
/*
void setupScreen2() {
  GLCD.ClearScreen();
  setLabel(textAreaSCRTTLBDR,"",WHITE,true);
  setLabel(textAreaSCRTTL,"2 - Wave Generator",WHITE,false);

  textArea.DefineArea(textAreaHELP);
  textArea.SetFontColor(BLACK); 
  textArea.ClearArea();

  setLabel(textAreaPOTLBLBDR1,"",WHITE,true);
  setLabel(textAreaPOTLBL1,"FRQ",WHITE,false);
  setLabel(textAreaPOTVALBDR1,"",BLACK,true);
  setLabel(textAreaPOTLBLBDR2,"",WHITE,true);
  setLabel(textAreaPOTLBL2,"AMP",WHITE,false);
  setLabel(textAreaPOTVALBDR2,"",BLACK,true);
}
 */

/* ------------------------------------------------------------------------- */
/*
void displayScreen3() {
  setupScreen3(); 
  setPotValue(textAreaPOTVAL1, "2000", "Khz", BLACK, true);
  setPotValue(textAreaPOTVAL2, "1500", "mA", BLACK, true);
  textArea.DefineArea(textAreaGRAPH);
  textArea.SetFontColor(BLACK); 

  textArea.ClearArea(); 
  textArea.print("This screen is used for generating wave forms");
  delay(4000);

  textArea.ClearArea(); 
}
 */

/* ------------------------------------------------------------------------- */
/*
void setupScreen3() {
  GLCD.ClearScreen(); 
  textArea.DefineArea(textAreaGRAPH);
  textArea.SetFontColor(BLACK); 
  textArea.ClearArea();

  setLabel(textAreaPOTLBLBDR1,"",WHITE,true);
  setLabel(textAreaPOTLBL1,"FRQ",WHITE,false);
  setLabel(textAreaPOTVALBDR1,"",BLACK,true);
  setLabel(textAreaPOTLBLBDR2,"",WHITE,true);
  setLabel(textAreaPOTLBL2,"AMP",WHITE,false);
  setLabel(textAreaPOTVALBDR2,"",BLACK,true);
}
 */

/* ------------------------------------------------------------------------- */
/*
void setPotValue(
  predefinedLABArea area,
  char * value,
  char * units,
  uint8_t color,
  boolean cleararea) {

  textArea.DefineArea(area);

  textArea.SetFontColor(color);

  if (cleararea) textArea.ClearArea();

  if (value != "") textArea.print(value);

  if (units != "") textArea.print(units);
}
 */

/* ------------------------------------------------------------------------- */
/*
 * scribble drawing routine adapted from TellyMate scribble Video sketch
 * http://www.batsocks.co.uk/downloads/tms_scribble_001.pde
 */
/*
void scribble(
  const unsigned int duration) {

  const float tick = 1 / 128.0;
  float g_head_pos = 0.0;
  
  for (unsigned long start = millis();  millis() - start < duration; ) {
    g_head_pos += tick;

    float head = g_head_pos;
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
 */
/* ------------------------------------------------------------------------- */
