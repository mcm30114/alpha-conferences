//
//  AlphaCell.h
//  alpha-conferences
//
//  Created by Cameron Cooke on 17/04/2012.
//  Copyright (c) 2012 Brightec Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum {
    AlphaTableViewCellNormal,
    AlphaTableViewCellWithImageLeft,
    AlphaTableViewCellWithImageRight,    
    AlphaTableViewCellWithColourBar
} AlphaTableViewCellStyle;


@interface AlphaCell : UITableViewCell

@property (nonatomic, strong) UIColor *barColour;
@property (nonatomic, unsafe_unretained) UIImageView *cellImageView;
@property (nonatomic) BOOL debugMode;

- (id)initWithStyle:(AlphaTableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier;

+ (CGFloat)heightForRowWithTableView:(UITableView *)tableView tableViewCellAccessoryType:(UITableViewCellAccessoryType)accessoryType alphaTableViewCellStyle:(AlphaTableViewCellStyle)style textLabelText:(NSString *)textLabelText detailTextLabelText:(NSString *)detailTextLabelText imageViewSize:(CGSize)imageViewSize;

@end