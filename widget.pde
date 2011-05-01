/* widget.pde
 * ~~~~~~~~~~
 * Please do not remove the following notices.
 * License: GPLv3. http://geekscape.org/static/arduino_license.html
 * ----------------------------------------------------------------------------
 *
 * To Do
 * ~~~~~
 * - None, yet.
 */

const byte POT_LABEL_LENGTH = 6 * 3;            // 3 characters x 6 pixels wide
const byte POT_VALUE_LENGTH = 6 * 7;            // 7 characters x 6 pixels wide

/* ------------------------------------------------------------------------- */

void displayHelpText(
  char *helpText) {                         // TODO: helpText could use PROGMEM

  gText helpArea;
  
  helpArea.DefineArea(0, 11, GLCD.Width - 1, 54);
  helpArea.SelectFont(FONT, BLACK);
  helpArea.DrawString_P(helpText, 0, 0);
}

/* ------------------------------------------------------------------------- */

void displayPotLabel(
  byte  potIndex,
  char *label) {                               // TODO: label could use PROGMEM

  byte x = (potIndex == 1)  ?  1  :  GLCD.Width / 2;
  byte y = GLCD.Height - 9;
  
  drawString(label, WHITE, x, y, POT_LABEL_LENGTH);
}

/* ------------------------------------------------------------------------- */

void displayPotValue(
  byte           potIndex,   // Potentionmeter (knob) Identifier Index
  float          value,      // Output value
  unsigned char  precision,  // Decimal point precision
  char           *units) {   // Measurement unit appended to value

  char buffer[12];

  dtostrf(value, 5, precision, buffer);
  strcat(buffer, units);

  // TODO: Confirm why +2 was required, not +1 (accounting for 1 not 0 start ?)
  byte x = POT_LABEL_LENGTH + 2; 
  if (potIndex == 2) x += GLCD.Width / 2;

  byte y = GLCD.Height - 9;

  drawString(buffer, BLACK, x, y, POT_VALUE_LENGTH);
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
  textArea.SelectFont(FONT, colour);
  textArea.ClearArea();
  textArea.DrawString(value, 1, 1);
}

/* ------------------------------------------------------------------------- */
