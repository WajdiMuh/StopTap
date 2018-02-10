//
//  ADFVASTController.h
//  AdFalconSDK
//
//  Created by Emad Jabareen on 7/10/17.
//  Copyright © 2017 Noqoush Mobile Media Group. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "ADFVASTControllerDelegate.h"


@class ADFTargetingParams;
@interface ADFVASTController : NSObject<ADFVASTControllerDelegate>

-(void) loadAdWithSiteID:(NSString*) siteID targetingParams:(ADFTargetingParams*) targetingParams;
-(void) cancel;
-(BOOL) isReady;
-(void) showWithViewController:(UIViewController*) rootViewController completion:(void (^)(void))completion;

-(void) pauseRequest;
-(void) resumeRequest;
-(void) destroyRequest;
@end
