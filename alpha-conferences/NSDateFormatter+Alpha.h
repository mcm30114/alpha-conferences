//
//  NSDateFormatter+Alpha.h
//  alpha-conferences
//
//  Created by Erik Erskine on 20/04/2012.
//  Copyright (c) 2012 Brightec Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface NSDateFormatter (Alpha)

+(NSDateFormatter *)longDateFormatter;
+(NSDateFormatter *)mediumDateFormatter;
+(NSDateFormatter *)timeFormatter;

@end
