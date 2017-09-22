//
//  App42Leaderboard.m
//  App42LeaderboardSample
//
//  Created by Rajeev Ranjan on 03/02/15.
//  Copyright (c) 2015 Rajeev Ranjan. All rights reserved.
//

#import "App42Leaderboard.h"
#import <Shephertz_App42_iOS_API/Shephertz_App42_iOS_API.h>
#import "App42LeaderboardViewController.h"
#import "App42Leaderboard_Ext.h"

@interface App42Leaderboard ()
{
    ScoreBoardService *scoreboardService; // Instance of App42 ScoreBoardService
}

/***
 * Declassifies date-based leaderboard and redirects call to server
 */
-(void)fetchDateBasedLeaderboard:(App42LeaderboardResponse)completionBlock;

/***
 * Declassifies social leaderboard and redirects call to server
 */
-(void)fetchSocialLeaderboard:(App42LeaderboardResponse)completionBlock;

/***
 * Sends request to fetch todays scores of different users of same game
 */
-(void)fetchTodaysLeaderboardData:(App42LeaderboardResponse)completionBlock;

/***
 * Sends request to fetch last week scores of different users of same game
 */
-(void)fetchLastWeekLeaderboardData:(App42LeaderboardResponse)completionBlock;

/***
 * Sends request to fetch last month scores of different users of same game
 */
-(void)fetchLastMonthLeaderboardData:(App42LeaderboardResponse)completionBlock;

/***
 * Sends request to fetch all scores of current user for same game
 */
-(void)fetchUserScores:(App42LeaderboardResponse)completionBlock;

/***
 * Sends request to fetch scores of all users of same game
 */
-(void)fetchGlobalLeaderboardData:(App42LeaderboardResponse)completionBlock;

/***
 * Sends request to fetch scores of facebook friends of same game
 */
-(void)fetchFBFriendsLeaderboardData:(App42LeaderboardResponse)completionBlock;


@end

@implementation App42Leaderboard

+(instancetype)sharedInstance
{
    static App42Leaderboard *_sharedInstance;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedInstance = [[self alloc] init];
    });
    return _sharedInstance;
}

-(instancetype)init
{
    if (self=[super init])
    {
        scoreboardService = [App42API buildScoreBoardService];
        /**
         * Default Settings
         */
        self.dateBasedLeaderboardType = kApp42_Today; // Setting default sub-type for datebased leaderboard
        self.socialLeaderboardType = kApp42_Global; // Setting default sub-type for social leaderboard
        self.fbAccessToken = @"";
    }
    return self;
}


#pragma mark- Fetching Data

-(void)fetchLeaderboard:(App42LeaderboardResponse)completionBlock
{
    switch (self.leaderboardType) {
        case kApp42_DateRange:
        {
            [self fetchDateBasedLeaderboard:^(BOOL success, NSError *error) { // redirecting call to identify sub-leaderboard
                NSLog(@"%s",__func__);
                completionBlock(success,error);
            }];
        }
            break;
        case kApp42_Social:
        {
            [self fetchSocialLeaderboard:^(BOOL success, NSError *error) { // redirecting call to identify sub-leaderboard
                NSLog(@"%s",__func__);
                completionBlock(success,error);
            }];
        }
            break;
        case kApp42_UserStandings:
        {
            [self fetchUserScores:^(BOOL success, NSError *error) {  // redirecting call to fetch self score
                NSLog(@"%s",__func__);
                completionBlock(success,error);
            }];
        }
            break;
            
        default:
            break;
    }
}

-(void)fetchDateBasedLeaderboard:(App42LeaderboardResponse)completionBlock
{
    switch (self.dateBasedLeaderboardType) {
        case kApp42_Today:
        {
            [self fetchTodaysLeaderboardData:^(BOOL success, NSError *error) {
                NSLog(@"%s",__func__);
                completionBlock(success,error);
            }];
        }
            break;
        case kApp42_Weekly:
        {
            [self fetchLastWeekLeaderboardData:^(BOOL success, NSError *error) {
                NSLog(@"%s",__func__);
                completionBlock(success,error);
            }];
        }
            break;
        case kApp42_Monthly:
        {
            [self fetchLastMonthLeaderboardData:^(BOOL success, NSError *error) {
                NSLog(@"%s",__func__);
                completionBlock(success,error);
            }];
        }
            break;
            
        default:
            break;
    }
}

-(void)fetchSocialLeaderboard:(App42LeaderboardResponse)completionBlock
{
    switch (self.socialLeaderboardType) {
        case kApp42_Friends:
        {
            [self fetchFBFriendsLeaderboardData:^(BOOL success, NSError *error) {
                completionBlock(success,error);
            }];
        }
            break;
        case kApp42_Global:
        {
            [self fetchGlobalLeaderboardData:^(BOOL success, NSError *error) {
                completionBlock(success,error);
            }];
        }
            break;
            
        default:
            break;
    }
}

