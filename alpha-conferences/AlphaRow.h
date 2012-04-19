//
//  AlphaRow.h
//  alpha-conferences
//
//  Created by Erik Erskine on 19/04/2012.
//  Copyright (c) 2012 Brightec Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AlphaCell.h"


@interface AlphaRow : NSObject

@property (nonatomic, strong) NSString *text;
@property (nonatomic, strong) NSString *detailText;
@property (nonatomic) UITableViewCellAccessoryType accessoryType;
@property (nonatomic) AlphaTableViewCellStyle style;
@property (nonatomic, strong) UIImage *image;

@end
