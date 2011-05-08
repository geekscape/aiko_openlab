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
 * - None, yet.
 */


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

int pot1Index = 0;
int pot2Index = 0;

//int analoginput = 0;
float vout = 0.0;
int value = 0;
float R1 = 10000.0;    // !! resistance of R1 !!
float R2 = 3300.0;     // !! resistance of R2 !!
float vin = 0.0;

void screenRenderTest1() {
  if (screenChange) {
    displayPotLabel(1, "Rng");
    pinPot1 = 0;  // Test only

    displayPotLabel(2, "Mde");
    pinPot2 = 0;  // Test only   

    //PIN_ANALOG_INPUT
    pinMode(PIN_ANALOG_INPUT, INPUT);
    //lcd.begin(16, 2);
    delay(100);
  }

  // TODO: Retreive Pot inputs and set values to display;

  displayPotSelect(1, pot1Options[pot1Index]);
  displayPotSelect(2, pot2Options[pot2Index]);
}


void screenVoltMeter() {
//#include <LiquidCrystal.h>
//LiquidCrystal lcd(4, 5, 6, 9, 10, 11, 12);


 // read the value on analog input
 value = analogRead(PIN_ANALOG_INPUT);
 vout= (value * 5.0)/1024.0;  //voltage coming out of the voltage divider
 vin = vout / (R2/(R1+R2));  //voltage to display
 
   
 //lcd.setCursor(0,0);
 //lcd.println(vin, 1);   //Print float "vin" with 1 decimal
 
 //lcd.setCursor(11,0);
 //lcd.print("Volts");
 
 
delay(1400);

}

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

