//
//  UIColor+Alpha.m
//  alpha-conferences
//
//  Created by Cameron Cooke on 16/04/2012.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "UIColor+Alpha.h"

@implementation UIColor (Alpha)

+ (UIColor *)colorWithHex:(int)colorHex {
    return [UIColor colorWithRed:((colorHex>>24)&0xFF)/255.0
                           green:((colorHex>>16)&0xFF)/255.0
                            blue:((colorHex>>8)&0xFF)/255.0
                           alpha:((colorHex)&0xFF)/255.0];
}


@end