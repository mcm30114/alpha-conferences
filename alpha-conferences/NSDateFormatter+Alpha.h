//
//  NSDateFormatter+Alpha.h
//  alpha-conferences
//
//  Created by Erik Erskine on 20/04/2012.
//  Copyright (c) 2012 Brightec Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface NSDateFormatter (Alpha)

+(NSDateFormatter *)longDateFormatterWithUTCTimeZone;
+(NSDateFormatter *)longDateFormatterWithDefaultTimeZone;
+(NSDateFormatter *)mediumDateFormatterWithUTCTimeZone;
+(NSDateFormatter *)mediumDateFormatterWithDefaultTimeZone;
+(NSDateFormatter *)timeFormatterWithUTCTimeZone;
+(NSDateFormatter *)timeFormatterWithDefaultTimeZone;
+(NSDateFormatter *)twitterFormatterWithDefaultTimeZone;
+(NSDateFormatter *)iso8601FormatterWithUTCTimeZone;

@end
