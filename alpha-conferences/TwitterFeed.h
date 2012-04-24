//
//  TwitterFeed.h
//  alpha-conferences
//
//  Created by Erik Erskine on 24/04/2012.
//  Copyright (c) 2012 Brightec Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Tweet.h"


@interface TwitterFeed : NSObject

@property (nonatomic, strong, readonly) NSArray *tweets;

+ (TwitterFeed *)latestAvailableInstance;
+ (void)refresh;

@end
