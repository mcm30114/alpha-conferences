//
//  ACSpearker.m
//  AlphaConferences
//
//  Created by Erik Erskine on 30/03/2012.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "Speaker.h"
#import "NSDictionary+Alpha.h"


@interface Speaker ()

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
@synthesize sortableName;


-(id)initWithDictionary:(NSDictionary *)dictionary {
    if (self = [super init]) {
        self.speakerId = [dictionary integerForKey:@"id"];
        self.active = [dictionary activeFlag];
        self.firstName = [dictionary objectForKey:@"first_name"];
        self.lastName = [dictionary objectForKey:@"last_name"];
        self.biography = [dictionary objectForKey:@"biography"];
        self.position = [dictionary objectForKey:@"position"];
        self.imageKey = [dictionary objectForKey:@"image_key"];
        self.twitterUsername = [dictionary objectForKey:@"twitter_username"];
        self.websiteUrl = [dictionary objectForKey:@"website_url"];
        self.alias = [dictionary stringForKey:@"alias"];
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


-(NSComparisonResult)compare:(Speaker *)aSpeaker {
    return [sortableName compare:aSpeaker.sortableName];
}


@end
