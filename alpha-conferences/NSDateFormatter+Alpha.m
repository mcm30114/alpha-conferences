//
//  NSDateFormatter+Alpha.m
//  alpha-conferences
//
//  Created by Erik Erskine on 20/04/2012.
//  Copyright (c) 2012 Brightec Ltd. All rights reserved.
//

#import "NSDateFormatter+Alpha.h"


@implementation NSDateFormatter (Alpha)


+(NSDateFormatter *)longDateFormatter {
    NSDateFormatter *f = [[NSDateFormatter alloc] init];
    f.dateFormat = @"EEEE d MMMM Y";
    return f;
}

+(NSDateFormatter *)mediumDateFormatter {
    NSDateFormatter *f = [[NSDateFormatter alloc] init];
    f.dateFormat = @"d MMMM Y";
    return f;
}

+(NSDateFormatter *)timeFormatter {
    NSDateFormatter *f = [[NSDateFormatter alloc] init];
    f.dateFormat = @"H:mm";
    return f;
}


@end
