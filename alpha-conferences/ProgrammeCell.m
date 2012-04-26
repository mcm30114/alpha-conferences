//
//  ProgrammeCell.m
//  alpha-conferences
//
//  Created by Cameron Cooke on 25/04/2012.
//  Copyright (c) 2012 Brightec Ltd. All rights reserved.
//

#import "ProgrammeCell.h"

#define CELL_MARGIN 10.0
#define COLOUR_BAR_WIDTH 10.0

@interface ProgrammeCell ()
@property (nonatomic, unsafe_unretained) UIView *colourBar;
@end


@implementation ProgrammeCell
@synthesize barColour = _barColour;
@synthesize colourBar = _colourBar;
@synthesize speakerTextLabel = _speakerTextLabel;
@synthesize timeTextLabel = _timeTextLabel;


- (id)initWithReuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:reuseIdentifier];
    if (self) {
        
        // create colour bar
        UIView *colourBar = [[UIView alloc] initWithFrame:CGRectZero];
        colourBar.backgroundColor = [UIColor grayColor];
        colourBar.autoresizingMask = UIViewAutoresizingFlexibleHeight|UIViewAutoresizingFlexibleRightMargin;
        [self.contentView addSubview:colourBar];
        self.colourBar = colourBar;
        
        // create additonal labels
        UILabel *speakerLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        speakerLabel.autoresizingMask = UIViewAutoresizingFlexibleWidth;
        speakerLabel.lineBreakMode = UILineBreakModeWordWrap;
        speakerLabel.numberOfLines = 0;        
        [self.contentView addSubview:speakerLabel];
        self.speakerTextLabel = speakerLabel;

        UILabel *timeLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        timeLabel.autoresizingMask = UIViewAutoresizingFlexibleWidth;
        timeLabel.lineBreakMode = UILineBreakModeWordWrap;
        timeLabel.numberOfLines = 0;        
        [self.contentView addSubview:timeLabel];
        self.timeTextLabel = timeLabel;        
        
        // configure existing label views
        self.textLabel.lineBreakMode = UILineBreakModeWordWrap;
        self.textLabel.numberOfLines = 0;
        self.detailTextLabel.lineBreakMode = UILineBreakModeWordWrap;
        self.detailTextLabel.numberOfLines = 0;           
    }
    return self;
}


- (void)layoutSubviews {
    [super layoutSubviews];
    
    // debug
//    self.textLabel.backgroundColor = [UIColor redColor];
//    self.detailTextLabel.backgroundColor = [UIColor greenColor];
//    self.contentView.backgroundColor = [UIColor yellowColor];
//    self.speakerTextLabel.backgroundColor = [UIColor purpleColor];
//    self.timeTextLabel.backgroundColor = [UIColor orangeColor];
    
    // set colour bar frame
    self.colourBar.frame = CGRectMake(0, 0, COLOUR_BAR_WIDTH, self.contentView.bounds.size.height);
    
    // calculate content width
    CGFloat contentWidth = self.contentView.bounds.size.width - (self.colourBar.frame.size.width + (CELL_MARGIN *2));    
    
    // get the frames
    CGRect textLabelFrame = self.textLabel.frame;
    CGRect detailTextLabelFrame = self.detailTextLabel.frame;    
    CGRect speakerTextLabelFrame = self.speakerTextLabel.frame;
    CGRect timeTextLabelFrame = self.timeTextLabel.frame;
    
    // set size of labels
    textLabelFrame.size = [self.textLabel.text sizeWithFont:self.textLabel.font constrainedToSize:CGSizeMake(contentWidth, 999) lineBreakMode:self.textLabel.lineBreakMode];
    detailTextLabelFrame.size = [self.detailTextLabel.text sizeWithFont:self.detailTextLabel.font constrainedToSize:CGSizeMake(contentWidth, 999) lineBreakMode:self.detailTextLabel.lineBreakMode];
    speakerTextLabelFrame.size = [self.speakerTextLabel.text sizeWithFont:self.speakerTextLabel.font constrainedToSize:CGSizeMake(contentWidth, 999) lineBreakMode:self.speakerTextLabel.lineBreakMode];
    timeTextLabelFrame.size = [self.timeTextLabel.text sizeWithFont:self.timeTextLabel.font constrainedToSize:CGSizeMake(contentWidth, 999) lineBreakMode:self.timeTextLabel.lineBreakMode];
    
    // vertically center labels
    textLabelFrame.origin.y = floor(CGRectGetMidY(self.contentView.bounds)) - ((textLabelFrame.size.height + detailTextLabelFrame.size.height + speakerTextLabelFrame.size.height + timeTextLabelFrame.size.height) / 2);
    detailTextLabelFrame.origin.y = textLabelFrame.origin.y + textLabelFrame.size.height;
    speakerTextLabelFrame.origin.y = detailTextLabelFrame.origin.y + detailTextLabelFrame.size.height;
    timeTextLabelFrame.origin.y = speakerTextLabelFrame.origin.y + speakerTextLabelFrame.size.height;    
    
    // adjust x coordinate of labels
    textLabelFrame.origin.x = self.colourBar.bounds.size.width + CELL_MARGIN;
    detailTextLabelFrame.origin.x = textLabelFrame.origin.x;
    speakerTextLabelFrame.origin.x = textLabelFrame.origin.x;
    timeTextLabelFrame.origin.x = textLabelFrame.origin.x;
    
    // set frames
    self.textLabel.frame = CGRectIntegral(textLabelFrame);
    self.detailTextLabel.frame = CGRectIntegral(detailTextLabelFrame);    
    self.speakerTextLabel.frame = CGRectIntegral(speakerTextLabelFrame);
    self.timeTextLabel.frame = CGRectIntegral(timeTextLabelFrame);
}


+ (CGFloat)heightForRowWithTableView:(UITableView *)tableView tableViewCellAccessoryType:(UITableViewCellAccessoryType)cellAccessoryType labelTextStrings:(NSArray *)labelTextStrings labelTextProperties:(NSArray *)labelTextProperties {

    // top margin
    CGFloat height = CELL_MARGIN;
    
    // calculate the left and right outer margin (needed for calculating available content width)
    CGFloat HORIZONTAL_GROUPED_TABLE_OUTER_MARGIN = (tableView.style == UITableViewStyleGrouped ? 10.0 : 0.0);    
    
    // calculate the available content area width after accomodating for other elements
    CGFloat contentWidth = (tableView.frame.size.width - (COLOUR_BAR_WIDTH  + (CELL_MARGIN *2) + (HORIZONTAL_GROUPED_TABLE_OUTER_MARGIN * 2)));    
    
    // if cell is displaying an accessory then adjust label to accomodate for it
    if (cellAccessoryType != UITableViewCellAccessoryNone) {
        contentWidth -= 20;
    }    
    
    for (int i = 0; i < labelTextStrings.count; i++) {
        NSString *text = (NSString  *)[labelTextStrings objectAtIndex:i];
        LabelTextProperties *textProperties = (LabelTextProperties *)[labelTextProperties objectAtIndex:i];
        
        CGSize labelSize = [text sizeWithFont:textProperties.font constrainedToSize:CGSizeMake(contentWidth, 999) lineBreakMode:textProperties.lineBreakMode];
        height += labelSize.height;
    }
    
    // bottom margin
    height += CELL_MARGIN;
    
    return MAX(height, tableView.rowHeight);
}


- (void)setBarColour:(UIColor *)barColour {
    _barColour = barColour;
    self.colourBar.backgroundColor = barColour;
    [self layoutSubviews];
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


@end