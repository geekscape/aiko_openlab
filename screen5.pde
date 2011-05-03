/* screen5.pde
 * ~~~~~~~~~~~
 * Please do not remove the following notices.
 * License: GPLv3. http://geekscape.org/static/arduino_license.html
 * ----------------------------------------------------------------------------
 *
 * Description
 * ~~~~~~~~~~~
 * Clock, stopwatch and timer.
 *
 * To Do
 * ~~~~~
 * - Stopwatch.
 * - Clock.
 * - Timer, which sets off the buzzer.
 */

//#include "fonts/SystemFont5x7.h"
#include "fonts/fixednums15x31.h"


int titlestoptimer = 0;                                   // TODO: Work in progress
const Font_t fontwatch = fixednums15x31;

void stopwatchHandler(void) {
  if (stopwatchRunning) stopwatchCounter ++;
}

void screenRenderTest5(void) {
  if (screenChange) {
    displayPotLabel(1, "Clk");
  }
  titlestoptimer ++;

  if (titletimer == 16) clearTitle();       // Approx 8 timer cycles per second

  float value = stopwatchCounter / 10.0;

  displayWatchValue(1, value, 1, "s");
}


void displayWatchValue(
byte           potIndex,   // Potentionmeter (knob) Identifier Index
float          value,      // Output value
unsigned char  precision,  // Decimal point precision
char           *units) {   // Measurement unit appended to value

  char buffer[12];

  dtostrf(value, 5, precision, buffer);
  strcat(buffer, units);

  // TODO: Confirm why +2 was required, not +1 (accounyting for 1 not 0 start ?)
  //byte x = POT_LABEL_LENGTH + 2;
  //if (potIndex == 2) x += GLCD.Width / 2;

  //byte y = GLCD.Height - 9;

  //drawString(buffer, BLACK, x, y, POT_VALUE_LENGTH);

  gText textArea;

  textArea.DefineArea(30, 20, 100, 50 );
  textArea.SelectFont(fontwatch, BLACK); //FIXME! Was FONT (error with not declared messa)
  textArea.ClearArea();
  
  textArea.DrawString(buffer, 1, 1);

}

