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
#import "MapController.h"


@interface VenueListModel () {
    NSArray *venues;
}

@end



@implementation VenueListModel


-(NSInteger)numberOfRowsInPage:(NSInteger)page section:(NSInteger)section {
    return venues.count + 1;
}


-(id)rowForPage:(NSInteger)page section:(NSInteger)section row:(NSInteger)row {
    
    if (row < venues.count) {
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
    else if (row == venues.count) {
        AlphaRow *r = [[AlphaRow alloc] init];
        r.text = @"View all venues on a map";
        r.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        r.onSelected = ^(StandardController *controller) {
            MapController *childController = [[MapController alloc] initWithVenues:venues];
            childController.title = @"All venues";
            [controller.navigationController pushViewController:childController animated:YES];
        };
        return r;
    }
    else {
        return nil;
    }
}


-(void)reloadData {
    venues = [DataStore latestAvailableInstance].venues;
}


@end
