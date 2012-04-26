//
//  LabelTextProperties.h
//  AlphaProgrammeCell
//
//  Created by Cameron Cooke on 25/04/2012.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LabelTextProperties : NSObject

@property (nonatomic, strong) UIFont *font;
@property (nonatomic, strong) UIColor *textColour;
@property (nonatomic) UILineBreakMode lineBreakMode;

-(id)initWithFont:(UIFont *)font textColour:(UIColor *)textColour lineBreakMode:(UILineBreakMode)lineBreakMode;
-(void)setPropertiesForLabel:(UILabel *)label;

@end