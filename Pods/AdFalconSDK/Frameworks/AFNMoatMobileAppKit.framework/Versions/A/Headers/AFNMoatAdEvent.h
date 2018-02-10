//
//  MoatAdEvent.h
//  MoatMobileAppKit
//
//  Created by Moat on 2/5/16.
//  Copyright © 2016 Moat. All rights reserved.
//
//  This class is simply a data object that encapsulates info relevant to a particular playback event.

#import <Foundation/Foundation.h>
#import "AFNMoatAdEventType.h"

static NSTimeInterval const AFNMoatTimeUnavailable = NAN;
static float const AFNMoatVolumeUnavailable = NAN;

@interface AFNMoatAdEvent : NSObject

@property (assign, nonatomic) AFNMoatAdEventType eventType;
@property (assign, nonatomic) NSTimeInterval adPlayhead;
@property (assign, nonatomic) float adVolume;
@property (assign, nonatomic, readonly) NSTimeInterval timeStamp;

- (id)initWithType:(AFNMoatAdEventType)eventType withPlayheadMillis:(NSTimeInterval)playhead;
- (id)initWithType:(AFNMoatAdEventType)eventType withPlayheadMillis:(NSTimeInterval)playhead withVolume:(float)volume;
- (NSDictionary *)asDict;
- (NSString *)eventAsString;

@end
