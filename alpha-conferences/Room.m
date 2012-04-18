//
//  Room.m
//  AlphaConferences
//
//  Created by Erik Erskine on 17/04/2012.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "Room.h"
#import "NSDictionary+Alpha.h"


@implementation Room

@synthesize roomId;
@synthesize active;
@synthesize venueId;
@synthesize name;


-(id)initWithDictionary:(NSDictionary *)dictionary {
    if (self = [super init]) {
        self.roomId = [dictionary integerForKey:@"id"];
        self.active = [dictionary activeFlag];
        self.venueId = [dictionary integerForKey:@"venue"];
        self.name = [dictionary objectForKey:@"name"];
    }
    return self;
}


@end
