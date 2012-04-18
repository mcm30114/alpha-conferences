//
//  Stream.m
//  AlphaConferences
//
//  Created by Erik Erskine on 17/04/2012.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "Stream.h"
#import "NSDictionary+Alpha.h"


@implementation Stream

@synthesize streamId;
@synthesize active;
@synthesize name;
@synthesize color;


-(id)initWithDictionary:(NSDictionary *)dictionary {
    if (self = [super init]) {
        self.streamId = [dictionary integerForKey:@"id"];
        self.active = [dictionary activeFlag];
        self.name = [dictionary objectForKey:@"name"];
        self.color = [UIColor redColor];
    }
    return self;
}


@end
