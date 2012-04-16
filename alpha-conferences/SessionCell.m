//
//  SessionCell.m
//  alpha-conferences
//
//  Created by Cameron Cooke on 16/04/2012.
//  Copyright (c) 2012 Brightec Ltd. All rights reserved.
//

#import "SessionCell.h"

@interface SessionCell ()
@property (nonatomic, unsafe_unretained) UIView *colourBar;
@end


@implementation SessionCell

@synthesize barColour = _barColour;
@synthesize colourBar = _colourBar;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        UIView *colourBar = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, self.bounds.size.height)];
        colourBar.backgroundColor = [UIColor lightGrayColor];
        colourBar.autoresizingMask = UIViewAutoresizingFlexibleHeight;
        [self.contentView addSubview:colourBar];
        self.colourBar = colourBar;
        
        self.textLabel.lineBreakMode = UILineBreakModeTailTruncation;
        self.detailTextLabel.lineBreakMode = UILineBreakModeWordWrap;
        self.detailTextLabel.numberOfLines = 100;
    }
    return self;
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}


- (void)layoutSubviews {
    [super layoutSubviews];
//    
//    self.textLabel.backgroundColor = [UIColor redColor];
//    self.detailTextLabel.backgroundColor = [UIColor blueColor];
    
    
    CGFloat contentWidth = (self.contentView.bounds.size.width - (self.colourBar.frame.size.width+10));    
    
    
    // text label
    CGSize textLabelSize = [self.textLabel.text sizeWithFont:self.textLabel.font constrainedToSize:CGSizeMake(contentWidth, 999) lineBreakMode:self.textLabel.lineBreakMode];
    
    CGRect textLabelFrame = self.textLabel.frame;    
    textLabelFrame.origin.x += 10;
    textLabelFrame.size.width = textLabelSize.width;
    textLabelFrame.size.height = textLabelSize.height;
    self.textLabel.frame = textLabelFrame;
    
    
    // detail label    
    CGSize detailTextLabelSize = [self.detailTextLabel.text sizeWithFont:self.detailTextLabel.font constrainedToSize:CGSizeMake(contentWidth, 999) lineBreakMode:self.detailTextLabel.lineBreakMode];
    
    CGRect detailTextLabelFrame = self.detailTextLabel.frame;    
    detailTextLabelFrame.origin.x += 10;
    detailTextLabelFrame.size.width = detailTextLabelSize.width;
    detailTextLabelFrame.size.height = detailTextLabelSize.height;    
    self.detailTextLabel.frame = detailTextLabelFrame;  
}


- (void)setBarColour:(UIColor *)barColour {
    _barColour = barColour;
    self.colourBar.backgroundColor = barColour;
}


@end