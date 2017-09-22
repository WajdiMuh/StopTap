//
//  App42LeaderboardViewController.h
//  App42LeaderboardSample
//
//  Created by Rajeev Ranjan on 03/02/15.
//  Copyright (c) 2015 Rajeev Ranjan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface App42LeaderboardViewController : UIViewController<UITableViewDelegate,UITableViewDataSource>

/***
 * Stores the array of scores that will be shown in the leaderboard
 */
@property(nonatomic) NSArray *scoreList;

@end
