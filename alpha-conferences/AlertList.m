//
//  AlertList.m
//  alpha-conferences
//
//  Created by Erik Erskine on 20/04/2012.
//  Copyright (c) 2012 Brightec Ltd. All rights reserved.
//

#import "AlertList.h"
#import "DataStore.h"
#import "AlphaRow.h"
#import "StandardController.h"
#import "Alert.h"
#import "AlertDetail.h"


@interface AlertList () {
    NSArray *alerts;
}

@end



@implementation AlertList


-(NSInteger)numberOfRowsInPage:(NSInteger)page section:(NSInteger)section {
    return alerts.count;
}


-(id)rowForPage:(NSInteger)page section:(NSInteger)section row:(NSInteger)row {
    Alert *a = [alerts objectAtIndex:row];

    AlphaRow *r = [[AlphaRow alloc] init];
    r.text = a.title;
    r.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    r.style = AlphaTableViewCellNormal;
    
    r.onSelected = ^(StandardController *controller) {
        StandardController *childController = [[StandardController alloc] initWithStyle:UITableViewStyleGrouped pager:NO];
        childController.model = [[AlertDetail alloc] initWithAlert:a];
        [controller.navigationController pushViewController:childController animated:YES];
    };
    return r;
}


-(void)reloadData {
    alerts = [DataStore latestAvailableInstance].alerts;
}


@end