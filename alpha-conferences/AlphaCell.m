//
//  AlphaCell.m
//  alpha-conferences
//
//  Created by Cameron Cooke on 17/04/2012.
//  Copyright (c) 2012 Brightec Ltd. All rights reserved.
//

#import "AlphaCell.h"

#define CELL_MARGIN 10

@interface AlphaCell ()
@property (nonatomic) AlphaTableViewCellStyle cellStyle;
@end


@implementation AlphaCell
@synthesize cellStyle = _cellStyle;

- (id)initWithStyle:(AlphaTableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:reuseIdentifier];
    if (self) {
        _cellStyle = style;
    }
    return self;
}


- (void)layoutSubviews {
    [super layoutSubviews];
    
    // debug colour
    self.textLabel.backgroundColor = [UIColor redColor];
    self.detailTextLabel.backgroundColor = [UIColor greenColor];
    
    // calculate the available width for label minus the image
    CGFloat contentWidth = self.contentView.bounds.size.width - (self.imageView.frame.size.width + (CELL_MARGIN * 2));        
    
    if (self.cellStyle == AlphaTableViewCellWithImageRight) {
        CGRect imageViewFrame = self.imageView.frame;
        imageViewFrame.origin.x = (self.contentView.bounds.size.width - imageViewFrame.size.width) - CELL_MARGIN;
        self.imageView.frame = imageViewFrame;
        
        CGRect textLabelFrame = self.textLabel.frame;
        textLabelFrame.origin.x = CELL_MARGIN;
        self.textLabel.frame = textLabelFrame;
        
        CGRect detailTextLabelFrame = self.detailTextLabel.frame;
        detailTextLabelFrame.origin.x = CELL_MARGIN;
        self.detailTextLabel.frame = detailTextLabelFrame;        
    }
}


+ (CGFloat)heightForRowWithTableView:(UITableView *)tableView tableViewCellAccessoryType:(UITableViewCellAccessoryType)accessoryType textLabelText:(NSString *)textLabelText detailTextLabelText:(NSString *)detailTextLabelText imageViewImage:(UIImage *)imageViewImage {
    
    CGFloat height = 0.0;
    
    // left and right margin between cell and tableview
    CGFloat OUTER_MARGIN = (tableView.style == UITableViewStyleGrouped ? 10.0 : 0.0);

    
    // maximum width that a label can be
    CGFloat labelMaxWidth = (tableView.frame.size.width - (imageViewImage.size.width + (CELL_MARGIN * 2) + (OUTER_MARGIN * 2)));
    
    if (accessoryType != UITableViewCellAccessoryNone) {
        labelMaxWidth -= 20 + CELL_MARGIN;
    }
    
    CGSize titleSize = [textLabelText sizeWithFont:[UIFont tableCellTitleFont] constrainedToSize:CGSizeMake(labelMaxWidth, 999) lineBreakMode:UILineBreakModeWordWrap];
    height += titleSize.height;
    
    if (detailTextLabelText.length > 0) {
        CGSize subTitleSize = [detailTextLabelText sizeWithFont:[UIFont tableCellSubTitleFont] constrainedToSize:CGSizeMake(labelMaxWidth, 999) lineBreakMode:UILineBreakModeWordWrap];        
        height += subTitleSize.height + 10;
    }
    
    // make sure the cell accommodates the image and is no smaller than the default row height
    height = MAX(MAX(height, tableView.rowHeight), imageViewImage.size.height + (CELL_MARGIN * 2));
    
    return height;    
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}


@end