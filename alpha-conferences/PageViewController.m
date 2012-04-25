//
//  PageViewController.m
//  alpha-conferences
//
//  Created by Erik Erskine on 23/04/2012.
//  Copyright (c) 2012 Brightec Ltd. All rights reserved.
//

#import "PageViewController.h"
#import "UIColor+Alpha.h"


@implementation PageViewController

@synthesize pageTitle = _pageTitle;
@synthesize pageContent = _pageContent;


- (void)dealloc {
    ((UIWebView *)self.view).delegate = nil;
}


- (id)initWithPageTitle:(NSString *)pageTitle pageContent:(NSString *)pageContent {
    if (self = [super initWithNibName:nil bundle:nil]) {
        _pageTitle = pageTitle;
        _pageContent = pageContent;
    }
    return self;
}


- (void)loadView {
    UIWebView *wv = [[UIWebView alloc] initWithFrame:[[UIScreen mainScreen] applicationFrame]];
    wv.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    wv.delegate = self;
    self.view = wv;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    [self refresh];
}


- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {
    if (navigationType == UIWebViewNavigationTypeLinkClicked) {
        [[UIApplication sharedApplication] openURL:request.URL];
        return NO;
    }
    else {
        return YES;
    }
}


- (void)refresh {
    UIWebView *wv = (UIWebView *)self.view;
    NSString *css = [NSString stringWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"pageview" ofType:@"css"]
                                              encoding:NSUTF8StringEncoding
                                                 error:nil];
    NSString *html = [NSString stringWithFormat:@"<!DOCTYPE html><html><head><style type='text/css'>%@</style><body><h1>%@</h1>%@</body></html>",
                      css,
                      (self.pageTitle ? self.pageTitle : @""),
                      (self.pageContent ? self.pageContent : @"")];
    [wv loadHTMLString:html baseURL:nil];
}


@end
