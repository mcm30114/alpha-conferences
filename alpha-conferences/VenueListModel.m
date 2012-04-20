//
//  VenuesModel.m
//  alpha-conferences
//
//  Created by Erik Erskine on 19/04/2012.
//  Copyright (c) 2012 Brightec Ltd. All rights reserved.
//

#import "VenueListModel.h"
#import "AlphaRow.h"
#import "Venue.h"
#import "StandardController.h"
#import "VenueDetailModel.h"
#import "Constants.h"
#import "DataStore.h"


@interface VenueListModel () {
    NSArray *venues;
}

@end



@implementation VenueListModel


-(NSInteger)numberOfRowsInPage:(NSInteger)page section:(NSInteger)section {
    return venues.count;
}


-(id)rowForPage:(NSInteger)page section:(NSInteger)section row:(NSInteger)row {
    
    Venue *v = [venues objectAtIndex:row];
    AlphaRow *r = [[AlphaRow alloc] init];
    r.text = v.name;
    r.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    r.style = AlphaTableViewCellNormal;
    
    r.onSelected = ^(StandardController *controller) {
        StandardController *childController = [[StandardController alloc] initWithStyle:UITableViewStyleGrouped pager:NO];
        childController.title = v.name;
        childController.model = [[VenueDetailModel alloc] initWithVenue:v];
        [controller.navigationController pushViewController:childController animated:YES];
    };
    return r;
}


-(void)reloadData {
    venues = [DataStore latestAvailableInstance].venues;
}


@end
