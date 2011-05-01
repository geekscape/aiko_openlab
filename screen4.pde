/* screen4.pde
 * ~~~~~~~~~~~
 * Please do not remove the following notices.
 * License: GPLv3. http://geekscape.org/static/arduino_license.html
 * ----------------------------------------------------------------------------
 *
 * Description
 * ~~~~~~~~~~~
 * George's test screen
 *
 * To Do
 * ~~~~~
 * - None, yet.
 */

 
void drawGeoAxes() {
  /*
  gText titleArea;
  titleArea.DefineArea(0, 0, GLCD.Width-1, 8);
  titleArea.SelectFont(font, BLACK);
  titleArea.ClearArea(); 
  */

  GLCD.DrawLine(10, (int)(GLCD.Height/2), GLCD.Width-10, (int)(GLCD.Height/2), BLACK); // Horizontal Line
  //GLCD.DrawHoriLine(10, (int)(GLCD.Height/2), GLCD.Width-10); // Horizontal Line- Doesn't appear to work due to compile errors
  GLCD.DrawLine((int)(GLCD.Width/2), 10, (int)(GLCD.Width/2), 50 , BLACK); // Vertical Line

}

void screenRenderTest4() {

  drawString("Volt", WHITE,  0, 55, 32);  
  if (screenChange) {
    drawGeoAxes();
    screenChange = false;
    GLCD.DrawLine(10, (int)(GLCD.Height/2), GLCD.Width-10, (int)(GLCD.Height/2), BLACK); // Horizontal Line
    //GLCD.DrawHoriLine(10, (int)(GLCD.Height/2), GLCD.Width-10); // Horizontal Line - Doesn't work
    GLCD.DrawLine((int)(GLCD.Width/2), 10, (int)(GLCD.Width/2), 50 , BLACK); // Vertical Line

  }

  //GLCD.DrawLine(0, 0, 100, 8, BLACK);


  //Serial.print("Test");
  int result=analogRead(PIN_ANALOG_INPUT);
  float volt= ((result*5.0)/1022);
  char test[7];
   
  dtostrf(volt, 3, 2, test);
  //Serial.print("DEBUG: ");
  //Serial.println(test);
  strcat(test, "V");
  drawString(test, BLACK, 32, 55, 32);
  delay(200);
}

