//
//  ProgrammeCell.m
//  alpha-conferences
//
//  Created by Cameron Cooke on 25/04/2012.
//  Copyright (c) 2012 Brightec Ltd. All rights reserved.
//

#import "ProgrammeCell.h"


@interface ProgrammeCell ()
@property (nonatomic, unsafe_unretained) UIView *colourBar;
@end


@implementation ProgrammeCell
@synthesize barColour = _barColour;
@synthesize colourBar = _colourBar;

- (id)initWithReuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:reuseIdentifier];
    if (self) {
        
        // create colour bar
        UIView *colourBar = [[UIView alloc] initWithFrame:CGRectZero];
        colourBar.backgroundColor = [UIColor grayColor];
        colourBar.autoresizingMask = UIViewAutoresizingFlexibleHeight|UIViewAutoresizingFlexibleRightMargin;
        [self.contentView addSubview:colourBar];
    }
    return self;
}


- (void)layoutSubviews {
    [super layoutSubviews];
    
    // create frame for colour bar
    self.colourBar.frame = CGRectMake(0, 0, 10, self.contentView.bounds.size.height);
}


- (void)setBarColour:(UIColor *)barColour {
    _barColour = barColour;
    self.colourBar.backgroundColor = barColour;
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


@end