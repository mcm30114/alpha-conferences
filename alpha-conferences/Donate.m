//
//  Dontate.m
//  alpha-conferences
//
//  Created by Erik Erskine on 20/04/2012.
//  Copyright (c) 2012 Brightec Ltd. All rights reserved.
//

#import "Donate.h"
#import "AlphaRow.h"
#import "RichTextRow.h"
#import "ButtonBarRow.h"
#import "StandardController.h"
#import "DataStore.h"


@interface Donate () {
    NSMutableArray *items;
}

@end



@implementation Donate


-(void)reloadData {
    Conference *c = [DataStore latestAvailableInstance].conference;
    items = [NSMutableArray array];
    
    // description row
    if (c.donationDescription) {
        [items addObject:[[RichTextRow alloc] initWithHTML:c.donationDescription]];
    }

    // donate via sms row
    if (c.donationTelephoneNumber.length > 0) {
        ButtonBarRow *smsRow = [[ButtonBarRow alloc] init];
        smsRow.button1Title = [NSString stringWithFormat:@"Text %@", c.donationTelephoneNumber];
        smsRow.onButton1Selected = ^(UIViewController *controller) {
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"sms://%@", c.donationTelephoneNumber]]];
        };
        [items addObject:smsRow];
    }
    
    // donate online row
    if (c.donationURL.length > 0) {
        ButtonBarRow *websiteRow = [[ButtonBarRow alloc] init];
        websiteRow.button1Title = @"Donate online";
        websiteRow.onButton1Selected = ^(UIViewController *controller) {
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:c.donationURL]];
        };
        [items addObject:websiteRow];
    }
}


-(NSInteger)numberOfSectionsInPage:(NSInteger)page {
    return items.count;
}


-(NSInteger)numberOfRowsInPage:(NSInteger)page section:(NSInteger)section {
    return 1;
}


-(id)rowForPage:(NSInteger)page section:(NSInteger)section row:(NSInteger)row {
    return [items objectAtIndex:section];
}


@end