-(void)fetchTodaysLeaderboardData:(App42LeaderboardResponse)completionBlock
{
    NSDate *startDate = [NSDate dateWithTimeIntervalSinceNow:-24*60*60];
    NSDate *endDate = [NSDate date];
    [scoreboardService getTopNRankers:self.gameName startDate:startDate endDate:endDate max:(int)self.numberOfRecords completionBlock:^(BOOL success, id responseObj, App42Exception *exception) {
        if (success)
        {
            Game *game = (Game*)responseObj;
            _scoreList = [game.scoreList copy];
            completionBlock(success,nil);
        }
        else
        {
            _scoreList = nil;
            
            NSError *error = [NSError errorWithDomain:[exception reason] code:[exception httpErrorCode] userInfo:[exception userInfo]];
            completionBlock(success,error);
        }
    }];
}

-(void)fetchLastWeekLeaderboardData:(App42LeaderboardResponse)completionBlock
{
    NSDate *startDate = [NSDate dateWithTimeIntervalSinceNow:-7*24*60*60];
    NSDate *endDate = [NSDate date];
    [scoreboardService getTopNRankers:self.gameName startDate:startDate endDate:endDate max:(int)self.numberOfRecords completionBlock:^(BOOL success, id responseObj, App42Exception *exception) {
        if (success)
        {
            Game *game = (Game*)responseObj;
            _scoreList = [game.scoreList copy];
            
            completionBlock(success,nil);
        }
        else
        {
            _scoreList = nil;
           
            NSError *error = [NSError errorWithDomain:[exception reason] code:[exception httpErrorCode] userInfo:[exception userInfo]];
            completionBlock(success,error);
        }
    }];
}

-(void)fetchLastMonthLeaderboardData:(App42LeaderboardResponse)completionBlock
{
    NSDate *startDate = [NSDate dateWithTimeIntervalSinceNow:-30*24*60*60];
    NSDate *endDate = [NSDate date];
    [scoreboardService getTopNRankers:self.gameName startDate:startDate endDate:endDate max:(int)self.numberOfRecords completionBlock:^(BOOL success, id responseObj, App42Exception *exception) {
        if (success)
        {
            Game *game = (Game*)responseObj;
            _scoreList = [game.scoreList copy];
            
            completionBlock(success,nil);
        }
        else
        {
            _scoreList = nil;
            
            NSError *error = [NSError errorWithDomain:[exception reason] code:[exception httpErrorCode] userInfo:[exception userInfo]];
            completionBlock(success,error);
        }
    }];
}


-(void)fetchUserScores:(App42LeaderboardResponse)completionBlock
{
    NSMutableDictionary *otherMetaHeaders = [NSMutableDictionary dictionaryWithObjectsAndKeys:@"score",@"orderByAscending", nil];
    [scoreboardService setOtherMetaHeaders:otherMetaHeaders];
    [scoreboardService getScoresByUser:self.gameName gameUserName:self.userName completionBlock:^(BOOL success, id responseObj, App42Exception *exception) {
        if (success)
        {
            Game *game = (Game*)responseObj;
            _scoreList = [game.scoreList copy];
            completionBlock(success,nil);
        }
        else
        {
            _scoreList = nil;
            NSError *error = [NSError errorWithDomain:[exception reason] code:[exception httpErrorCode] userInfo:[exception userInfo]];
            completionBlock(success,error);
        }
    }];
}


-(void)fetchGlobalLeaderboardData:(App42LeaderboardResponse)completionBlock
{
    [scoreboardService getTopNRankers:self.gameName max:(int)self.numberOfRecords completionBlock:^(BOOL success, id responseObj, App42Exception *exception)
    {
        if (success)
        {
            Game *game = (Game*)responseObj;
            _scoreList = [game.scoreList copy];
            completionBlock(success,nil);
        }
        else
        {
            _scoreList = nil;
            NSError *error = [NSError errorWithDomain:[exception reason] code:[exception httpErrorCode] userInfo:[exception userInfo]];
            completionBlock(success,error);
        }
    }];
}

-(void)fetchFBFriendsLeaderboardData:(App42LeaderboardResponse)completionBlock
{
    [scoreboardService getTopNRankersFromFacebook:self.gameName fbAccessToken:self.fbAccessToken max:(int)self.numberOfRecords completionBlock:^(BOOL success, id responseObj, App42Exception *exception)
     {
         if (success)
         {
             Game *game = (Game*)responseObj;
             _scoreList = [game.scoreList copy];
             completionBlock(success,nil);
         }
         else
         {
             _scoreList = nil;
             NSError *error = [NSError errorWithDomain:[exception reason] code:[exception httpErrorCode] userInfo:[exception userInfo]];
             completionBlock(success,error);
         }
     }];
}


#pragma mark- Leaderboard UI

-(void)launchLeaderboard:(id)controller
{
    App42LeaderboardViewController *leaderboardViewController = [[App42LeaderboardViewController alloc] initWithNibName:@"App42LeaderboardViewController" bundle:nil];
    leaderboardViewController.scoreList = _scoreList;
    [controller presentViewController:leaderboardViewController animated:YES completion:^{
        
    }];
}

@end
