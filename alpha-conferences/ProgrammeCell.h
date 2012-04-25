//
//  ProgrammeCell.h
//  alpha-conferences
//
//  Created by Cameron Cooke on 25/04/2012.
//  Copyright (c) 2012 Brightec Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ProgrammeCell : UITableViewCell

@property (nonatomic, strong) UIColor *barColour;

- (id)initWithReuseIdentifier:(NSString *)reuseIdentifier;

@end