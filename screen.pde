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
#include "textAreas.h"

#include "fonts/SystemFont5x7.h"

gLABText textArea;              // a text area to be defined later in the sketch
//gLABText textAreaArray[3];      // an array of text areas  


byte screenInitialized = false;

uint8_t NIL = 0x9E; // Reference Value to pass if no colour desired (not BLACK or WHITE)
char* help_text=""; // variable to hold instruction/ help text to display on screen
static int  iscreen=0; // Screen Demo Routine counter


void screenInitialize(void) {
  GLCD.Init();
  GLCD.SelectFont(System5x7);

  screenInitialized = true;
}

void displayDemo() {

  //Serial.println("displayDemo Start");
  iscreen++;
  if (iscreen >= 10)
    iscreen=0;
    //textAreaDemo();

  switch(iscreen) {
    case 0 : displaySplashScreen(cchs_logo); delay(4000);   break;
    case 1 : displayScreen1();               delay(8000);   break;
    case 2 : displayScreen2();            scribble(8000);   break;
    case 3 : displayScreen3();               delay(4000);   break;
  } 
  //Serial.println("displayDemo End");
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


/* ------------------------------------------------------------------------- */

void displayScreen1() {

  if (! screenInitialized) screenInitialize();
  
  setupScreen1(); 
  //textArea.DefineArea(textAreaGRAPH);
  
  textArea.DefineArea(19,              DISPLAY_HEIGHT -9,               63,   DISPLAY_HEIGHT);
  textArea.SetFontColor(BLACK); 
  textArea.ClearArea(); 
  textArea.DefineArea(21,              DISPLAY_HEIGHT -8,               63,   DISPLAY_HEIGHT -1);
  textArea.print("1.5A");
  
  textArea.DefineArea(83,              DISPLAY_HEIGHT -9,              127,   DISPLAY_HEIGHT);
  textArea.SetFontColor(BLACK); 
  textArea.ClearArea(); 
  textArea.DefineArea(85,              DISPLAY_HEIGHT -8,              127,   DISPLAY_HEIGHT -1);
  textArea.print("3.3V");
  
}

/* ------------------------------------------------------------------------- */

void displayScreen2() {

  if (! screenInitialized) screenInitialize();

  help_text="This screen is used "
            "for generating wave "
            "forms that can be "
            "output as sound via "
            "the speaker output "
            " 123456789 123456789 ";
  setupScreen2(); 
  textArea.DefineArea(textAreaGRAPH);
  textArea.SetFontColor(BLACK); 
  textArea.ClearArea(); 
  textArea.print(help_text);
  delay(4000);
  textArea.ClearArea(); 
  setPotValue(textAreaPOTVAL1, "2", "Mhz", BLACK, true);
  setPotValue(textAreaPOTVAL2, "500", "mA", BLACK, true);
}

/* ------------------------------------------------------------------------- */

void displayScreen3() {

  if (! screenInitialized) screenInitialize();

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

/* ------------------------------------------------------------------------- */

void setupScreen1() {

  GLCD.ClearScreen();
  textArea.DefineArea(textAreaGRAPH);
  textArea.SetFontColor(BLACK); 
  textArea.ClearArea();

  textArea.SelectFont(System5x7);

  textArea.DefineArea( 0,              0,                  DISPLAY_WIDTH ,   DISPLAY_HEIGHT -12);
  textArea.SetFontColor(BLACK); 
  textArea.ClearArea(); 
  textArea.DefineArea( 0,              DISPLAY_HEIGHT -11, DISPLAY_WIDTH ,   DISPLAY_HEIGHT);
  textArea.SetFontColor(BLACK); 
  textArea.ClearArea(); 
  
  textArea.DefineArea(0,              DISPLAY_HEIGHT -9,               18,   DISPLAY_HEIGHT);
  textArea.SetFontColor(WHITE); 
  textArea.ClearArea(); 
  textArea.DefineArea(1,              DISPLAY_HEIGHT -8,               18,   DISPLAY_HEIGHT -1);
  textArea.print("AMP");
  
  textArea.DefineArea( 64,             DISPLAY_HEIGHT -9,               82,   DISPLAY_HEIGHT);
  textArea.SetFontColor(WHITE); 
  textArea.ClearArea(); 
  textArea.DefineArea( 65,             DISPLAY_HEIGHT -8,               82,   DISPLAY_HEIGHT-1);
  textArea.print("VLT");

}

/* ------------------------------------------------------------------------- */

void setupScreen2() {

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

/* ------------------------------------------------------------------------- */

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

/* ------------------------------------------------------------------------- */

void setLabel(predefinedLABArea area, char * label, uint8_t color, boolean cleararea) {

  textArea.DefineArea(area);
  textArea.SelectFont(System5x7);

  if (color != NIL){
    textArea.SetFontColor(color);
  }
  if (cleararea){
    textArea.ClearArea();
  }
  if (label != ""){
    textArea.print(label);
  }
  
}

/* ------------------------------------------------------------------------- */

void setPotValue(predefinedLABArea area, char * value, char * units, uint8_t color, boolean cleararea) {

  textArea.DefineArea(area);
  if (color != NIL){
    textArea.SetFontColor(color);
  }
  if (cleararea){
    textArea.ClearArea();
  }
  if (value != ""){
    textArea.print(value);
  }
  if (units != ""){
    textArea.print(units);
  }
  
}

/* ------------------------------------------------------------------------- */

/*
 * scribble drawing routine adapted from TellyMate scribble Video sketch
 * http://www.batsocks.co.uk/downloads/tms_scribble_001.pde
 */
void scribble( const unsigned int duration )
{
  const  float tick = 1/128.0;
  float g_head_pos = 0.0;
  
  for(unsigned long start = millis();  millis() - start < duration; )
  {
    g_head_pos += tick ;

    float head = g_head_pos ;
    float tail = head - (256 * tick) ;

    // set the pixels at the 'head' of the line...
    byte x = fn_x( head ) ;
    byte y = fn_y( head ) ;
    GLCD.SetDot( x , y , BLACK) ;

    // clear the pixel at the 'tail' of the line...
    x = fn_x( tail ) ;
    y = fn_y( tail ) ;  
     GLCD.SetDot( x , y , WHITE) ;
  }
}

byte fn_x( float tick )
{
  return (byte)(GLCD.Width/2 + (GLCD.Width/2-1) * sin( tick * 1.8 ) * cos( tick * 3.2 )) ;
}

byte fn_y( float tick )
{
  return (byte)((GLCD.Height-11)/2 + ((GLCD.Height-11)/2 -1) * cos( tick * 1.2 ) * sin( tick * 3.1 )) ;
}

/* ------------------------------------------------------------------------- */


