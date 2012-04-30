//
//  FloorplanController.m
//  alpha-conferences
//
//  Created by Erik Erskine on 23/04/2012.
//  Copyright (c) 2012 Brightec Ltd. All rights reserved.
//

#import "FloorplanController.h"
#import "ResourceCache.h"


@interface FloorplanController () {
    Resource *resource;
}

@end



@implementation FloorplanController


- (id)initWithResource:(Resource *)r {
    if (self = [super initWithNibName:nil bundle:nil]) {
        resource = r;
    }
    return self;
}


- (void)loadView {
    UIWebView *wv = [[UIWebView alloc] initWithFrame:[[UIScreen mainScreen] applicationFrame]];
    wv.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    wv.scalesPageToFit = YES;
    self.view = wv;
}


- (void)viewDidLoad {
    UIWebView *wv = (UIWebView *)self.view;
    [[ResourceCache defaultResourceCache] dataForResource:resource onComplete:^(NSData *data) {
        NSLog(@"resource is %@", data);
        if (data) {
            [wv loadData:data MIMEType:@"application/pdf" textEncodingName:nil baseURL:nil];
        } else {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Offline"
                                                            message:@"Sorry, floorplan is not available when offline."
                                                           delegate:nil
                                                  cancelButtonTitle:@"OK"
                                                  otherButtonTitles:nil];
            [alert show];
        }
    }];
}


@end
