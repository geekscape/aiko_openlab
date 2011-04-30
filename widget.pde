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

const byte potLabelLength = 6 * 3;              // 3 characters x 6 pixels wide

const byte potValueLength = 6 * 7;              // 7 characters x 6 pixels wide

/* ------------------------------------------------------------------------- */

void displayPotLabel(
  byte  potIndex,
  char *label) {                               // TODO: label could use PROGMEM

  byte x = (potIndex == 1)  ?  1  :  GLCD.Width / 2;
  byte y = GLCD.Height - 9;
  
  drawString(label, WHITE, x, y, potLabelLength);
}

/* ------------------------------------------------------------------------- */

void displayPotValue(
  byte  potIndex,
  char *value) {                               // TODO: value could use PROGMEM

  byte x = potValueLength + 1;
  if (potIndex > 1) x += GLCD.Width / 2;

  byte y = GLCD.Height - 9;

  drawString(value, BLACK, x, y, potLabelLength);
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
