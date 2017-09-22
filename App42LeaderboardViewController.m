//
//  App42LeaderboardViewController.m
//  App42LeaderboardSample
//
//  Created by Rajeev Ranjan on 03/02/15.
//  Copyright (c) 2015 Rajeev Ranjan. All rights reserved.
//

#import "App42LeaderboardViewController.h"
#import <Shephertz_App42_iOS_API/Shephertz_App42_iOS_API.h>
#import "App42LeaderboardView.h"
#import "App42Leaderboard.h"
#import "App42Leaderboard_Ext.h"
#import "StopTap-Swift.h"

@interface App42LeaderboardViewController ()
{
    NSInteger rowsCount; //Number of rows in the table view
    double highestScore; //Highest score of current user
    BOOL isLeaderboardLoading; //Checks if leaderboard is fetching the data to load
}
@property (weak, nonatomic) IBOutlet UISegmentedControl *segmentedControl; //Used to show the sub-type in the leaderboard such as Global, Friend's etc.

@property (weak, nonatomic) IBOutlet App42LeaderboardView *leaderboardTableView; // UITableView instance used to list the data

@property (weak, nonatomic) IBOutlet UILabel *noDataMessage; // Shows message if there is no data to show in the leaderboard

@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator; // Activity indicator used to show leaderboard is in loading phase

@property (weak, nonatomic) IBOutlet UILabel *highestScoreLabel; // Label used to show highest score of the user

/***
 * Triggered whenever switching between sub-type occurs
 */
- (IBAction)indexChanged:(id)sender;

/***
 * Triggered whenever back button is tapped
 */
- (IBAction)backButton:(id)sender;

/***
 * Method to configure Segmented control like titles
 */
-(void)configureSegmentedControl;

/***
 * Called whenever leaderboard need to be reloaded based on selected options
 */
-(void)reloadLeaderboardForIndex:(NSInteger)index;

/***
 * Called whenever leaderboard is in loading phase to activity indicator
 */
-(void)showActivityIndicator;

/***
 * Called to remove activity indicator
 */
-(void)removeActivityIndicator;

@end

