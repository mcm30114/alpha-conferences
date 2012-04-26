//
//  LabelTextProperties.m
//  AlphaProgrammeCell
//
//  Created by Cameron Cooke on 25/04/2012.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "LabelTextProperties.h"

@implementation LabelTextProperties
@synthesize font = _font;
@synthesize textColour = _textColour;
@synthesize lineBreakMode = _lineBreakMode;


- (id)initWithFont:(UIFont *)font textColour:(UIColor *)textColour lineBreakMode:(UILineBreakMode)lineBreakMode {
    self = [super init];
    if (self) {
        _font = font;
        _textColour = textColour;
        _lineBreakMode = lineBreakMode;
    }
    return self;
}


-(void)setPropertiesForLabel:(UILabel *)label {
    label.font = self.font;
    label.textColor = self.textColour;
    label.lineBreakMode = self.lineBreakMode;
}


@end