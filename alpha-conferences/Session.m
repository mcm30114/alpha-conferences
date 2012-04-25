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
#import "DataStore.h"
#import "Session.h"


@interface Session () {
    @private
    __unsafe_unretained DataStore *data;
}

@end



@implementation Session

@synthesize sessionId;
@synthesize active;
@synthesize dayId;
@synthesize type;
@synthesize roomId;
@synthesize streamId;
@synthesize sessionGroupId;
@synthesize name;
@synthesize startDateTime;
@synthesize endDateTime;
@synthesize text;
@synthesize speakerIds;


-(id)initWithDictionary:(NSDictionary *)dictionary data:(DataStore *)d {
    if (self = [super init]) {
        data = d;
        self.sessionId = [dictionary integerForKey:@"id"];
        self.active = [dictionary activeFlag];
        self.dayId = [dictionary integerForKey:@"day"];
        self.type = [dictionary integerForKey:@"session_type"];
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


-(Room *)room {
    return [data roomWithId:self.roomId];
}


-(Stream *)stream {
    return [data streamWithId:self.streamId];
}


-(NSString *)programmeDetailText {
    NSMutableString *str = [NSMutableString string];
    
    Venue *venue = self.room.venue;
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


-(NSString *)detailDetailText {
    NSMutableString *str = [NSMutableString string];
    
    Venue *venue = self.room.venue;
    if (self.room) {
        if (venue) {
            [str appendString:venue.name];
        }
        if (str.length > 0) [str appendString:@", "];
        [str appendString:self.room.name];
    }
    
    if (str.length > 0) [str appendString:@"\n"];
    
    NSDateFormatter *df = [NSDateFormatter mediumDateFormatter];
    NSDateFormatter *tf = [NSDateFormatter timeFormatter];
    [str appendFormat:@"%@ - %@, %@", [tf stringFromDate:self.startDateTime], [tf stringFromDate:self.endDateTime], [df stringFromDate:self.startDateTime]];
    return str;
}


-(UIColor *)color {
    UIColor *streamColor = self.stream.color;
    return streamColor ? streamColor : [UIColor colorWithSessionType:self.type];
}


@end
