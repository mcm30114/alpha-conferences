//
//  Room.m
//  AlphaConferences
//
//  Created by Erik Erskine on 17/04/2012.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "Room.h"
#import "NSDictionary+Alpha.h"
#import "DataStore.h"


@interface Room () {
    @private
    __unsafe_unretained DataStore *data;
}

@end



@implementation Room

@synthesize roomId;
@synthesize active;
@synthesize venueId;
@synthesize name;


-(id)initWithDictionary:(NSDictionary *)dictionary data:(DataStore *)d {
    if (self = [super init]) {
        data = d;
        self.roomId = [dictionary integerForKey:@"id"];
        self.active = [dictionary activeFlag];
        self.venueId = [dictionary integerForKey:@"venue"];
        self.name = [dictionary objectForKey:@"name"];
    }
    return self;
}


-(Venue *)venue {
    return [data venueWithId:self.venueId];
}


@end
