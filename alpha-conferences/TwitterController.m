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


@interface TwitterController () {
    @private
    NSArray *tweets;
}

@property (nonatomic, strong) LabelTextProperties *textLabelProperties;
@property (nonatomic, strong) LabelTextProperties *detailTextLabelProperties;
@property (nonatomic, strong) LabelTextProperties *twitterDateTextLabelProperties;

- (void)tweetsWereUpdated:(NSNotification *)notification;

@end



@implementation TwitterController
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
    }
    return self;
}


- (void)loadView {
    UITableView *tableView = [[UITableView alloc] initWithFrame:[UIScreen mainScreen].applicationFrame style:UITableViewStylePlain];
    tableView.dataSource = self;
    tableView.delegate = self;
    self.view = tableView;
}


-(void)viewDidLoad {
    tweets = [TwitterFeed latestAvailableInstance].tweets;
}


//-(void)viewDidAppear:(BOOL)animated {
//    [super viewDidAppear:animated];
//    UITableView *tableView = (UITableView *)self.view;
//    NSLog(@"viewDidAppear tableView=%@ selected=%@", tableView, tableView.indexPathForSelectedRow);
//    if (tableView.indexPathForSelectedRow) {
//        [tableView deselectRowAtIndexPath:tableView.indexPathForSelectedRow animated:YES];
//    }
//}


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
    cell.dateTextLabel.text = @"abc";
    
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
    
    return [AlphaTwitterCell heightForRowWithTableView:tableView 
                            tableViewCellAccessoryType:UITableViewCellAccessoryDisclosureIndicator 
                                      labelTextStrings:[NSArray arrayWithObjects:tweet.displayName, tweet.displayText, @"abc", nil] 
                                   labelTextProperties:[NSArray arrayWithObjects:self.textLabelProperties, self.detailTextLabelProperties, self.twitterDateTextLabelProperties, nil] 
                                             imageSize:tweet.avatarResource.size];
}


#pragma mark -


- (void)tweetsWereUpdated:(NSNotification *)notification {
    TwitterFeed *feed = notification.object;
    tweets = feed.tweets;
    [((UITableView *)self.view) reloadData];
}


@end
