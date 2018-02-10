//
//  ADFVASTControllerDelegate.h
//  AdFalconSDK
//
//  Created by Emad Jabareen on 7/13/17.
//  Copyright © 2017 Noqoush Mobile Media Group. All rights reserved.
//

#import <Foundation/Foundation.h>

@class ADFVASTConnManager;
@class ADFVASTResponse;
@class ADFVASTPlayerViewController;
@class ADFVASTCompanionAd;

@protocol ADFVASTControllerDelegate <NSObject>
@required

-(void) connManagerWillLoadAd:(ADFVASTConnManager*) connManager;
-(BOOL) connManagerWillWrapAd:(ADFVASTConnManager*) connManager;
-(void) connManagerDidWrapAd:(ADFVASTConnManager*) connManager;
-(void) connManager:(ADFVASTConnManager*) connManager didLoadAd:(ADFVASTResponse*) response;
-(void) connManager:(ADFVASTConnManager*) connManager failedToLoadAdWithErrorCode:(NSInteger) errorCode message:(NSString*) message;

-(void) vastPlayerDidStart:(ADFVASTPlayerViewController*) player;
-(void) vastPlayerDidShowThirdQuartile:(ADFVASTPlayerViewController*) player;
-(void) vastPlayerDidComplete:(ADFVASTPlayerViewController*) player;
-(void) vastPlayer:(ADFVASTPlayerViewController*) player didFailToPlayWithError:(NSError*) error;
-(void) vastPlayer:(ADFVASTPlayerViewController*) player userDidClickAtCompanion:(ADFVASTCompanionAd*) companion;
-(void) vastPlayerWillLeaveApplication:(ADFVASTPlayerViewController*) player;
-(void) vastPlayerWillCloseAd:(ADFVASTPlayerViewController*) player;
-(void) vastPlayerDidCloseAd:(ADFVASTPlayerViewController*) player;

@optional

@end
