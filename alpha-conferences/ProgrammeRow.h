//
//  ProgrammeRow.h
//  alpha-conferences
//
//  Created by Erik Erskine on 26/04/2012.
//  Copyright (c) 2012 Brightec Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "StandardController.h"


@interface ProgrammeRow : NSObject

@property (nonatomic, strong) NSString *text;
@property (nonatomic, strong) NSString *speakerText;
@property (nonatomic, strong) NSString *dateTimeText;
@property (nonatomic, strong) NSString *venueText;
@property (nonatomic, strong) UIColor *barColour;
@property (nonatomic) UITableViewCellAccessoryType accessoryType;

@property (nonatomic, copy) void (^onSelected)(StandardController *controller);

-(NSString *)detailText;

@end
