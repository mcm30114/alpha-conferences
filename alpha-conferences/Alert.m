//
//  Alert.m
//  AlphaConferences
//
//  Created by Erik Erskine on 17/04/2012.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "Alert.h"
#import "NSDictionary+Alpha.h"


@implementation Alert

@synthesize alertId;
@synthesize active;
@synthesize title;
@synthesize message;
@synthesize dateTime;


-(id)initWithDictionary:(NSDictionary *)dictionary {
    if (self = [super init]) {
        self.alertId = [dictionary integerForKey:@"id"];
        self.active = [dictionary activeFlag];
        self.title = [dictionary objectForKey:@"title"];
        self.message = [dictionary objectForKey:@"message"];
        self.dateTime = [dictionary objectForKey:@"date_time"];
    }
    return self;
}


@end
