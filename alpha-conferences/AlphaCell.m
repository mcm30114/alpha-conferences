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
@property (nonatomic, unsafe_unretained) UIView *colourBar;

@end


@implementation AlphaCell
@synthesize cellStyle = _cellStyle;
@synthesize barColour = _barColour;
@synthesize colourBar = _colourBar;
@synthesize cellImageView = _cellImageView;
@synthesize debugMode = _debugMode;


- (id)initWithStyle:(AlphaTableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:reuseIdentifier];
    if (self) {
        _cellStyle = style;
        _debugMode = NO;
        
        switch (style) {
                
            case AlphaTableViewCellWithColourBar: {
                UIView *colourBar = [[UIView alloc] initWithFrame:CGRectMake(0, 0, COLOUR_BAR_WIDTH, self.bounds.size.height)];
                colourBar.backgroundColor = [UIColor lightGrayColor];
                colourBar.autoresizingMask = UIViewAutoresizingFlexibleHeight;
                [self.contentView addSubview:colourBar];
                self.colourBar = colourBar;                
            }
            break;
                
            case AlphaTableViewCellWithImageLeft:
            case AlphaTableViewCellWithImageRight: {                
                UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectZero];
                imageView.clipsToBounds = YES;
                imageView.autoresizingMask = UIViewAutoresizingNone;
//                imageView.contentMode = UIViewContentModeScaleAspectFit;
                [self.contentView addSubview:imageView];
                self.cellImageView = imageView;
            }
            break;
                
            default:
                break;
        }        
    }
    return self;
}


- (void)layoutSubviews {
    [super layoutSubviews];
    
    // debug colour
    if (self.debugMode) {
        self.textLabel.backgroundColor = [UIColor redColor];
        self.detailTextLabel.backgroundColor = [UIColor greenColor];
        self.contentView.backgroundColor = [UIColor yellowColor];
        self.backgroundView.backgroundColor = [UIColor blueColor];
        self.cellImageView.backgroundColor = [UIColor purpleColor];        
    }

    // set default size of imageview    
    if (self.cellImageView.image != nil) {
        self.cellImageView.frame = CGRectMake(CELL_MARGIN, CGRectGetMidY(self.contentView.bounds) - (self.cellImageView.image.size.height / 2), self.cellImageView.image.size.width, self.cellImageView.image.size.height);
    }
    
    // calculate the available width for label minus the image/colour bar
    CGFloat labelMaxWidth = self.contentView.bounds.size.width - (self.cellImageView.frame.size.width + (CELL_MARGIN * 3));        
    if (self.cellStyle == AlphaTableViewCellWithColourBar) {
        labelMaxWidth -= self.colourBar.frame.size.width;
    }
    
    // get the frames
    CGRect textLabelFrame = self.textLabel.frame;
    CGRect detailTextLabelFrame = self.detailTextLabel.frame;    
    CGRect cellImageViewFrame = self.cellImageView.frame;
    
    // resize labels if wider than labelMaxWidth
    if (CGRectGetWidth(textLabelFrame) > labelMaxWidth) {
        CGSize textLabelNewSize = [self.textLabel.text sizeWithFont:[UIFont tableCellTitleFont] constrainedToSize:CGSizeMake(labelMaxWidth, 999) lineBreakMode:self.textLabel.lineBreakMode];            
        textLabelFrame.size = textLabelNewSize;
    }    
    if (CGRectGetWidth(detailTextLabelFrame) > labelMaxWidth) {
        CGSize detailTextLabelNewSize = [self.detailTextLabel.text sizeWithFont:[UIFont tableCellSubTitleFont] constrainedToSize:CGSizeMake(labelMaxWidth, 999) lineBreakMode:self.detailTextLabel.lineBreakMode];            
        detailTextLabelFrame.size = detailTextLabelNewSize;
    }      
    
    // adjust position of views if nessassary
    if (self.cellStyle == AlphaTableViewCellWithImageRight) {
        cellImageViewFrame.origin.x = (self.contentView.bounds.size.width - CGRectGetWidth(cellImageViewFrame)) - CELL_MARGIN;        
    }
    else if (self.cellStyle == AlphaTableViewCellWithImageLeft) {
        textLabelFrame.origin.x =  CGRectGetMinX(cellImageViewFrame) + CGRectGetWidth(cellImageViewFrame) + CELL_MARGIN;
        detailTextLabelFrame.origin.x = textLabelFrame.origin.x;
    }
    else if (self.cellStyle == AlphaTableViewCellWithColourBar) {
        textLabelFrame.origin.x = self.colourBar.frame.size.width + CELL_MARGIN;
        detailTextLabelFrame.origin.x = textLabelFrame.origin.x;
    }
    
    if (self.debugMode) {
        // debug messages
        NSLog(@"-------------------------");
        NSLog(@"contentView: h=%f", self.contentView.frame.size.height);
        NSLog(@"labelMaxWidth: %f", labelMaxWidth);
        NSLog(@"UIImage size: w=%f, h=%f", self.imageView.image.size.width, self.imageView.image.size.height);
        NSLog(@"textLabelFrame: x=%f, y=%f, w=%f, h=%f", textLabelFrame.origin.x, textLabelFrame.origin.y, textLabelFrame.size.width, textLabelFrame.size.height);
        NSLog(@"detailTextLabelFrame: x=%f, y=%f, w=%f, h=%f", detailTextLabelFrame.origin.x, detailTextLabelFrame.origin.y, detailTextLabelFrame.size.width, detailTextLabelFrame.size.height);
        NSLog(@"cellImageViewFrame: x=%f, y=%f, w=%f, h=%f", cellImageViewFrame.origin.x, cellImageViewFrame.origin.y, cellImageViewFrame.size.width, cellImageViewFrame.size.height); 
    }
    
    // set frames
    self.textLabel.frame = textLabelFrame;
    self.detailTextLabel.frame = detailTextLabelFrame;
    self.cellImageView.frame = cellImageViewFrame;
}


