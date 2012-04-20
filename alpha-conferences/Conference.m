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
@synthesize donationURL;
@synthesize donationDescription;
@synthesize donationTelephoneNumber;

-(id)initWithDictionary:(NSDictionary *)dictionary {
    if (self = [super init]) {
        self.conferenceId = [dictionary integerForKey:@"id"];
        self.active = [dictionary activeFlag];
        self.name = [dictionary objectForKey:@"name"];
        self.text = [dictionary objectForKey:@"description"];
        self.startDate = [dictionary dateForKey:@"start_date"];
        self.endDate = [dictionary dateForKey:@"end_date"];
        self.imageKey = [dictionary objectForKey:@"image_key"];
        self.bookingURL = [dictionary objectForKey:@"booking_url"];
        self.donationURL = [dictionary stringForKey:@"donation_url"];
        self.donationDescription = [dictionary stringForKey:@"donation_description"];
        self.donationTelephoneNumber = [dictionary stringForKey:@"donation_telephone_number"];
    }
    return self;
}


@end
