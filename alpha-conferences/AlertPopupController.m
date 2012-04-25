//
//  AlertPopupController.m
//  alpha-conferences
//
//  Created by Erik Erskine on 25/04/2012.
//  Copyright (c) 2012 Brightec Ltd. All rights reserved.
//

#import "AlertPopupController.h"
#import "Constants.h"
#import "DataStore.h"
#import "Alert.h"


@interface AlertPopupController()

@property (nonatomic, readonly) NSInteger alertId;

- (void)dataWasUpdated:(NSNotification *)notification;

- (void)cancelButtonTapped;

@end



@implementation AlertPopupController

@synthesize alertId = _alertId;


- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}


- (id)initWithAlertId:(NSInteger)alertId {
    if (self = [super initWithPageTitle:nil pageContent:nil]) {
        _alertId = alertId;
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(dataWasUpdated:)
                                                     name:NOTIFICATION_DATA
                                                   object:nil];
    }
    return self;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel
                                                                                           target:self
                                                                                           action:@selector(cancelButtonTapped)];
}


- (void)dataWasUpdated:(NSNotification *)notification {
    DataStore *data = notification.object;
    Alert *a = [data alertWithId:self.alertId];
    self.pageTitle = a.title;
    self.pageContent = a.message;
    [self refresh];
}


- (void)cancelButtonTapped {
    [self dismissModalViewControllerAnimated:YES];
}


@end
