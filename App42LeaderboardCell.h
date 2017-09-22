//
//  App42LeaderboardCell.h
//  App42LeaderboardSample
//
//  Created by Rajeev Ranjan on 09/02/15.
//  Copyright (c) 2015 Rajeev Ranjan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface App42LeaderboardCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *userName; // stores the user name to be shown in the leaderboard
@property (weak, nonatomic) IBOutlet UILabel *rank; // stores rank of the user
@property (weak, nonatomic) IBOutlet UILabel *score; // stores score of the user

@end
