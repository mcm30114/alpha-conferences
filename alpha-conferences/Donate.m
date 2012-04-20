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
    NSMutableArray *rows;
}

@end



@implementation Donate


-(void)reloadData {
    Conference *c = [DataStore latestAvailableInstance].conference;
    rows = [NSMutableArray array];
    
    // description row
    if (c.donationDescription) {
        [rows addObject:[[RichTextRow alloc] initWithHTML:c.donationDescription]];
    }

    // donate via sms row
    if (c.donationTelephoneNumber.length > 0) {
        ButtonBarRow *smsRow = [[ButtonBarRow alloc] init];
        smsRow.button1Title = [NSString stringWithFormat:@"Text %@ with the amount you want to give", c.donationTelephoneNumber];
        [rows addObject:smsRow];
    }
    
    // donate online row
    if (c.donationURL.length > 0) {
        ButtonBarRow *websiteRow = [[ButtonBarRow alloc] init];
        websiteRow.button1Title = @"Donate online";
        [rows addObject:websiteRow];
    }
}


-(NSInteger)numberOfRowsInPage:(NSInteger)page section:(NSInteger)section {
    return rows.count;
}


-(id)rowForPage:(NSInteger)page section:(NSInteger)section row:(NSInteger)row {
    return [rows objectAtIndex:row];
}


@end
