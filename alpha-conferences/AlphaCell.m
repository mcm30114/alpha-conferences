//
//  AlphaCell.m
//  alpha-conferences
//
//  Created by Cameron Cooke on 17/04/2012.
//  Copyright (c) 2012 Brightec Ltd. All rights reserved.
//

#import "AlphaCell.h"

#define CELL_MARGIN 10
#define COLOUR_BAR_WIDTH 10


@interface AlphaCell ()
@property (nonatomic) AlphaTableViewCellStyle cellStyle;
@end


@implementation AlphaCell
@synthesize cellStyle = _cellStyle;
@synthesize cellImageView = _cellImageView;


- (id)initWithStyle:(AlphaTableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:reuseIdentifier];
    if (self) {
        _cellStyle = style;
        
        if (style == AlphaTableViewCellWithImageLeft || style == AlphaTableViewCellWithImageRight) {
            UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectZero];
            imageView.clipsToBounds = YES;
            imageView.autoresizingMask = UIViewAutoresizingNone;
            [self.contentView addSubview:imageView];
            self.cellImageView = imageView;            
        }
        
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
//    self.backgroundView.backgroundColor = [UIColor blueColor];
//    self.cellImageView.backgroundColor = [UIColor purpleColor];         

    // set ImageView frame
    if (self.cellImageView.image != nil) {
        self.cellImageView.frame = CGRectMake(CELL_MARGIN, floor(CGRectGetMidY(self.contentView.bounds)) - floor(self.cellImageView.image.size.height / 2), self.cellImageView.image.size.width, self.cellImageView.image.size.height);
    }
    
    // calculate content width
    int numberOfMargins = (self.cellImageView.image ? 3 : 2);
    CGFloat contentWidth = self.contentView.bounds.size.width - (self.cellImageView.frame.size.width + (CELL_MARGIN *numberOfMargins));        
    
    // get the frames
    CGRect textLabelFrame = self.textLabel.frame;
    CGRect detailTextLabelFrame = self.detailTextLabel.frame;    
    CGRect cellImageViewFrame = self.cellImageView.frame;
    
    // set size of labels
    textLabelFrame.size = [self.textLabel.text sizeWithFont:self.textLabel.font constrainedToSize:CGSizeMake(contentWidth, 999) lineBreakMode:self.textLabel.lineBreakMode];
    detailTextLabelFrame.size = [self.detailTextLabel.text sizeWithFont:self.detailTextLabel.font constrainedToSize:CGSizeMake(contentWidth, 999) lineBreakMode:self.detailTextLabel.lineBreakMode];    
    
    // vertically center labels
    textLabelFrame.origin.y = floor(CGRectGetMidY(self.contentView.bounds)) - ((textLabelFrame.size.height + detailTextLabelFrame.size.height) / 2);
    detailTextLabelFrame.origin.y = textLabelFrame.origin.y + textLabelFrame.size.height;
    
    // adjust x coordinate of labels
    textLabelFrame.origin.x = CELL_MARGIN;
    detailTextLabelFrame.origin.x = textLabelFrame.origin.x;
    
    if (self.cellStyle == AlphaTableViewCellWithImageRight) {
        cellImageViewFrame.origin.x = (self.contentView.bounds.size.width - CGRectGetWidth(cellImageViewFrame)) - CELL_MARGIN;        
    }
    else if (self.cellStyle == AlphaTableViewCellWithImageLeft) {
        textLabelFrame.origin.x =  CGRectGetMinX(cellImageViewFrame) + CGRectGetWidth(cellImageViewFrame) + CELL_MARGIN;
        detailTextLabelFrame.origin.x = textLabelFrame.origin.x;
    }
    
    // set frames
    self.textLabel.frame = CGRectIntegral(textLabelFrame);
    self.detailTextLabel.frame = CGRectIntegral(detailTextLabelFrame);
    self.cellImageView.frame = CGRectIntegral(cellImageViewFrame);
}


+ (CGFloat)heightForRowWithTableView:(UITableView *)tableView tableViewCellAccessoryType:(UITableViewCellAccessoryType)cellAccessoryType labelTextStrings:(NSArray *)labelTextStrings labelTextProperties:(NSArray *)labelTextProperties imageSize:(CGSize)imageSize {
    
    // top margin
    CGFloat height = CELL_MARGIN;
    
    // calculate the left and right outer margin (needed for calculating available content width)
    CGFloat HORIZONTAL_GROUPED_TABLE_OUTER_MARGIN = (tableView.style == UITableViewStyleGrouped ? 10.0 : 0.0);    
    
    // calculate the available content area width after accomodating for other elements
    int numberOfMargins = (imageSize.width > 0 ? 3 : 2);
    CGFloat contentWidth = (tableView.frame.size.width - (imageSize.width  + (CELL_MARGIN *numberOfMargins) + (HORIZONTAL_GROUPED_TABLE_OUTER_MARGIN * 2)));    
    
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
    
    return MAX(MAX(height, (imageSize.height + (CELL_MARGIN * 2))), tableView.rowHeight);
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}


@end