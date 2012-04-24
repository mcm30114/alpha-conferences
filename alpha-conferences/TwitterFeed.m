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

- (id)initWithData:(NSData *)data;

@end



@implementation TwitterFeed

@synthesize tweets = _tweets;


static TwitterFeed *latestAvailableInstance = nil;


+ (TwitterFeed *)latestAvailableInstance {
    return latestAvailableInstance;
}


+ (void)refresh {
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
        NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"http://search.twitter.com/search.json?q=%@", [TWITTER_SEARCH_TERM stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]]];
        NSError *err;
        NSData *raw = [NSData dataWithContentsOfURL:url options:0 error:&err];
        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
        
        if (raw) {
            TwitterFeed *feed = [[TwitterFeed alloc] initWithData:raw];
            latestAvailableInstance = feed;
            // notify delegates in main thread
            dispatch_async(dispatch_get_main_queue(), ^{
                [[NSNotificationCenter defaultCenter] postNotificationName:NOTIFICATION_TWITTER object:feed];
            });
        }
    });
}


- (id)initWithData:(NSData *)data {
    if (self = [super init]) {
        NSDictionary *main = [[JSONDecoder decoder] objectWithData:data];
        NSMutableArray *tweets = [NSMutableArray array];
        NSArray *tweetDictArray = [main objectForKey:@"results"];
        for (NSDictionary *tweetDict in tweetDictArray) {
            [tweets addObject:[[Tweet alloc] initWithDictionary:tweetDict]];
        }
        _tweets = tweets;
    }
    return self;
}


@end
