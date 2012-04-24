//
//  FAQList.m
//  alpha-conferences
//
//  Created by Erik Erskine on 19/04/2012.
//  Copyright (c) 2012 Brightec Ltd. All rights reserved.
//

#import "FAQList.h"
#import "DataStore.h"
#import "AlphaRow.h"
#import "StandardController.h"
#import "PageViewController.h"


@interface FAQList () {
    NSArray *faqs;
}

@end



@implementation FAQList


-(NSInteger)numberOfRowsInPage:(NSInteger)page section:(NSInteger)section {
    return faqs.count;
}


-(id)rowForPage:(NSInteger)page section:(NSInteger)section row:(NSInteger)row {
    
    FAQ *f = [faqs objectAtIndex:row];
    AlphaRow *r = [[AlphaRow alloc] init];
    r.text = f.question;
    r.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    r.style = AlphaTableViewCellNormal;
    
    r.onSelected = ^(StandardController *controller) {
        PageViewController *childController = [[PageViewController alloc] initWithPageTitle:f.question pageContent:f.answer];
        childController.title = f.question;
        [controller.navigationController pushViewController:childController animated:YES];
    };
    return r;
}


-(void)reloadData {
    faqs = [DataStore latestAvailableInstance].faqs;
}


@end