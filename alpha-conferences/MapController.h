//
//  MapController.h
//  alpha-conferences
//
//  Created by Erik Erskine on 23/04/2012.
//  Copyright (c) 2012 Brightec Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import "Venue.h"


@interface MapController : UIViewController <MKMapViewDelegate>

- (id)initWithVenues:(NSArray *)venues;

@end
