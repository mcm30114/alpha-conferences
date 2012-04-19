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


@interface VenueListModel () {
    NSArray *venues;
}

@end



@implementation VenueListModel


-(id)init {
    if (self = [super init]) {
        Venue *v0 = [[Venue alloc] init];
        v0.name = @"The O2";
        v0.details = @"<p>hello world</p>";
        Venue *v1 = [[Venue alloc] init];
        v1.name = @"Wembley Stadium";
        v1.details = @"<p>hello wembley</p>";
        venues = [NSArray arrayWithObjects:v0, v1, nil];
    }
    return self;
}

-(NSInteger)numberOfPages {
    return 1;
}


-(NSString *)pageTitleForPage:(NSInteger)page {
    return nil;
}


-(NSInteger)numberOfSectionsInPage:(NSInteger)page {
    return 1;
}


-(NSString *)sectionTitleForPage:(NSInteger)page section:(NSInteger)section {
    return nil;
}


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
        childController.model = [[VenueDetailModel alloc] initWithVenue:v];
        [controller.navigationController pushViewController:childController animated:YES];
    };
    return r;
}


@end
