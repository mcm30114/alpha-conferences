//
//  Home.m
//  alpha-conferences
//
//  Created by Erik Erskine on 20/04/2012.
//  Copyright (c) 2012 Brightec Ltd. All rights reserved.
//

#import "Home.h"
#import "AlphaRow.h"
#import "RichTextRow.h"
#import "StandardController.h"
#import "DataStore.h"


@interface Home () {
    NSMutableArray *rows;
}

@end



@implementation Home


-(void)reloadData {
    Conference *c = [DataStore latestAvailableInstance].conference;
    rows = [NSMutableArray array];
    
    // image row
    AlphaRow *imageRow = [[AlphaRow alloc] init];
    imageRow.style = AlphaTableViewCellWithImageRight;
    imageRow.text = @"image to go here";
    imageRow.image = [UIImage imageNamed:@"cell-image.png"];
    [rows addObject:imageRow];
    
    // description row
    if (c.text) {
        [rows addObject:[[RichTextRow alloc] initWithHTML:c.text]];
    }
    
    // booking row
    if (c.bookingURL) {
        AlphaRow *bookingRow = [[AlphaRow alloc] init];
        bookingRow.style = AlphaTableViewCellNormal;
        bookingRow.text = @"Book now";
        bookingRow.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        bookingRow.onSelected = ^(StandardController *controller) {
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:c.bookingURL]];
        };
        [rows addObject:bookingRow];
    }
}


-(NSInteger)numberOfRowsInPage:(NSInteger)page section:(NSInteger)section {
    return rows.count;
}


-(id)rowForPage:(NSInteger)page section:(NSInteger)section row:(NSInteger)row {
    return [rows objectAtIndex:row];
}


@end
