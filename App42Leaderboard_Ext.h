//
//  App42Leaderboard_Ext.h
//  App42LeaderboardSample
//
//  Created by Rajeev Ranjan on 11/02/15.
//  Copyright (c) 2015 Rajeev Ranjan. All rights reserved.
//

#import "App42Leaderboard.h"

/***
 * App42SocialLeaderboardType provide options to further declassify SocialLeaderboard leaderboards
 */
typedef enum : NSUInteger {
    kApp42_Friends,//Default, Shows scores of facebook friends
    kApp42_Global,              //Shows scores of all users playing the same game
} App42SocialLeaderboardType;

/***
 * App42DateBasedLeaderboardType provide options to further declassify DateBased leaderboards
 */
typedef enum : NSUInteger {
    kApp42_Today,               //Default, Shows today's scores of different users playing the same game
    kApp42_Weekly,              //Shows last week scores of different users playing the same game
    kApp42_Monthly,             //Shows last month scores of different users playing the same game
} App42DateBasedLeaderboardType;


@interface App42Leaderboard ()

@property(nonatomic) App42SocialLeaderboardType socialLeaderboardType; //The property to define subtype of social leaderboard
@property(nonatomic) App42DateBasedLeaderboardType dateBasedLeaderboardType; //The property to define subtype of date-based leaderboard
@property(nonatomic) NSArray *scoreList; //Array of scores that will be shown in leaderboard UI

@end
