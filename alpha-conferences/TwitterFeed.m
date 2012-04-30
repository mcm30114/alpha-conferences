//
//  TwitterFeed.m
//  alpha-conferences
//
//  Created by Erik Erskine on 24/04/2012.
//  Copyright (c) 2012 Brightec Ltd. All rights reserved.
//

#import "TwitterFeed.h"
#import "Constants.h"
#import "JSONKit.h"


@interface TwitterFeed ()

- (id)initWithTweetDictionaries:(NSArray *)tweetDictionaries date:(NSDate *)date;

@end



@implementation TwitterFeed

@synthesize tweets = _tweets;
@synthesize date = _date;


static TwitterFeed *latestAvailableInstance = nil;


+ (TwitterFeed *)latestAvailableInstance {
    return latestAvailableInstance;
}


+ (void)refresh {
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{

        NSString *documentsDirectory = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
        NSString *fullPath = [documentsDirectory stringByAppendingPathComponent:@"tweets.json"];

        // load previous tweets
        NSArray *oldTweets;
        if ([[NSFileManager defaultManager] fileExistsAtPath:fullPath]) {
            NSData *d = [NSData dataWithContentsOfFile:fullPath];
            oldTweets = [[JSONDecoder decoder] objectWithData:d];
        } else {
            oldTweets = [NSArray array];
        }

        // download new tweets
        NSString *queryString = [NSString stringWithFormat:@"q=%@", [TWITTER_SEARCH_TERM stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
        if (oldTweets.count > 0) {
            Tweet *t = [[Tweet alloc] initWithDictionary:[oldTweets objectAtIndex:0]];
            queryString = [queryString stringByAppendingString:[NSString stringWithFormat:@"&since_id=%@", t.tweetIdStr]];
        }
        NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"http://search.twitter.com/search.json?%@", queryString]];

        NSError *err;
        [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
        NSData *raw = [NSData dataWithContentsOfURL:url options:0 error:&err];
        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
        if (raw == nil) {
            return;
        }

        NSDictionary *main = [[JSONDecoder decoder] objectWithData:raw];
        NSMutableArray *newTweets = [main objectForKey:@"results"];

        // merge old and new tweets
        NSMutableArray *allTweets = [NSMutableArray array];
        [allTweets addObjectsFromArray:newTweets];
        [allTweets addObjectsFromArray:oldTweets];
        
        // save tweets
        [[allTweets JSONData] writeToFile:fullPath atomically:YES];
        
        TwitterFeed *feed = [[TwitterFeed alloc] initWithTweetDictionaries:allTweets date:[NSDate date]];
        latestAvailableInstance = feed;
        // notify delegates in main thread
        dispatch_async(dispatch_get_main_queue(), ^{
            [[NSNotificationCenter defaultCenter] postNotificationName:NOTIFICATION_TWITTER object:feed];
        });
        
    });
}


- (id)initWithTweetDictionaries:(NSArray *)tweetDictionaries date:(NSDate *)date {
    if (self = [super init]) {
        NSMutableArray *tweets = [NSMutableArray array];
        for (NSDictionary *d in tweetDictionaries) {
            [tweets addObject:[[Tweet alloc] initWithDictionary:d]];
        }
        _tweets = tweets;
        _date = date;
    }
    return self;
}


@end
