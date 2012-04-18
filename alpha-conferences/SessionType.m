//
//  SessionType.m
//  AlphaConferences
//
//  Created by Erik Erskine on 17/04/2012.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "SessionType.h"
#import "NSDictionary+Alpha.h"


@implementation SessionType

@synthesize sessionTypeId;
@synthesize active;
@synthesize name;


-(id)initWithDictionary:(NSDictionary *)dictionary {
    if (self = [super init]) {
        self.sessionTypeId = [dictionary integerForKey:@"id"];
        self.active = [dictionary activeFlag];
        self.name = [dictionary objectForKey:@"name"];
    }
    return self;
}


@end
