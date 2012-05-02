//
//  TwitterController.m
//  alpha-conferences
//
//  Created by Erik Erskine on 24/04/2012.
//  Copyright (c) 2012 Brightec Ltd. All rights reserved.
//

#import "TwitterController.h"
#import "AlphaRow.h"
#import "Constants.h"
#import "TwitterFeed.h"
#import "ResourceCache.h"
#import "LabelTextProperties.h"
#import "AlphaTwitterCell.h"
#import "NSDateFormatter+Alpha.h"
#import <Twitter/Twitter.h>


@interface TwitterController () {
    @private
    NSArray *tweets;
}

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UILabel *updatedLabel;
@property (nonatomic, strong) LabelTextProperties *textLabelProperties;
@property (nonatomic, strong) LabelTextProperties *detailTextLabelProperties;
@property (nonatomic, strong) LabelTextProperties *twitterDateTextLabelProperties;

- (void)tweetsWereUpdated:(NSNotification *)notification;
- (void)updateTime:(NSDate *)date;
- (void)composeTweet;

@end



@implementation TwitterController

@synthesize tableView = _tableView;
@synthesize updatedLabel = _updatedLabel;
@synthesize textLabelProperties;
@synthesize detailTextLabelProperties;
@synthesize twitterDateTextLabelProperties;


- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        
        // set default styles for twitter labels
        self.textLabelProperties = [[LabelTextProperties alloc] initWithFont:[UIFont tableCellTitleFont] textColour:[UIColor tableCellTitleColour] lineBreakMode:UILineBreakModeWordWrap];
        self.detailTextLabelProperties = [[LabelTextProperties alloc] initWithFont:[UIFont tableCellSubTitleFont] textColour:[UIColor tableSubTitleColour] lineBreakMode:UILineBreakModeWordWrap];
        self.twitterDateTextLabelProperties = [[LabelTextProperties alloc] initWithFont:[UIFont systemFontOfSize:11.0] textColour:[UIColor tableSubTitleColour] lineBreakMode:UILineBreakModeWordWrap]; 
        
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(tweetsWereUpdated:)
                                                     name:NOTIFICATION_TWITTER
                                                   object:nil];
        
        if (NSClassFromString(@"TWTweetComposeViewController")) {
            self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCompose target:self action:@selector(composeTweet)];
        }
        
    }
    return self;
}


- (void)loadView {
    UIView *rootView = [[UIView alloc] initWithFrame:[UIScreen mainScreen].applicationFrame];
    
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, rootView.bounds.size.width, rootView.bounds.size.height-20) style:UITableViewStylePlain];
    tableView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    tableView.dataSource = self;
    tableView.delegate = self;
    [rootView addSubview:tableView];
    self.tableView = tableView;
    
    UILabel *updatedLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, rootView.bounds.size.height-20, rootView.bounds.size.width, 20)];
    updatedLabel.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleTopMargin;
    updatedLabel.textAlignment = UITextAlignmentCenter;
    updatedLabel.backgroundColor = [UIColor colorWithHex:0xccccccff];
    updatedLabel.textColor = [UIColor darkGrayColor];
    updatedLabel.font = [UIFont systemFontOfSize:11];
    [rootView addSubview:updatedLabel];
    self.updatedLabel = updatedLabel;
    
    self.view = rootView;
}


-(void)viewDidLoad {
    TwitterFeed *feed = [TwitterFeed latestAvailableInstance];
    tweets = feed.tweets;
    [self updateTime:feed.date];
}


#pragma mark - UITableViewDataSource


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return tweets.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    static NSString *cellIdentifier = @"TwitterCell";
    AlphaTwitterCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        cell = [[AlphaTwitterCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIdentifier];
        
        [self.textLabelProperties setPropertiesForLabel:cell.textLabel];
        [self.detailTextLabelProperties setPropertiesForLabel:cell.detailTextLabel];
        [self.twitterDateTextLabelProperties setPropertiesForLabel:cell.dateTextLabel];
    }
    
    Tweet *tweet = [tweets objectAtIndex:indexPath.row];
    
    cell.textLabel.text = tweet.displayName;
    cell.detailTextLabel.text = tweet.displayText;
    cell.dateTextLabel.text = tweet.displayDateTime;
    
    cell.cellImageView.image = [[ResourceCache defaultResourceCache] imageForResource:tweet.avatarResource onComplete:^(UIImage *image) {
        cell.cellImageView.image = image;
    }];

    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    return cell;
}


#pragma mark - UITableViewDelegate


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:tableView.indexPathForSelectedRow animated:YES];
    Tweet *tweet = [tweets objectAtIndex:indexPath.row];
    [[UIApplication sharedApplication] openURL:tweet.URL];
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    Tweet *tweet = [tweets objectAtIndex:indexPath.row];
    
    NSMutableArray *labelStrings = [NSMutableArray arrayWithObject:tweet.displayName];
    NSMutableArray *labelProperties = [NSMutableArray arrayWithObject:self.textLabelProperties];
    
    if (tweet.displayText.length > 0) {
        [labelStrings addObject:tweet.displayText];
        [labelProperties addObject:self.detailTextLabelProperties];
    }
    
    if (tweet.displayDateTime.length > 0) {
        [labelStrings addObject:tweet.displayDateTime];
        [labelProperties addObject:self.twitterDateTextLabelProperties];
    }
    
    return [AlphaTwitterCell heightForRowWithTableView:tableView 
                            tableViewCellAccessoryType:UITableViewCellAccessoryDisclosureIndicator 
                                      labelTextStrings:labelStrings 
                                   labelTextProperties:labelProperties 
                                             imageSize:CGSizeMake(48, 48)];
}


#pragma mark -


- (void)tweetsWereUpdated:(NSNotification *)notification {
    TwitterFeed *feed = notification.object;
    tweets = feed.tweets;
    [self updateTime:feed.date];
    [self.tableView reloadData];
}


- (void)updateTime:(NSDate *)date {
    if (date) {
        self.updatedLabel.text = [NSString stringWithFormat:@"Last updated: %@ - %@",
                                  [[NSDateFormatter timeFormatterWithDefaultTimeZone] stringFromDate:date],
                                  [[NSDateFormatter mediumDateFormatterWithDefaultTimeZone] stringFromDate:date]];
    } else {
        self.updatedLabel.text = @"Twitter feed is not available offline";
    }
}


- (void)composeTweet {
    if ([TWTweetComposeViewController canSendTweet]) {
        TWTweetComposeViewController *tweetSheet = [[TWTweetComposeViewController alloc] init];
        [tweetSheet setInitialText:TWITTER_SEARCH_TERM];
        tweetSheet.completionHandler = ^(TWTweetComposeViewControllerResult r) {
            if (r == TWTweetComposeViewControllerResultDone) {
                self.updatedLabel.text = @"Your tweet has been sent";
            }
            [self dismissModalViewControllerAnimated:YES];
        };
        [self presentModalViewController:tweetSheet animated:YES];
    } else {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Sorry"
                                                        message:@"You cannot send a tweet, please ensure you have an internet connection and a Twitter account set up"
                                                       delegate:nil
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
        [alert show];
    }
}


@end
