/* screen1.pde
 * ~~~~~~~~~~~
 * Please do not remove the following notices.
 * License: GPLv3. http://geekscape.org/static/arduino_license.html
 * ----------------------------------------------------------------------------
 *
 * Description
 * ~~~~~~~~~~~
 * Multimeter screen
 *
 * To Do
 * ~~~~~
 * - What should changing into the mV setting do? Show more decimal places?
 *     Change ADCREF to 1.1V to take higher resolution measurements?
 * - Currently, it shows support for AC readings.  Does that make sense? Can we measure AC?
 */

// This is where the voltage output gets written
byte displayOutputRow = 1;
byte displayOutputColumn = 4;

int pinPot1 = 0;
int pinPot2 = 0;

char *pot1Options[] = {
  "mV", "V"
};
char *pot2Options[] = {
  "DC", "AC"
};

const byte POT1_OPT_COUNT = sizeof(pot1Options) / sizeof(char);
const byte POT2_OPT_COUNT = sizeof(pot2Options) / sizeof(char);

// Set the pot indicies to -1 so they are forced to refresh
//  on startup if it starts on this screen, since the label
//  only refreshes when the value changes
int pot1Index = -1;
int newPot1Index = 0;
int pot2Index = -1;
int newPot2Index = 0;

//int analoginput = 0;
float vout = 0.0;
int value = 0;
float R1 = 10000.0;    // !! resistance of R1 !!
float R2 = 3300.0;     // !! resistance of R2 !!
float vin = 0.0;

void screenVoltMeter() {
  // Display the labels for the pots on the first frame we show this screen
  if (screenChange) {
    displayPotLabel(1, "Rng");

    displayPotLabel(2, "Mde");

    pinMode(PIN_ANALOG_INPUT, INPUT);
    //lcd.begin(16, 2);
    delay(100);
  }

  // Read the Pot inputs, and using that information, change
  //  if we are reading mV or V, and if we're reading DC or AC
  int potValue = readPot(1);
  if (potValue >= 512) newPot1Index = 1;
  else newPot1Index = 0;
  
  potValue = readPot(2);
  if (potValue >= 512) newPot2Index = 1;
  else newPot2Index = 0;
  
  if (newPot1Index != pot1Index){
    pot1Index = newPot1Index;
    displayPotSelect(1, pot1Options[pot1Index]);
  }
  if (newPot2Index != pot2Index){
    pot2Index = newPot2Index;
    displayPotSelect(2, pot2Options[pot2Index]);
  }
  
  // Now calculate the voltage
  // read the value on analog input
  value = analogRead(PIN_ANALOG_INPUT);
  vout = (value * 5.0)/1024.0;  //voltage coming out of the voltage divider
  vin = vout / (R2/(R1+R2));  //voltage to display
  
  // And display it on the screen
  GLCD.CursorTo(displayOutputRow, displayOutputColumn);
  GLCD.SetFontColor(BLACK);
  GLCD.print(vin,2);
}

// This function reads the Analog VCC?  I'm (Alan) not sure.
long readVcc() {
  long result;
  // Read 1.1V reference against AVcc
  ADMUX = _BV(REFS0) | _BV(MUX3) | _BV(MUX2) | _BV(MUX1);
  delay(2); // Wait for Vref to settle
  ADCSRA |= _BV(ADSC); // Convert
  while (bit_is_set(ADCSRA,ADSC));
  result = ADCL;
  result |= ADCH<<8;
  result = 1126400L / result; // Back-calculate AVcc in mV
  return result;
}

/* ------------------------------------------------------------------------- */
