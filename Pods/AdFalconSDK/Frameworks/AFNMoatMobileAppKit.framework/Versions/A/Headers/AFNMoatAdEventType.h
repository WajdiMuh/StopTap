//
//  AFNMoatAdEventType.h
//  AFNMoatMobileAppKit
//
//  Created by Moat 740 on 3/27/17.
//  Copyright © 2017 Moat. All rights reserved.
//

#ifndef AFNMoatAdEventType_h
#define AFNMoatAdEventType_h

typedef enum AFNMoatAdEventType : NSUInteger {
    AFNMoatAdEventComplete
    , AFNMoatAdEventStart
    , AFNMoatAdEventFirstQuartile
    , AFNMoatAdEventMidPoint
    , AFNMoatAdEventThirdQuartile
    , AFNMoatAdEventSkipped
    , AFNMoatAdEventStopped
    , AFNMoatAdEventPaused
    , AFNMoatAdEventPlaying
    , AFNMoatAdEventVolumeChange
    , AFNMoatAdEventNone
} AFNMoatAdEventType;

#endif /* AFNMoatAdEventType_h */
