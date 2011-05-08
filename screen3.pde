/* screen3.pde
 * ~~~~~~~~~~
 * Please do not remove the following notices.
 * License: GPLv3. http://geekscape.org/static/arduino_license.html
 * ----------------------------------------------------------------------------
 *
 * Description
 * ~~~~~~~~~~~
 * Scribble screen
 *
 * To Do
 * ~~~~~
 * - None, yet.
 */
#ifdef IGNORE
float sr3_g_head_pos = 0.0;

int titletimer = 0;                                   // TODO: Work in progress

void screenRenderTest3() {
  gText textArea;

  const int DURATION = 100;  // milliseconds
  const float TICK = 1 / 128.0;

  if (screenChange) {
    titletimer = 0;
    displayPotLabel(1, "Frq");
    displayPotLabel(2, "Amp");
  }

  // TODO: Retreive Pot inputs and set values to display;

  displayPotValue(1, pinPot1 --, 0, "V");
  displayPotValue(2, pinPot2 ++, 0, "mA");

  // Clear title after approx 2 seconds

  titletimer ++;
//if (titletimer == 16) clearTitle();       // Approx 8 timer cycles per second

  for (unsigned long start = millis();  millis() - start < DURATION; ) {
    sr3_g_head_pos += TICK;

    float head = sr3_g_head_pos;
    float tail = head - (256 * TICK);

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
#endif
