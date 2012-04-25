//
//  PageViewController.h
//  alpha-conferences
//
//  Created by Erik Erskine on 23/04/2012.
//  Copyright (c) 2012 Brightec Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface PageViewController : UIViewController <UIWebViewDelegate>

@property (nonatomic, strong) NSString *pageTitle;
@property (nonatomic, strong) NSString *pageContent;

- (id)initWithPageTitle:(NSString *)pageTitle pageContent:(NSString *)pageContent;

- (void)refresh;

@end
