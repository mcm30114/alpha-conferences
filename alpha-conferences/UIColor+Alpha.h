//
//  UIColor+Alpha.h
//  alpha-conferences
//
//  Created by Cameron Cooke on 16/04/2012.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Session.h"

@interface UIColor (Alpha)

// utility method to create a UIColor object from a hexadecimal colour code
+ (UIColor *)colorWithHex:(NSUInteger)colorHex;

// tint colour for all UINavigationBar objects
+ (UIColor *)navigationBarTintColour;

// default table cell colour
+ (UIColor *)tableCellTitleColour;
+ (UIColor *)tableSubTitleColour;

+ (UIColor *)colorWithSessionType:(SessionType)type;

+ (UIColor *)disabledButtonTextColour;

@end