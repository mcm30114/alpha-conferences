//
//  ButtonCell.m
//  alpha-conferences
//
//  Created by Erik Erskine on 20/04/2012.
//  Copyright (c) 2012 Brightec Ltd. All rights reserved.
//

#import "ButtonCell.h"
#import "UIColor+Alpha.h"


@interface ButtonCell () {
    @private
    UIButton *button1;
    UIButton *button2;
    __unsafe_unretained UIViewController *controller;
}

@property (nonatomic, copy) void (^onButton1Selected)();
@property (nonatomic, copy) void (^onButton2Selected)();

- (void)handleButtonTap:(id)sender;

@end



@implementation ButtonCell

@synthesize onButton1Selected = _onButton1Selected;
@synthesize onButton2Selected = _onButton2Selected;


- (id)initWithButtonBarRow:(ButtonBarRow *)metadata controller:(UIViewController *)c {
    if (self = [super initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil]) {
        controller = c;
        
        self.backgroundView = [[UIView alloc] initWithFrame:CGRectZero];
        self.backgroundView.backgroundColor = [UIColor clearColor];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        self.onButton1Selected = metadata.onButton1Selected;
        self.onButton2Selected = metadata.onButton2Selected;

        button1 = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        [button1 setTitle:metadata.button1Title forState:UIControlStateNormal];
        [button1 addTarget:self action:@selector(handleButtonTap:) forControlEvents:UIControlEventTouchUpInside];
        [button1 setTitleColor:[UIColor disabledButtonTextColour] forState:UIControlStateDisabled];
        button1.enabled = (metadata.onButton1Selected != nil);
        
        if (metadata.button2Title) {
            button2 = [UIButton buttonWithType:UIButtonTypeRoundedRect];
            [button2 setTitle:metadata.button2Title forState:UIControlStateNormal];
            [button2 addTarget:self action:@selector(handleButtonTap:) forControlEvents:UIControlEventTouchUpInside];
            [button2 setTitleColor:[UIColor disabledButtonTextColour] forState:UIControlStateDisabled];
            button2.enabled = (metadata.onButton2Selected != nil);
        } else {
            button2 = nil;
        }

        // arrange
        if (button2) {
            float w = (self.contentView.bounds.size.width/2)-10;
            button1.frame = CGRectMake(0, 0, w, self.contentView.bounds.size.height);
            button1.autoresizingMask = UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
            [self.contentView addSubview:button1];
            button2.frame = CGRectMake(w+20, 0, w, self.contentView.bounds.size.height);
            button2.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
            [self.contentView addSubview:button2];
        } else {
            button1.frame = CGRectMake(0, 0, self.contentView.bounds.size.width, self.contentView.bounds.size.height);
            button1.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
            [self.contentView addSubview:button1];
        }
        
    }
    return self;
}


- (void)handleButtonTap:(id)sender {
    if (sender == button1) {
        if (self.onButton1Selected) {
            self.onButton1Selected(controller);
        }
    } else if (sender == button2) {
        if (self.onButton2Selected) {
            self.onButton2Selected(controller);
        }
    }
}


@end
