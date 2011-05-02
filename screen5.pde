/* screen5.pde
 * ~~~~~~~~~~~
 * Please do not remove the following notices.
 * License: GPLv3. http://geekscape.org/static/arduino_license.html
 * ----------------------------------------------------------------------------
 *
 * Description
 * ~~~~~~~~~~~
 * Clock, stopwatch and timer.
 *
 * To Do
 * ~~~~~
 * - Stopwatch.
 * - Clock.
 * - Timer, which sets off the buzzer.
 */

long    stopwatchCounter = 0;
boolean stopwatchRunning = true;

void stopwatchHandler(void) {
  if (stopwatchRunning) stopwatchCounter ++;
}

void screenRenderTest5(void) {
  if (screenChange) {
    displayPotLabel(1, "Clk");
  }

  float value = stopwatchCounter / 10.0;
  displayPotValue(1, value, 1, "s");
}
