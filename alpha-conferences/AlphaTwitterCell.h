//
//  AlphaTwitterCell.h
//  AlphaTwitterCell
//
//  Created by Cameron Cooke on 26/04/2012.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AlphaTwitterCell : UITableViewCell

@property (nonatomic, unsafe_unretained) UIImageView *cellImageView;
@property (nonatomic, unsafe_unretained) UILabel *dateTextLabel;

+ (CGFloat)heightForRowWithTableView:(UITableView *)tableView tableViewCellAccessoryType:(UITableViewCellAccessoryType)cellAccessoryType labelTextStrings:(NSArray *)labelTextStrings labelTextProperties:(NSArray *)labelTextProperties imageSize:(CGSize)imageSize;

@end