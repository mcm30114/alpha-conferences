//
//  SpecialOfferList.m
//  alpha-conferences
//
//  Created by Erik Erskine on 20/04/2012.
//  Copyright (c) 2012 Brightec Ltd. All rights reserved.
//

#import "SpecialOfferList.h"
#import "DataStore.h"
#import "AlphaRow.h"
#import "StandardController.h"
#import "SpecialOffer.h"
#import "PageViewController.h"


@interface SpecialOfferList () {
    NSArray *offers;
}

@end



@implementation SpecialOfferList


-(NSInteger)numberOfRowsInPage:(NSInteger)page section:(NSInteger)section {
    return offers.count;
}


-(id)rowForPage:(NSInteger)page section:(NSInteger)section row:(NSInteger)row {
    SpecialOffer *offer = [offers objectAtIndex:row];
    
    AlphaRow *r = [[AlphaRow alloc] init];
    r.text = offer.title;
    r.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    r.style = AlphaTableViewCellNormal;
    
    r.onSelected = ^(StandardController *controller) {
        PageViewController *childController = [[PageViewController alloc] initWithPageTitle:offer.title pageContent:offer.html];
        childController.title = offer.title;
        [controller.navigationController pushViewController:childController animated:YES];
    };
    return r;
}


-(void)reloadData {
    offers = [DataStore latestAvailableInstance].specialOffers;
}


@end
