//
//  SpecialOffer.m
//  AlphaConferences
//
//  Created by Erik Erskine on 17/04/2012.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "SpecialOffer.h"
#import "NSDictionary+Alpha.h"


@implementation SpecialOffer

@synthesize specialOfferId;
@synthesize active;
@synthesize conferenceId;
@synthesize title;
@synthesize html;


-(id)initWithDictionary:(NSDictionary *)dictionary {
    if (self = [super init]) {
        self.specialOfferId = [dictionary integerForKey:@"id"];
        self.active = [dictionary activeFlag];
        self.conferenceId = [dictionary integerForKey:@"conference"];
        self.title = [dictionary objectForKey:@"title"];
        self.html = [dictionary objectForKey:@"description"];
    }
    return self;
}


@end
