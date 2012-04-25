//
//  UIColor+Alpha.m
//  alpha-conferences
//
//  Created by Cameron Cooke on 16/04/2012.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "UIColor+Alpha.h"

@implementation UIColor (Alpha)

+ (UIColor *)colorWithHex:(NSUInteger)colorHex {
    return [UIColor colorWithRed:((colorHex>>24)&0xFF)/255.0
                           green:((colorHex>>16)&0xFF)/255.0
                            blue:((colorHex>>8)&0xFF)/255.0
                           alpha:((colorHex)&0xFF)/255.0];
}


+ (UIColor *)navigationBarTintColour {
    return [UIColor colorWithRed:0.88f green:0.43f blue:0.18f alpha:1.00f];
}


+ (UIColor *)tableCellTitleColour {
    return [UIColor blackColor];
}


+ (UIColor *)tableSubTitleColour {
    return [UIColor grayColor];
}


+ (UIColor *)colorWithSessionType:(SessionType)type {
    switch (type) {
        case SessionTypeAdmin:
            return [UIColor lightGrayColor];
        case SessionTypeSeminarSlot:
            return [UIColor lightGrayColor];
        case SessionTypeBreak:
            return [UIColor lightGrayColor];
        default:
            return [UIColor lightGrayColor];
    }
}


@end