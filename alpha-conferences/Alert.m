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
        self.title = [dictionary stringForKey:@"title"];
        self.message = [dictionary stringForKey:@"message"];
        self.dateTime = [dictionary dateForKey:@"sent_datetime"];
    }
    return self;
}

- (NSComparisonResult)compare:(Alert *)otherObject {
  NSInteger sort = [self.dateTime compare:otherObject.dateTime];
  
  if (sort == NSOrderedAscending) {
    sort = NSOrderedDescending;
  }
  else if (sort == NSOrderedDescending) {
    sort = NSOrderedAscending;
  }
  
  return sort;
}

@end
