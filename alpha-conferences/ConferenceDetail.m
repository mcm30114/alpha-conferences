//
//  ConferenceDetail.m
//  alpha-conferences
//
//  Created by Erik Erskine on 19/04/2012.
//  Copyright (c) 2012 Brightec Ltd. All rights reserved.
//

#import "ConferenceDetail.h"
#import "AlphaRow.h"
#import "RichTextRow.h"
#import "StandardController.h"


@interface ConferenceDetail () {
    Conference *conference;
    NSMutableArray *rows;
}

@end



@implementation ConferenceDetail


-(id)initWithConference:(Conference *)c {
    if (self = [super init]) {
        rows = [NSMutableArray array];
        
        // image row
        AlphaRow *imageRow = [[AlphaRow alloc] init];
        imageRow.style = AlphaTableViewCellWithImageRight;
        imageRow.text = @"image to go here";
        imageRow.imageResource = [Resource resourceWithKey:c.imageKey type:ResourceTypeConferenceImageSmall];
        [rows addObject:imageRow];
        
        // description row
        if (conference.text) {
            [rows addObject:[[RichTextRow alloc] initWithHTML:conference.text]];
        }

        // booking row
        if (conference.bookingURL) {
            AlphaRow *bookingRow = [[AlphaRow alloc] init];
            bookingRow.style = AlphaTableViewCellNormal;
            bookingRow.text = @"Book now";
            bookingRow.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            bookingRow.onSelected = ^(StandardController *controller) {
                [[UIApplication sharedApplication] openURL:[NSURL URLWithString:conference.bookingURL]];
            };
            [rows addObject:bookingRow];
        }
        
    }
    return self;
}


-(NSInteger)numberOfRowsInPage:(NSInteger)page section:(NSInteger)section {
    return rows.count;
}


-(id)rowForPage:(NSInteger)page section:(NSInteger)section row:(NSInteger)row {
    return [rows objectAtIndex:row];
}


@end