@implementation App42LeaderboardViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    nightmode *nm = [[nightmode alloc] init];
    if(nm.nm == 0){
        self.leaderboardTableView.separatorColor = [UIColor colorWithRed:0.0f green:0.0f blue:0.0f alpha:1.0f];
        self.leaderboardTableView.backgroundColor = [UIColor colorWithRed:1.0f green:1.0f blue:1.0f alpha:1.0f];
        self.view.backgroundColor = [UIColor colorWithRed:1.0f green:1.0f blue:1.0f alpha:1.0f];
    }else{
        self.leaderboardTableView.separatorColor = [UIColor colorWithRed:1.0f green:1.0f blue:1.0f alpha:1.0f];
        self.leaderboardTableView.backgroundColor = [UIColor colorWithRed:0.0f green:0.0f blue:0.0f alpha:1.0f];
        self.view.backgroundColor = [UIColor colorWithRed:0.0f green:0.0f blue:0.0f alpha:1.0f];
    }
    self.activityIndicator.hidden = YES;
    self.leaderboardTableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    
    [self configureSegmentedControl];
    /***
     * Loading nib for App42LeaderboardCell custom cell
     */
    UINib *countryNib = [UINib nibWithNibName:@"App42LeaderboardCell" bundle:nil];
    
    /***
     * Registering nib
     */
    [self.leaderboardTableView registerNib:countryNib forCellReuseIdentifier:@"App42LeaderboardCell"];
    
    /***
     * Initial view settings
     */
    if (self.scoreList)
    {
        rowsCount = self.scoreList.count;
    }
    if (!rowsCount)
    {
        self.leaderboardTableView.hidden = YES;
        self.noDataMessage.hidden = NO;
    }
    if (isLeaderboardLoading) {
        return;
    }
    self.noDataMessage.hidden = YES;
    //Setting Leaderboard subtype
    switch ([[App42Leaderboard sharedInstance] leaderboardType])
    {
        case kApp42_DateRange:
            [[App42Leaderboard sharedInstance] setDateBasedLeaderboardType:index];
            
            break;
        case kApp42_Social:
            [[App42Leaderboard sharedInstance] setSocialLeaderboardType:1];
            break;
            
        default:
            break;
    }
    [self showActivityIndicator];
    //Fetching data for selected leaderboard type
    [[App42Leaderboard sharedInstance] fetchLeaderboard:^(BOOL success, NSError *error)
     {
         self.scoreList = [[App42Leaderboard sharedInstance] scoreList];
         NSLog(@"ScoreList=%@",self.scoreList);
         if (self.scoreList)
         {
             rowsCount = self.scoreList.count;
         }
         else
         {
             rowsCount = 0;
         }
         
         if (rowsCount)
         {
             self.leaderboardTableView.hidden = NO;
             [self.leaderboardTableView reloadData];
         }
         else
         {
             self.leaderboardTableView.hidden = YES;
             self.noDataMessage.hidden = NO;
         }
         [self removeActivityIndicator];
     }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    // Return the number of sections.
    NSLog(@"%s",__func__);
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    // Return the number of rows in the section.
    NSLog(@"%s",__func__);
    return rowsCount+1;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    App42LeaderboardCell *cell = [tableView dequeueReusableCellWithIdentifier:@"App42LeaderboardCell" forIndexPath:indexPath];
    NSArray *versionArray = [[[UIDevice currentDevice] systemVersion] componentsSeparatedByString:@"."];
    if ([[versionArray objectAtIndex:0] intValue] >= 8) {
        cell.layoutMargins = UIEdgeInsetsZero;
        cell.preservesSuperviewLayoutMargins = false;
    }
    nightmode *nm = [[nightmode alloc] init];
    if(nm.nm == 0){
        cell.rank.textColor = [UIColor colorWithRed:0.0f green:0.0f blue:0.0f alpha:1.0f];
        cell.userName.textColor = [UIColor colorWithRed:0.0f green:0.0f blue:0.0f alpha:1.0f];
        cell.score.textColor = [UIColor colorWithRed:0.0f green:0.0f blue:0.0f alpha:1.0f];
    }else{
        cell.rank.textColor = [UIColor colorWithRed:1.0f green:1.0f blue:1.0f alpha:1.0f];
        cell.userName.textColor = [UIColor colorWithRed:1.0f green:1.0f blue:1.0f alpha:1.0f];
        cell.score.textColor = [UIColor colorWithRed:1.0f green:1.0f blue:1.0f alpha:1.0f];
    }
    // Configure the cell...
    if (indexPath.row == 0) // Configure 1st row
    {
        //Setting label background
        cell.rank.backgroundColor = [UIColor colorWithRed:115.0/255 green:115.0/255 blue:115.0/255 alpha:1.0f];
        cell.userName.backgroundColor = [UIColor colorWithRed:161.0/255 green:161.0/255 blue:161.0/255 alpha:1.0f];
        cell.score.backgroundColor = [UIColor colorWithRed:161.0/255 green:161.0/255 blue:161.0/255 alpha:1.0f];
        //cell.userName.textColor = [UIColor colorWithRed:85.0/255 green:85.0/255 blue:85.0/255 alpha:1.0f];
        //cell.score.textColor = [UIColor colorWithRed:85.0/255 green:85.0/255 blue:85.0/255 alpha:1.0f];
        
        if ([[App42Leaderboard sharedInstance] leaderboardType] == kApp42_UserStandings)
        {
            cell.userName.text = @"Scored On";
            cell.rank.text = @"Index";
        }
        else
        {
            cell.userName.text = @"Name";
            cell.rank.text = @"Rank";
        }
        cell.score.text = @"Score";
    }
    else // Configure rows from 1 - last row downwards
    {
        Score *score = (Score*)[self.scoreList objectAtIndex:indexPath.row-1];
        
        if ([[App42Leaderboard sharedInstance] leaderboardType] == kApp42_UserStandings)
        {
            cell.userName.text = [self reformatDate:score.createdOn];;
        }
        else
        {
            cell.userName.text = score.userName;
        }
        if(nm.nm == 0){
            cell.userName.backgroundColor = [UIColor colorWithRed:1.0f green:1.0f blue:1.0f alpha:1.0f];
            cell.score.backgroundColor = [UIColor colorWithRed:1.0f green:1.0f blue:1.0f alpha:1.0f];
        }else{
            cell.userName.backgroundColor = [UIColor colorWithRed:0.0f green:0.0f blue:0.0f alpha:1.0f];
            cell.score.backgroundColor = [UIColor colorWithRed:0.0f green:0.0f blue:0.0f alpha:1.0f];
        }
        cell.rank.text = [NSString stringWithFormat:@"%ld",(long)indexPath.row];
        cell.score.text = [NSString stringWithFormat:@"%d",(int)score.value];
        
        if (highestScore<score.value)
        {
            highestScore = score.value;
            self.highestScoreLabel.text = [NSString stringWithFormat:@"Highest : %d",(int)highestScore];
        }
        
    }
    return cell;
}


