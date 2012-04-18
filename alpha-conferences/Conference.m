//
//  ACConference.m
//  AlphaConferences
//
//  Created by Erik Erskine on 30/03/2012.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "Conference.h"
#import "NSDictionary+Alpha.h"


@implementation Conference

@synthesize conferenceId;
@synthesize active;
@synthesize name;
@synthesize text;
@synthesize startDate;
@synthesize endDate;
@synthesize imageKey;
@synthesize bookingURL;


-(id)initWithDictionary:(NSDictionary *)dictionary {
    if (self = [super init]) {
        self.conferenceId = [dictionary integerForKey:@"id"];
        self.active = [dictionary activeFlag];
        self.name = [dictionary objectForKey:@"name"];
        self.text = [dictionary objectForKey:@"description"];
        self.startDate = [dictionary objectForKey:@"start_date"];
        self.endDate = [dictionary objectForKey:@"end_date"];
        self.imageKey = [dictionary objectForKey:@"image_key"];
        self.bookingURL = [dictionary objectForKey:@"booking_url"];
    }
    return self;
}


@end
