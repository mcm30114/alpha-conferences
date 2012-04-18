//
//  ACSpearker.m
//  AlphaConferences
//
//  Created by Erik Erskine on 30/03/2012.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "Speaker.h"
#import "NSDictionary+Alpha.h"


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
        self.alias = [dictionary objectForKey:@"alias"];
    }
    return self;
}


@end