-(NSString*)reformatDate:(NSDate*)date
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"MMM dd, yyyy"];
    NSString *dateString = [dateFormatter stringFromDate:date];
    
    NSLog(@"Date = %@",dateString);
    return dateString;
}


#pragma mark- SegmentedControl Setup

-(void)configureSegmentedControl
{
    switch ([[App42Leaderboard sharedInstance] leaderboardType])
    {
        case kApp42_DateRange:
        {
            [self.segmentedControl setTitle:@"Today's" forSegmentAtIndex:0];
            [self.segmentedControl setTitle:@"Last Week" forSegmentAtIndex:1];
            [self.segmentedControl insertSegmentWithTitle:@"Last Month" atIndex:2 animated:NO];
        }
            break;
        case kApp42_Social:
            [self.segmentedControl setTitle:@"Global" forSegmentAtIndex:0];
            [self.segmentedControl setTitle:@"Global" forSegmentAtIndex:1];
            [self.segmentedControl removeSegmentAtIndex:1 animated:NO];
            break;
        case kApp42_UserStandings:
            self.highestScoreLabel.hidden = NO;
            self.segmentedControl.hidden = YES;
            break;
            
        default:
            break;
    }
}

- (IBAction)indexChanged:(id)sender
{
    [self reloadLeaderboardForIndex:1];
}


-(void)reloadLeaderboardForIndex:(NSInteger)index
{
    if (isLeaderboardLoading) {
        return;
    }
    self.noDataMessage.hidden = YES;
    //Setting Leaderboard subtype
    switch ([[App42Leaderboard sharedInstance] leaderboardType])
    {
        case kApp42_DateRange:
            [[App42Leaderboard sharedInstance] setDateBasedLeaderboardType:index];
        
            break;
        case kApp42_Social:
            [[App42Leaderboard sharedInstance] setSocialLeaderboardType:1];
            break;
            
        default:
            break;
    }
    [self showActivityIndicator];
    //Fetching data for selected leaderboard type
    [[App42Leaderboard sharedInstance] fetchLeaderboard:^(BOOL success, NSError *error)
     {
        self.scoreList = [[App42Leaderboard sharedInstance] scoreList];
        NSLog(@"ScoreList=%@",self.scoreList);
        if (self.scoreList)
        {
            rowsCount = self.scoreList.count;
        }
        else
        {
            rowsCount = 0;
        }
         
        if (rowsCount)
        {
            self.leaderboardTableView.hidden = NO;
            [self.leaderboardTableView reloadData];
        }
        else
        {
            self.leaderboardTableView.hidden = YES;
            self.noDataMessage.hidden = NO;
        }
        [self removeActivityIndicator];
    }];
}

#pragma mark- Activity Indicator

-(void)showActivityIndicator
{
    nightmode *nm = [[nightmode alloc] init];
    if (nm.nm == 0){
        self.activityIndicator.color = [UIColor colorWithRed:0.0f green:0.0f blue:0.0f alpha:1.0f];
    }else{
        self.activityIndicator.color = [UIColor colorWithRed:1.0f green:1.0f blue:1.0f alpha:1.0f];
    }
    self.activityIndicator.transform = CGAffineTransformMakeScale(2.0, 2.0);
    self.activityIndicator.hidden = NO;
    isLeaderboardLoading = YES;
    [self.activityIndicator startAnimating];
}

-(void)removeActivityIndicator
{
    isLeaderboardLoading = NO;
    self.activityIndicator.hidden = YES;
    [self.activityIndicator stopAnimating];
}


#pragma mark- Button Actions

- (IBAction)backButton:(id)sender
{
    // Dismisses leaderboard view and goes back to the previous view
    [self dismissViewControllerAnimated:YES completion:^{
        [[App42Leaderboard sharedInstance] setDateBasedLeaderboardType:0];
        [[App42Leaderboard sharedInstance] setSocialLeaderboardType:0];
    }];
}


@end
