//
//  AFNMoatTrackerDelegate.h
//  AFNMoatMobileAppKit
//
//  Created by Moat 740 on 3/27/17.
//  Copyright © 2017 Moat. All rights reserved.
//

#import "AFNMoatAdEventType.h"

#ifndef AFNMoatTrackerDelegate_h
#define AFNMoatTrackerDelegate_h

typedef enum : NSUInteger {
    AFNMoatStartFailureTypeNone = 0, //Default none value
    AFNMoatStartFailureTypeActive,   //The tracker was already active
    AFNMoatStartFailureTypeRestart,  //The tracker was stopped already
    AFNMoatStartFailureTypeBadArgs,  //The arguments provided upon initialization or startTracking were invalid.
} AFNMoatStartFailureType;

@class AFNMoatBaseTracker;
@class AFNMoatBaseVideoTracker;

@protocol AFNMoatTrackerDelegate <NSObject>

@optional

/**
 Notifies delegate that the tracker has started tracking.
 */

- (void)trackerStartedTracking:(AFNMoatBaseTracker *)tracker;

/**
 Notifies delegate that the tracker has stopped tracking.
 */

- (void)trackerStoppedTracking:(AFNMoatBaseTracker *)tracker;

/**
 Notifies delegate that the tracker failed to start.
 
 @param type Type of startTracking failure.
 @param reason A human readable string on why the tracking failed.
 */

- (void)tracker:(AFNMoatBaseTracker *)tracker failedToStartTracking:(AFNMoatStartFailureType)type reason:(NSString *)reason;

@end

#pragma mark

@protocol AFNMoatVideoTrackerDelegate <NSObject>

@optional

/**
 Notifies delegate an ad event type is being dispatched (i.e. start, pause, quarterly events).
 
 @param adEventType The type of event fired.
 */
- (void)tracker:(AFNMoatBaseVideoTracker *)tracker sentAdEventType:(AFNMoatAdEventType)adEventType;

@end

#endif /* AFNMoatTrackerDelegate_h */