+ (CGFloat)heightForRowWithTableView:(UITableView *)tableView tableViewCellAccessoryType:(UITableViewCellAccessoryType)accessoryType alphaTableViewCellStyle:(AlphaTableViewCellStyle)style textLabelText:(NSString *)textLabelText detailTextLabelText:(NSString *)detailTextLabelText imageViewSize:(CGSize)imageViewSize {
    
    CGFloat height = 0.0;
    
    // left and right margin between cell and tableview
    CGFloat OUTER_MARGIN = (tableView.style == UITableViewStyleGrouped ? 10.0 : 0.0);

    
    // maximum width that a label can be
    CGFloat labelMaxWidth = (tableView.frame.size.width - (imageViewSize.width + (CELL_MARGIN * 3) + (OUTER_MARGIN * 2)));
    
    // if cell is AlphaTableViewCellWithColourBar style then adjust label width to accomodate for the colour bar
    if (style == AlphaTableViewCellWithColourBar) {
        labelMaxWidth -= COLOUR_BAR_WIDTH;
    }
    
    // if cell is displaying an accessory then adjust label to accomodate for it
    if (accessoryType != UITableViewCellAccessoryNone) {
        labelMaxWidth -= 20 + CELL_MARGIN;
    }
    
    CGSize titleSize = [textLabelText sizeWithFont:[UIFont tableCellTitleFont] constrainedToSize:CGSizeMake(labelMaxWidth, 999) lineBreakMode:UILineBreakModeWordWrap];
    height += titleSize.height;
    
    if (detailTextLabelText.length > 0) {
        CGSize subTitleSize = [detailTextLabelText sizeWithFont:[UIFont tableCellSubTitleFont] constrainedToSize:CGSizeMake(labelMaxWidth, 999) lineBreakMode:UILineBreakModeWordWrap];        
        height += subTitleSize.height;
    }
    
    // add extra margin above and below
    height += CELL_MARGIN;
    
    // make sure the cell accommodates the image and is no smaller than the default row height
    height = MAX(MAX(height, tableView.rowHeight), imageViewSize.height + (CELL_MARGIN * 2));
    
    NSLog(@"Calculated Cell Height: %f", height);
    NSLog(@"Calculated labelMaxWidth: %f", labelMaxWidth);
    NSLog(@"-------------------------");
    NSLog(@"***");
    
    return height;    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}


- (void)setBarColour:(UIColor *)barColour {
    _barColour = barColour;
    self.colourBar.backgroundColor = barColour;
}


- (void)setDebugMode:(BOOL)debugMode {
    _debugMode = debugMode;
    [self layoutSubviews];
}

@end