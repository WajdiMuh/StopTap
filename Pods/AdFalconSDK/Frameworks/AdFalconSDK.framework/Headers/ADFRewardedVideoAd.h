//
//  ADFRewardedVideoAd.h
//  AdFalconSDK
//
//  Created by Emad Jabareen on 7/13/17.
//  Copyright © 2017 Noqoush Mobile Media Group. All rights reserved.
//

#import "ADFVASTController.h"
#import <Foundation/Foundation.h>
#import "ADFRewardedVideoAdDelegate.h"



@interface ADFRewardedVideoAd : ADFVASTController
@property(nonatomic, weak) NSObject<ADFRewardedVideoAdDelegate> * delegate;
@property(nonatomic, assign) BOOL logging;

-(void) showWithViewController:(UIViewController *)rootViewController;
@end
