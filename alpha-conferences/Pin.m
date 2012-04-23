//
//  Pin.m
//  alpha-conferences
//
//  Created by Erik Erskine on 23/04/2012.
//  Copyright (c) 2012 Brightec Ltd. All rights reserved.
//

#import "Pin.h"
#import "Venue.h"


@implementation Pin

@synthesize venue = _venue;


- (id)initWithVenue:(Venue *)venue {
    if (self = [super init]) {
        _venue = venue;
    }
    return self;
}


- (NSString *)title {
    return self.venue.name;
}

- (NSString *)subtitle {
    return self.venue.address;
}

- (CLLocationCoordinate2D)coordinate {
    return CLLocationCoordinate2DMake(self.venue.latitude, self.venue.longitude);
}


@end
