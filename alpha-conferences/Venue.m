//
//  Venue.m
//  AlphaConferences
//
//  Created by Erik Erskine on 17/04/2012.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "Venue.h"
#import "NSDictionary+Alpha.h"


@implementation Venue

@synthesize venueId;
@synthesize active;
@synthesize name;
@synthesize latitude;
@synthesize longitude;
@synthesize streetAddress;
@synthesize county;
@synthesize country;
@synthesize postcode;
@synthesize details;
@synthesize imageKey;
@synthesize floorplanKey;


-(id)initWithDictionary:(NSDictionary *)dictionary {
    if (self = [super init]) {
        self.venueId = [dictionary integerForKey:@"id"];
        self.active = [dictionary activeFlag];
        self.name = [dictionary objectForKey:@"name"];
        self.latitude = [dictionary floatForKey:@"latitude"];
        self.longitude = [dictionary floatForKey:@"longitude"];
        self.streetAddress = [dictionary objectForKey:@"street_address"];
        self.county = [dictionary objectForKey:@"county"];
        self.country = [dictionary objectForKey:@"country"];
        self.postcode = [dictionary objectForKey:@"postcode"];
        self.details = [dictionary objectForKey:@"details"];
        self.imageKey = [dictionary objectForKey:@"image_key"];
        self.floorplanKey = [dictionary objectForKey:@"floorplan_key"];
    }
    return self;
}


@end
