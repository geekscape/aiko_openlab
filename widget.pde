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

void displayPotLabel(
  byte  potIndex,
  char *label) {                               // TODO: label could use PROGMEM

  byte x = (potIndex == 1)  ?  1  :  GLCD.Width / 2;
  byte y = GLCD.Height - 9;
  
  drawString(label, WHITE, x, y, POT_LABEL_LENGTH);
}

/* ------------------------------------------------------------------------- */

void displayPotValue(
  byte  potIndex,
  char *value) {                               // TODO: value could use PROGMEM

  byte x = POT_LABEL_LENGTH + 1;
  if (potIndex > 1) x += GLCD.Width / 2;
  byte y = GLCD.Height - 9;

  drawString(value, BLACK, x, y, POT_VALUE_LENGTH);
}

/* ------------------------------------------------------------------------- */

void displayPotValueNew(
  byte               potIndex,
  float              value,
  unsigned char      prec,
  char               *units){   //

  //byte y = GLCD.Height - 9;
  char val[12];

  dtostrf(value, 5, prec, val);
  //Serial.print(" value: ");
  //Serial.println(value);
  //Serial.print(" val: ");
  //Serial.println(val);
  strcat(val, units);
  //Serial.print(" val: ");
  //Serial.println(val);
  
  byte x = POT_LABEL_LENGTH + 1;
  if (potIndex > 1) x += GLCD.Width / 2;
  byte y = GLCD.Height - 9;

  drawString(val, BLACK, x, y, POT_VALUE_LENGTH);

 // if(pot == 1)
 //{
 // drawString(val, BLACK, POT_LABEL_LENGTH + 1, y, POT_VALUE_LENGTH);
 //}
 // else  
 //{   
 // drawString(val, BLACK, (GLCD.Width / 2) + POT_LABEL_LENGTH + 1, y, POT_VALUE_LENGTH);
 //}

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
