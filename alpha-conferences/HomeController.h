//
//  HomeController.h
//  alpha-conferences
//
//  Created by Erik Erskine on 23/04/2012.
//  Copyright (c) 2012 Brightec Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Conference.h"


@interface HomeController : UIViewController <UITableViewDataSource, UITableViewDelegate>

- (id)initForHome;
- (id)initWithConference:(Conference *)conference;

@end
