//
//  Stream.m
//  AlphaConferences
//
//  Created by Erik Erskine on 17/04/2012.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "Stream.h"
#import "NSDictionary+Alpha.h"
#import "UIColor+Alpha.h"


@implementation Stream

@synthesize streamId;
@synthesize active;
@synthesize name;
@synthesize color;


-(id)initWithDictionary:(NSDictionary *)dictionary {
    if (self = [super init]) {
        self.streamId = [dictionary integerForKey:@"id"];
        self.active = [dictionary activeFlag];
        self.name = [dictionary objectForKey:@"name"];
        
        NSString *colourStr = [dictionary stringForKey:@"colour"];
        if (colourStr.length > 0) {
            NSUInteger c = 0;
            NSScanner *scanner = [NSScanner scannerWithString:[colourStr stringByAppendingString:@"ff"]];
            [scanner scanHexInt:&c];
            self.color = [UIColor colorWithHex:c];
        } else {
            self.color = [UIColor lightGrayColor];
        }
        
    }
    return self;
}


@end
