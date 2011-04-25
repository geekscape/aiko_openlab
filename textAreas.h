#ifndef textAreas_H
#define textAreas_H

#include "include/gText.h"

typedef enum  {
	/**<Upper GLCD display area */
	textAreaGRAPH = MK_TareaToken(0, 0, DISPLAY_WIDTH - 1, DISPLAY_HEIGHT - 10),

	/**<Screen Title */
	textAreaSCRTTLBDR = MK_TareaToken(0, 0, DISPLAY_WIDTH - 1, 9),

	/**<Screen Title Border*/
	textAreaSCRTTL = MK_TareaToken(1, 1, DISPLAY_WIDTH - 1, 8),

	/**<Screen Instructions area */
	textAreaHELP = MK_TareaToken(0, 10, DISPLAY_WIDTH - 1, DISPLAY_HEIGHT - 10),
        
	/**<Left-hand POT Label Border */
	textAreaPOTLBLBDR1 = MK_TareaToken(0, DISPLAY_HEIGHT - 9, 18, DISPLAY_HEIGHT),

	/**<Left-hand POT Label */
	textAreaPOTLBL1 = MK_TareaToken(1, DISPLAY_HEIGHT - 8, 18, DISPLAY_HEIGHT-1),

	/**<Left-hand POT value Border */
	textAreaPOTVALBDR1 = MK_TareaToken(19, DISPLAY_HEIGHT-9, 63, DISPLAY_HEIGHT),

	/**<Left-hand POT Value Display */
	textAreaPOTVAL1 = MK_TareaToken(21, DISPLAY_HEIGHT - 8, 63, DISPLAY_HEIGHT-1),

	/**<Right-hand POT Label Border */
	textAreaPOTLBLBDR2 = MK_TareaToken(64, DISPLAY_HEIGHT-9, 82, DISPLAY_HEIGHT),

	/**<Right-hand POT Label */
	textAreaPOTLBL2 = MK_TareaToken(65, DISPLAY_HEIGHT - 8, 82, DISPLAY_HEIGHT-1),

	/**<Right-hand POT Value Border */
	textAreaPOTVALBDR2 = MK_TareaToken(83, DISPLAY_HEIGHT-9, 127, DISPLAY_HEIGHT),

	/**<Right-hand POT Value Display */
	textAreaPOTVAL2 = MK_TareaToken(85, DISPLAY_HEIGHT-8, 127, DISPLAY_HEIGHT-1),
}
  predefinedLABArea;

class gLABText : public gText {
  public:
    gLABText();        // constructor for the class that inherits gText methods
    using gText::DefineArea;
    uint8_t DefineArea(
      predefinedLABArea selection,
      textMode mode=DEFAULT_SCROLLDIR
    );
}; 

#endif
