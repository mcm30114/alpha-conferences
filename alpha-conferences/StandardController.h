//
//  StandardController.h
//  alpha-conferences
//
//  Created by Erik Erskine on 19/04/2012.
//  Copyright (c) 2012 Brightec Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AlphaPager.h"
#import "StandardControllerModel.h"


@interface StandardController : UIViewController <UITableViewDataSource, UITableViewDelegate, AlphaPagerDelegate>

@property (nonatomic, strong) id<StandardControllerModel> model;

- (id)initWithStyle:(UITableViewStyle)style pager:(BOOL)pager;

@end
