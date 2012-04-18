//
//  Day.m
//  AlphaConferences
//
//  Created by Erik Erskine on 17/04/2012.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "Day.h"
#import "NSDictionary+Alpha.h"


@implementation Day

@synthesize dayId;
@synthesize active;
@synthesize date;


-(id)initWithDictionary:(NSDictionary *)dictionary {
    if (self = [super init]) {
        self.dayId = [dictionary integerForKey:@"id"];
        self.active = [dictionary activeFlag];
        self.date = [dictionary dateForKey:@"date"];
    }
    return self;
}


@end
