//
//  ACSpearker.m
//  AlphaConferences
//
//  Created by Erik Erskine on 30/03/2012.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "Speaker.h"
#import "NSDictionary+Alpha.h"
#import "DataStore.h"


@interface Speaker () {
    @private
    __unsafe_unretained DataStore *data;
}

@property (nonatomic, strong) NSString *sortableName;

@end



@implementation Speaker

@synthesize speakerId;
@synthesize active;
@synthesize firstName;
@synthesize lastName;
@synthesize alias;
@synthesize twitterUsername;
@synthesize websiteUrl;
@synthesize biography;
@synthesize position;
@synthesize imageKey;
@synthesize sessionIds;
@synthesize sortableName;


-(id)initWithDictionary:(NSDictionary *)dictionary data:(DataStore *)d {
    if (self = [super init]) {
        data = d;
        self.speakerId = [dictionary integerForKey:@"id"];
        self.active = [dictionary activeFlag];
        self.firstName = [dictionary stringForKey:@"first_name"];
        self.lastName = [dictionary stringForKey:@"last_name"];
        self.biography = [dictionary stringForKey:@"biography"];
        self.position = [dictionary stringForKey:@"position"];
        self.imageKey = [dictionary stringForKey:@"image_key"];
        self.twitterUsername = [dictionary stringForKey:@"twitter_username"];
        self.websiteUrl = [dictionary stringForKey:@"website_url"];
        self.alias = [dictionary stringForKey:@"alias"];
        self.sessionIds = [dictionary objectForKey:@"sessions"];
        self.sortableName = [NSString stringWithFormat:@"%@ %@", [self.lastName lowercaseString], [self.firstName lowercaseString]];
    }
    return self;
}


-(NSString *)displayName {
    if (self.alias) {
        return self.alias;
    } else {
        return [NSString stringWithFormat:@"%@ %@", self.firstName, self.lastName];
    }
}


-(NSString *)indexLetter {
    return [[self.lastName substringWithRange:NSMakeRange(0, 1)] uppercaseString];
}


-(NSArray *)sessions {
    NSMutableArray *a = [NSMutableArray array];
    for (NSNumber *sessionId in sessionIds) {
        [a addObject:[data sessionWithId:sessionId.integerValue]];
    }
    [a sortUsingSelector:@selector(compareByStartDateTime:)];
    return a;
}


-(NSComparisonResult)compare:(Speaker *)aSpeaker {
    return [sortableName compare:aSpeaker.sortableName];
}


@end
