//
//  AlphaCell.h
//  alpha-conferences
//
//  Created by Cameron Cooke on 17/04/2012.
//  Copyright (c) 2012 Brightec Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LabelTextProperties.h"

typedef enum {
    AlphaTableViewCellNormal,
    AlphaTableViewCellWithImageLeft,
    AlphaTableViewCellWithImageRight
} AlphaTableViewCellStyle;


@interface AlphaCell : UITableViewCell

@property (nonatomic, unsafe_unretained) UIImageView *cellImageView;

- (id)initWithStyle:(AlphaTableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier;
+ (CGFloat)heightForRowWithTableView:(UITableView *)tableView tableViewCellAccessoryType:(UITableViewCellAccessoryType)cellAccessoryType labelTextStrings:(NSArray *)labelTextStrings labelTextProperties:(NSArray *)labelTextProperties imageSize:(CGSize)imageSize;

@end