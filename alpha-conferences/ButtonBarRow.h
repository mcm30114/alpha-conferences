//
//  ButtonBarRow.h
//  alpha-conferences
//
//  Created by Erik Erskine on 19/04/2012.
//  Copyright (c) 2012 Brightec Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface ButtonBarRow : NSObject

@property (nonatomic, strong) NSString *button1Title;
@property (nonatomic, copy) void (^onButton1Selected)(UIViewController *controller);

@property (nonatomic, strong) NSString *button2Title;
@property (nonatomic, copy) void (^onButton2Selected)(UIViewController *controller);

@end
