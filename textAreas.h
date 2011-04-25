#ifndef textAreas_H
#define textAreas_H

#include "include/gText.h"

//#include <Wprogram.h>
//#include "device/ks0108_Device.h"
//#define DISPLAY_WIDTH 255
//#define DISPLAY_HEIGHT 64


typedef enum  {

	textAreaGRAPH         = MK_TareaToken( 0,              0,                 DISPLAY_WIDTH -1,   DISPLAY_HEIGHT -10),
	/**<Upper GLCD display area */

	textAreaPOTLBLBDR1       = MK_TareaToken( 0,              DISPLAY_HEIGHT -9,               18,   DISPLAY_HEIGHT),
	/**<Left-hand POT Label Border*/
	textAreaPOTLBL1       = MK_TareaToken( 1,             DISPLAY_HEIGHT -8,               18,   DISPLAY_HEIGHT -1 ),
	/**<Left-hand POT Label */
	textAreaPOTVALBDR1       = MK_TareaToken( 19,              DISPLAY_HEIGHT -9,               63,   DISPLAY_HEIGHT),
	/**<Left-hand POT Label Border*/
	textAreaPOTVAL1       = MK_TareaToken( 21,              DISPLAY_HEIGHT -8,               63,   DISPLAY_HEIGHT -1),
	/**<Left-hand POT Label */

	textAreaPOTLBLBDR2       = MK_TareaToken( 64,             DISPLAY_HEIGHT -9,               82,   DISPLAY_HEIGHT),
	/**<Left-hand POT Label Border*/
	textAreaPOTLBL2       = MK_TareaToken(65,             DISPLAY_HEIGHT -8,               82,   DISPLAY_HEIGHT -1 ),
	/**<Right-hand POT Label */
	textAreaPOTVALBDR2       = MK_TareaToken( 83,              DISPLAY_HEIGHT -9,              127,   DISPLAY_HEIGHT),
	/**<Left-hand POT Label Border*/
	textAreaPOTVAL2       = MK_TareaToken(85,              DISPLAY_HEIGHT -8,              127,   DISPLAY_HEIGHT -1),
	/**<Right-hand POT Label */

} predefinedLABArea;

class gLABText : public gText
{
    public:
      gLABText();  // constructor for the class that inherits gText methods
      using gText::DefineArea;
      uint8_t DefineArea(predefinedLABArea selection, textMode mode=DEFAULT_SCROLLDIR);
}; 

#endif
