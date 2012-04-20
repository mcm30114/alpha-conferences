//
//  Session.m
//  AlphaConferences
//
//  Created by Erik Erskine on 17/04/2012.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "Session.h"
#import "NSDictionary+Alpha.h"
#import "DataStore.h"
#import "NSDateFormatter+Alpha.h"


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


-(NSString *)programmeDetailTextWithData:(DataStore *)data {
    NSMutableString *str = [NSMutableString string];
    
    Room *room = [data roomWithId:self.roomId];
    Venue *venue = [data venueWithId:room.venueId];
    if (venue) {
        [str appendString:venue.name];
    }
    
    Speaker *speaker = [data speakerWithId:((NSNumber *)[self.speakerIds objectAtIndex:0]).intValue];
    if (speaker) {
        if (str.length > 0) [str appendString:@" - "];
        [str appendString:speaker.displayName];
    }
    
    if (str.length > 0) [str appendString:@"\n"];
    
    NSDateFormatter *f = [NSDateFormatter timeFormatter];
    [str appendFormat:@"%@ - %@", [f stringFromDate:self.startDateTime], [f stringFromDate:self.endDateTime]];
    return str;
}


-(NSString *)detailDetailTextWithData:(DataStore *)data {
    NSMutableString *str = [NSMutableString string];
    
    Room *room = [data roomWithId:self.roomId];
    Venue *venue = [data venueWithId:room.venueId];
    if (venue) {
        [str appendString:venue.name];
    }
    
    if (str.length > 0) [str appendString:@"\n"];
    
    NSDateFormatter *df = [NSDateFormatter mediumDateFormatter];
    NSDateFormatter *tf = [NSDateFormatter timeFormatter];
    [str appendFormat:@"%@ - %@, %@", [tf stringFromDate:self.startDateTime], [tf stringFromDate:self.endDateTime], [df stringFromDate:self.startDateTime]];
    return str;
}


@end
