//
//  NSDateFormatter+Alpha.m
//  alpha-conferences
//
//  Created by Erik Erskine on 20/04/2012.
//  Copyright (c) 2012 Brightec Ltd. All rights reserved.
//

#import "NSDateFormatter+Alpha.h"


@implementation NSDateFormatter (Alpha)


+(NSDateFormatter *)longDateFormatterWithUTCTimeZone {
    NSDateFormatter *f = [[NSDateFormatter alloc] init];
    f.timeZone = [NSTimeZone timeZoneWithName:@"UTC"];
    f.dateFormat = @"EEEE d MMMM Y";
    return f;
}

+(NSDateFormatter *)longDateFormatterWithDefaultTimeZone {
    NSDateFormatter *f = [[NSDateFormatter alloc] init];
    f.dateFormat = @"EEEE d MMMM Y";
    return f;
}

+(NSDateFormatter *)mediumDateFormatterWithUTCTimeZone {
    NSDateFormatter *f = [[NSDateFormatter alloc] init];
    f.timeZone = [NSTimeZone timeZoneWithName:@"UTC"];
    f.dateFormat = @"d MMMM Y";
    return f;
}

+(NSDateFormatter *)mediumDateFormatterWithDefaultTimeZone {
    NSDateFormatter *f = [[NSDateFormatter alloc] init];
    f.dateFormat = @"d MMMM Y";
    return f;
}

+(NSDateFormatter *)timeFormatterWithUTCTimeZone {
    NSDateFormatter *f = [[NSDateFormatter alloc] init];
    f.timeZone = [NSTimeZone timeZoneWithName:@"UTC"];
    f.dateFormat = @"H:mm";
    return f;
}

+(NSDateFormatter *)timeFormatterWithDefaultTimeZone {
    NSDateFormatter *f = [[NSDateFormatter alloc] init];
    f.dateFormat = @"H:mm";
    return f;
}

+(NSDateFormatter *)twitterFormatterWithDefaultTimeZone {
    NSDateFormatter *f = [[NSDateFormatter alloc] init];
    f.dateFormat = @"d MMMM - H:mm";
    return f;
}

+(NSDateFormatter *)iso8601FormatterWithUTCTimeZone {
    NSDateFormatter *f = [[NSDateFormatter alloc] init];
    f.timeZone = [NSTimeZone timeZoneWithName:@"UTC"];
    f.dateFormat = @"yyyy-MM-dd'T'HH:mm:ss";
    return f;
}

@end
