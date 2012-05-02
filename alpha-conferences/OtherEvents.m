//
//  OtherEvents.m
//  alpha-conferences
//
//  Created by Erik Erskine on 19/04/2012.
//  Copyright (c) 2012 Brightec Ltd. All rights reserved.
//

#import "OtherEvents.h"
#import "AlphaRow.h"
#import "DataStore.h"
#import "StandardController.h"
#import "NSDateFormatter+Alpha.h"
#import "HomeController.h"


@interface OtherEvents () {
    NSArray *conferences;
}

@end



@implementation OtherEvents


-(void)reloadData {
    conferences = [DataStore latestAvailableInstance].otherConferences;
}


-(NSInteger)numberOfRowsInPage:(NSInteger)page section:(NSInteger)section {
    return conferences.count;
}


-(id)rowForPage:(NSInteger)page section:(NSInteger)section row:(NSInteger)row {
    Conference *c = [conferences objectAtIndex:row];
    NSDateFormatter *f = [NSDateFormatter mediumDateFormatterWithUTCTimeZone];
    AlphaRow *r = [[AlphaRow alloc] init];
    r.text = c.name;
    r.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    if ([[f stringFromDate:c.startDate] isEqualToString:[f stringFromDate:c.endDate]]) {
        r.detailText = [NSString stringWithFormat:@"%@", [f stringFromDate:c.startDate]];
    }
    else {
        r.detailText = [NSString stringWithFormat:@"%@ - %@", [f stringFromDate:c.startDate], [f stringFromDate:c.endDate]];
    }
    
    r.onSelected = ^(StandardController *controller) {
        HomeController *childController = [[HomeController alloc] initWithConference:c];
        childController.title = c.name;
        [controller.navigationController pushViewController:childController animated:YES];
    };
    return r;
}


@end
