//
//  VenueDetailModel.m
//  alpha-conferences
//
//  Created by Erik Erskine on 19/04/2012.
//  Copyright (c) 2012 Brightec Ltd. All rights reserved.
//

#import "VenueDetailModel.h"
#import "AlphaRow.h"
#import "ButtonBarRow.h"
#import "RichTextRow.h"


@interface VenueDetailModel ()

@property (nonatomic, readonly, strong) Venue *venue;

@end



@implementation VenueDetailModel

@synthesize venue = _venue;


-(id)initWithVenue:(Venue *)venue {
    if (self = [super init]) {
        _venue = venue;
    }
    return self;
}


-(NSInteger)numberOfSectionsInPage:(NSInteger)page {
    return 2;
}


-(NSInteger)numberOfRowsInPage:(NSInteger)page section:(NSInteger)section {
    switch (section) {
        case 0:
            return 1;
//        case 1:
//            return 1;
        case 1:
            return 1;
        default:
            return 0;
    }
}


-(id)rowForPage:(NSInteger)page section:(NSInteger)section row:(NSInteger)row {
    if (section == 0 && row == 0) {
        AlphaRow *r = [[AlphaRow alloc] init];
        r.style = AlphaTableViewCellWithImageRight;
        r.text = self.venue.name;
        r.detailText = self.venue.address;
        r.imageResource = [[Resource alloc] initWithKey:self.venue.imageKey type:ResourceTypeVenueImageSmall];
        return r;
    }
//    else if (section == 1 && row == 0) {
//        ButtonBarRow *r = [[ButtonBarRow alloc] init];
//        r.button1Title = @"View on Map";
//        return r;
//    }
    else if (section == 1 && row == 0) {
        RichTextRow *r = [[RichTextRow alloc] init];
        r.html = self.venue.details;
        return r;
    }
    else {
        return nil;
    }
}


@end
