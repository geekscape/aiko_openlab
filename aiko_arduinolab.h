/* aiko_arduinolab.h
 * ~~~~~~~~~~~~~~~~~
 * Please do not remove the following notices.
 * License: GPLv3. http://geekscape.org/static/arduino_license.html
 * ----------------------------------------------------------------------------
 *
 * To Do
 * ~~~~~
 * None, yet !
 */

// Allocate strings in Flash program memory to save RAM

#include <avr/pgmspace.h>
#define PROGSTRING(name) static const prog_char name[] PROGMEM

// Serial communications speed

const long DEFAULT_BAUD_RATE = 38400;

/* ------------------------------------------------------------------------- */
// Digital Input/Output pins

const int PIN_SERIAL_RX        =  0;  // In:  USB or ZigBee receive
const int PIN_SERIAL_TX        =  1;  // Out: USB or ZigBee transmit
const int PIN_LCD_STROBE       =  2;  // Out: LCD shift-register strobe
const int PIN_SPEAKER          =  3;  // Out: Speaker (PWM)
const int PIN_LCD_DATA         =  4;  // Out: LCD shift-register data
const int PIN_LCD_BACKLIGHT    =  5;  // Out: LCD backlight (PWM)
const int PIN_POWER_CONTROL    =  6;  // Out: Power supply control (PWM)
const int PIN_LCD_CLOCK        =  7;  // Out: LCD shift-register clock
const int PIN_FREQUENCY        =  8;  // In:  Frequency measurement
const int PIN_OUTPUT_1         =  9;  // Out: Channel 1 output (PWM)
const int PIN_OUTPUT_2         = 10;  // Out: Channel 2 output (PWM)
const int PIN_OUTPUT_3         = 11;  // Out: Channel 3 output (PWM)
const int PIN_AN_MUX_SELECT    = 12;  // Out: Analog multiplexer select
const int PIN_ZIGBEE_SLEEP     = 13;  // Out: ZigBee sleep control

// Analog Input pins

const int PIN_ANALOG_INPUT     = 0;   // In:  Direct analog
const int PIN_AN_MUX_INPUT_X   = 1;   // In:  Analog multiplexer X
const int PIN_AN_MUX_INPUT_Y   = 2;   // In:  Analog multiplexer Y
const int PIN_BUTTONS          = 3;   // In:  6-way navigation buttons
const int PIN_LCD_ENABLE       = 4;   // Out: LCD shift-register output enable
const int PIN_LCD_BUSY         = 5;   // In:  LCD data pin 7 (busy)
const int PIN_POWER_AMP_OUTPUT = 6;   // In:  Power supply current output
const int PIN_POWER_AMP_INPUT  = 7;   // In:  Power supply current input

/* ------------------------------------------------------------------------- */

// Application options

// #define APPLICATION_SINE_WAVE  // Experimental

// Useful macros

#define cycleIncrement(index, increment, maximum)  \
  index = (index + increment) % maximum
