//
//  Session.m
//  AlphaConferences
//
//  Created by Erik Erskine on 17/04/2012.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "Session.h"
#import "NSDictionary+Alpha.h"


@implementation Session

@synthesize sessionId;
@synthesize active;
@synthesize dayId;
@synthesize sessionTypeId;
@synthesize roomId;
@synthesize streamId;
@synthesize sessionGroupId;
@synthesize name;
@synthesize startDateTime;
@synthesize endDateTime;
@synthesize text;
@synthesize speakerIds;


-(id)initWithDictionary:(NSDictionary *)dictionary {
    if (self = [super init]) {
        self.sessionId = [dictionary integerForKey:@"id"];
        self.active = [dictionary activeFlag];
        self.dayId = [dictionary integerForKey:@"day"];
        self.sessionTypeId = [dictionary integerForKey:@"session_type"];
        self.roomId = [dictionary integerForKey:@"room"];
        self.streamId = [dictionary integerForKey:@"stream"];
        self.sessionGroupId = [dictionary integerForKey:@"session_group"];
        self.name = [dictionary objectForKey:@"name"];
        self.startDateTime = [dictionary dateForKey:@"start_datetime"];
        self.endDateTime = [dictionary dateForKey:@"end_datetime"];
        self.text = [dictionary objectForKey:@"description"];
        self.speakerIds = [dictionary objectForKey:@"speakers"];
    }
    return self;
}


@end
