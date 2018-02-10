//
//  ADFRewardedVideoAdDelegate.h
//  AdFalconSDK
//
//  Created by Emad Jabareen on 7/13/17.
//  Copyright © 2017 Noqoush Mobile Media Group. All rights reserved.
//


@class ADFRewardedVideoAd;
@protocol ADFRewardedVideoAdDelegate <NSObject>

@optional

- (void)rewardedVideoAdDidLoadAd:(ADFRewardedVideoAd*)rewardedVideoAd;
- (void)rewardedVideoAd:(ADFRewardedVideoAd*)rewardedVideoAd didRewardUserWithName:(NSString*) name amount:(NSInteger) amount;
- (void)rewardedVideoAd:(ADFRewardedVideoAd*)rewardedVideoAd didFailToLoadAdWithErrorCode:(NSInteger)errorCode message:(NSString*) message;


- (void)rewardedVideoAdDidShowAd:(ADFRewardedVideoAd*)rewardedVideoAd;
- (void)rewardedVideoAd:(ADFRewardedVideoAd*)rewardedVideoAd didFailToShowAdWithError:(NSError*) error;


- (void)rewardedVideoAdWillCloseAd:(ADFRewardedVideoAd*)rewardedVideoAd;
- (void)rewardedVideoAdDidCloseAd:(ADFRewardedVideoAd*)rewardedVideoAd;

- (void)rewardedVideoAdDidStartAd:(ADFRewardedVideoAd*)rewardedVideoAd;
- (void)rewardedVideoAdDidEndAd:(ADFRewardedVideoAd*)rewardedVideoAd;

- (void)rewardedVideoAdWillLeaveApplication:(ADFRewardedVideoAd*)rewardedVideoAd;


@end
