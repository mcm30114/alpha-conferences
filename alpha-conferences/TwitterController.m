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


@interface TwitterController () {
    @private
    NSArray *tweets;
}

- (void)tweetsWereUpdated:(NSNotification *)notification;

@end



@implementation TwitterController


- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
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
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        cell = [[AlphaCell alloc] initWithStyle:AlphaTableViewCellWithImageLeft reuseIdentifier:cellIdentifier];
    }
    
    Tweet *tweet = [tweets objectAtIndex:indexPath.row];
    
    cell.textLabel.text = tweet.displayName;
    cell.textLabel.font = [UIFont tableCellTitleFont];
    cell.textLabel.textColor = [UIColor tableCellTitleColour];            
    
    cell.detailTextLabel.text = tweet.displayText;
    cell.detailTextLabel.font = [UIFont tableCellSubTitleFont];
    cell.detailTextLabel.textColor = [UIColor tableSubTitleColour];
    cell.detailTextLabel.lineBreakMode = UILineBreakModeWordWrap;
    cell.detailTextLabel.numberOfLines = 0;
    
    cell.imageView.image = [[ResourceCache defaultResourceCache] imageForResource:tweet.avatarResource onComplete:^(UIImage *image) {
        cell.imageView.image = image;
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
    return [AlphaCell heightForRowWithTableView:tableView
                     tableViewCellAccessoryType:UITableViewCellAccessoryDisclosureIndicator
                        alphaTableViewCellStyle:AlphaTableViewCellWithImageLeft
                                  textLabelText:tweet.displayName
                            detailTextLabelText:tweet.displayText
                                  imageViewSize:CGSizeMake(48, 48)];
}


#pragma mark -


- (void)tweetsWereUpdated:(NSNotification *)notification {
    TwitterFeed *feed = notification.object;
    tweets = feed.tweets;
    [((UITableView *)self.view) reloadData];
}


@end
