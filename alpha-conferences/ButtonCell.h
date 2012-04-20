//
//  ButtonCell.h
//  alpha-conferences
//
//  Created by Erik Erskine on 20/04/2012.
//  Copyright (c) 2012 Brightec Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ButtonBarRow.h"

@class StandardController;


@interface ButtonCell : UITableViewCell

- (id)initWithButtonBarRow:(ButtonBarRow *)metadata;

@end
