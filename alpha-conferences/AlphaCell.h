//
//  AlphaCell.h
//  alpha-conferences
//
//  Created by Cameron Cooke on 17/04/2012.
//  Copyright (c) 2012 Brightec Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum {
    AlphaTableViewCellWithImageLeft,
    AlphaTableViewCellWithImageRight    
} AlphaTableViewCellStyle;


@interface AlphaCell : UITableViewCell

- (id)initWithStyle:(AlphaTableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier;

+ (CGFloat)heightForRowWithTableView:(UITableView *)tableView tableViewCellAccessoryType:(UITableViewCellAccessoryType)accessoryType textLabelText:(NSString *)textLabelText detailTextLabelText:(NSString *)detailTextLabelText imageViewImage:(UIImage *)imageViewImage;

@end