/*****************************************************************
 *  App42Leaderboard.h
 *  App42LeaderboardSample
 *
 *  Created by Rajeev Ranjan on 03/02/15.
 *  Copyright (c) 2015 Shephertz Technologies. All rights reserved.
 *****************************************************************/

#import <Foundation/Foundation.h>
//#import "App42Leaderboard_Ext.h"

/***
 * App42LeaderboardType provide options to choose the type of leaderboard need to be shown
 */
typedef enum : NSUInteger {
    kApp42_DateRange,           //It shows date bsed leaderbaords like today's, last week etc.
    kApp42_Social,              //It shows Social leaderboard like FB friends scores, rank among all users i.e. Global etc.
    kApp42_UserStandings,       //Current user scores
} App42LeaderboardType;

/***
 * Block to be used as completion handler
 */
typedef void (^App42LeaderboardResponse)(BOOL success, NSError *error);

@interface App42Leaderboard : NSObject

@property(nonatomic) App42LeaderboardType leaderboardType; //The property to define type of leaderboard need to be loaded

@property(nonatomic) NSInteger numberOfRecords; //How many records in the leaderboard
@property(nonatomic) NSString *gameName; //Your game name created on AppHQ
@property(nonatomic) NSString *userName; //Your user name
@property(nonatomic) NSString *fbAccessToken; // FB access token needed to fetch friend's leaderboard

/***
 * Singleton instance
 */
+(instancetype)sharedInstance;

/***
 * Sends requests to load fetch leaderboard depending upon the settings done
 */
-(void)fetchLeaderboard:(App42LeaderboardResponse)completionBlock;

/***
 * Launches leaderboard UI, recommended to call after successful completion of "fetchLeaderboard"
 */
-(void)launchLeaderboard:(id)controller;

@end
