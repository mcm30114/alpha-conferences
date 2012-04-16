//
//  UIColor+Alpha.h
//  alpha-conferences
//
//  Created by Cameron Cooke on 16/04/2012.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (Alpha)

// utility method to create a UIColor object from a hexadecimal colour code
+ (UIColor *)colorWithHex:(int)colorHex;

@end