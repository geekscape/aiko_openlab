/* screen6.pde
 * ~~~~~~~~~~~
 * Please do not remove the following notices.
 * License: GPLv3. http://geekscape.org/static/arduino_license.html
 * ----------------------------------------------------------------------------
 *
 * Description
 * ~~~~~~~~~~~
 * - None, yet.
 *
 * To Do
 * ~~~~~
 * - None, yet.
 */

#ifdef IGNORE
long Temp = 0;

void screenRenderTest6() {
  if (screenChange) {
    displayTempLabel("Tmp");
  }

  // Retreive Temperature value to display;
    //PIN_ANALOG_INPUT
    displayTempValue(readTemp(), 1, "C");
    delay(100);
}

long readTemp() {
  long result;
  // Read temperature sensor against 1.1V reference
  ADMUX = _BV(REFS1) | _BV(REFS0) | _BV(MUX3);
  delay(2); // Wait for Vref to settle
 ADCSRA |= _BV(ADSC); // Convert
  while (bit_is_set(ADCSRA,ADSC));
  result = ADCL;
  result |= ADCH<<8;
  result = (result - 125) * 1075;
  return result;
}
#endif

/* ------------------------------------------------------------------------- */
