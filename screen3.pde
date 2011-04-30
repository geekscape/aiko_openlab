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

float sr3_g_head_pos = 0.0;

void screenRenderTest3() {
  gText textArea;

  const int duration = 100;  // milliseconds
  const float tick = 1 / 128.0;
  static byte titletimer;

  if (screenChange) {
    titletimer = 0;
    //drawString("Freq", WHITE,  0, 55, 32);
    displayPotLabel(1,"FRQ");
    //drawString("Amp",  WHITE, 64, 55, 32);
    displayPotLabel(2,"AMP");
  }
  
  titletimer++;
  if (titletimer > 12) {
    textArea.DefineArea(0, 0, GLCD.Width-1, 8);
    textArea.SelectFont(font, BLACK);
    textArea.ClearArea();
  }
 
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
