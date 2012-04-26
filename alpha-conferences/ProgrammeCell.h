//
//  ProgrammeCell.h
//  alpha-conferences
//
//  Created by Cameron Cooke on 25/04/2012.
//  Copyright (c) 2012 Brightec Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LabelTextProperties.h"

@interface ProgrammeCell : UITableViewCell

@property (nonatomic, strong) UIColor *barColour;
@property (nonatomic, unsafe_unretained) UILabel *speakerTextLabel;
@property (nonatomic, unsafe_unretained) UILabel *timeTextLabel;

- (id)initWithReuseIdentifier:(NSString *)reuseIdentifier;
+ (CGFloat)heightForRowWithTableView:(UITableView *)tableView tableViewCellAccessoryType:(UITableViewCellAccessoryType)cellAccessoryType labelTextStrings:(NSArray *)labelTextStrings labelTextProperties:(NSArray *)labelTextProperties;

@end