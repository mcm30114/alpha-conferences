//
//  Tweet.m
//  alpha-conferences
//
//  Created by Erik Erskine on 24/04/2012.
//  Copyright (c) 2012 Brightec Ltd. All rights reserved.
//

#import "Tweet.h"
#import "NSDictionary+Alpha.h"
#import "NSDateFormatter+Alpha.h"


@interface Tweet ()

@property (nonatomic, strong) NSString *tweetIdStr;
@property (nonatomic, strong) NSString *fromUser;
@property (nonatomic, strong) NSString *fromUserName;
@property (nonatomic, strong) NSString *text;
@property (nonatomic, strong) NSDate *createdAt;

@end



@implementation Tweet

@synthesize tweetIdStr;
@synthesize fromUser;
@synthesize fromUserName;
@synthesize text;
@synthesize createdAt;


- (id)initWithDictionary:(NSDictionary *)dictionary {
    if (self = [super init]) {
        self.tweetIdStr = [dictionary stringForKey:@"id_str"];
        self.fromUser = [dictionary stringForKey:@"from_user"];
        self.fromUserName = [dictionary stringForKey:@"from_user_name"];
        self.text = [dictionary stringForKey:@"text"];
        
        NSDateFormatter *df = [[NSDateFormatter alloc] init];
        df.dateFormat = @"EEE, d MMM yyyy HH:mm:ss Z";
        self.createdAt = [df dateFromString:[dictionary stringForKey:@"created_at"]];
        
    }
    return self;
}


- (NSString *)displayName {
    return self.fromUserName;
}


- (NSString *)displayText {
    return [NSString stringWithFormat:@"%@\n%@", self.text, [[NSDateFormatter twitterFormatter] stringFromDate:self.createdAt]];
}


- (NSURL *)URL {
    return [NSURL URLWithString:[NSString stringWithFormat:@"http://mobile.twitter.com/%@/status/%@", fromUser, tweetIdStr]];
}


- (Resource *)avatarResource {
    return [Resource resourceWithKey:self.fromUser type:ResourceTypeTwitterAvatar];
}


@end
