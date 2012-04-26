//
//  ProgrammeRow.m
//  alpha-conferences
//
//  Created by Erik Erskine on 26/04/2012.
//  Copyright (c) 2012 Brightec Ltd. All rights reserved.
//

#import "ProgrammeRow.h"


@implementation ProgrammeRow

@synthesize text;
@synthesize speakerText;
@synthesize dateTimeText;
@synthesize venueText;
@synthesize accessoryType;
@synthesize barColour;
@synthesize onSelected;


-(NSString *)detailText {
    NSMutableString *str = [NSMutableString string];
    
    if (venueText) {
        [str appendString:venueText];
    }
    
    if (speakerText) {
        if (str.length > 0) [str appendString:@" - "];
        [str appendString:speakerText];
    }
    
    if (dateTimeText) {
        if (str.length > 0) [str appendString:@"\n"];
        [str appendString:dateTimeText];
    }
    
    return str;
}


@end
