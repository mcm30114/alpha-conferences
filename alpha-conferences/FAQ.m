//
//  FAQ.m
//  AlphaConferences
//
//  Created by Erik Erskine on 17/04/2012.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "FAQ.h"
#import "NSDictionary+Alpha.h"


@implementation FAQ

@synthesize faqId;
@synthesize active;
@synthesize question;
@synthesize answer;


-(id)initWithDictionary:(NSDictionary *)dictionary {
    if (self = [super init]) {
        self.faqId = [dictionary integerForKey:@"id"];
        self.active = [dictionary activeFlag];
        self.question = [dictionary objectForKey:@"question"];
        self.answer = [dictionary objectForKey:@"answer"];
    }
    return self;
}


@end
