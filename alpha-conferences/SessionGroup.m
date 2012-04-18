//
//  SessionGroup.m
//  AlphaConferences
//
//  Created by Erik Erskine on 17/04/2012.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "SessionGroup.h"
#import "NSDictionary+Alpha.h"


@implementation SessionGroup

@synthesize sessionGroupId;
@synthesize active;
@synthesize dayId;
@synthesize name;


-(id)initWithDictionary:(NSDictionary *)dictionary {
    if (self = [super init]) {
        self.sessionGroupId = [dictionary integerForKey:@"id"];
        self.active = [dictionary activeFlag];
        self.dayId = [dictionary integerForKey:@"day"];
        self.name = [dictionary objectForKey:@"name"];
    }
    return self;
}


@end
