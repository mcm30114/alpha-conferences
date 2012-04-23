//
//  MapController.m
//  alpha-conferences
//
//  Created by Erik Erskine on 23/04/2012.
//  Copyright (c) 2012 Brightec Ltd. All rights reserved.
//

#import "MapController.h"
#import "Pin.h"
#import "StandardController.h"
#import "VenueDetailModel.h"


@interface MapController () {
    NSArray *venues;
}

+ (MKCoordinateRegion)regionWithVenues:(NSArray *)venues;

- (void)venuePinTapped:(id)sender;

@end



@implementation MapController


- (id)initWithVenues:(NSArray *)v {
    if (self = [super initWithNibName:nil bundle:nil]) {
        venues = v;
    }
    return self;
}


- (void)loadView {
    MKMapView *map = [[MKMapView alloc] initWithFrame:[[UIScreen mainScreen] applicationFrame]];
    map.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    map.delegate = self;
    self.view = map;
}


- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    MKMapView *mapView = (MKMapView *)self.view;
    [mapView setRegion:[mapView regionThatFits:[MapController regionWithVenues:venues]] animated:NO];
}


- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];

    MKMapView *mapView = (MKMapView *)self.view;
    for (Venue *v in venues) {
        [mapView addAnnotation:[[Pin alloc] initWithVenue:v]];
    }
}


+ (MKCoordinateRegion)regionWithVenues:(NSArray *)venues {
    float south = 90;
    float north = -90;
    float west = 180;
    float east = -180;
    for (Venue *v in venues) {
        south = MIN(south, v.latitude);
        north = MAX(north, v.latitude);
        west = MIN(west, v.longitude);
        east = MAX(east, v.longitude);
    }
    
    MKCoordinateRegion region;
    region.center.latitude = (north + south) / 2;
    region.center.longitude = (east + west) / 2;
    region.span.latitudeDelta = fabs(north - region.center.latitude) * 3;
    region.span.longitudeDelta = fabs(east - region.center.longitude) * 3;
    return region;
}


- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation {
    Pin *pin = (Pin *)annotation;
    
    UIButton *b = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
    [b addTarget:self action:@selector(venuePinTapped:) forControlEvents:UIControlEventTouchUpInside];
    
    MKPinAnnotationView *pinView = [[MKPinAnnotationView alloc] initWithAnnotation:pin reuseIdentifier:@"pin"];
    pinView.canShowCallout = YES;
    pinView.rightCalloutAccessoryView = b;
    return pinView;
}


- (void)venuePinTapped:(id)sender {
    MKPinAnnotationView *pinView = (MKPinAnnotationView *)[[sender superview] superview];
    Venue *v = ((Pin *)pinView.annotation).venue;
    StandardController *c = [[StandardController alloc] initWithStyle:UITableViewStyleGrouped pager:NO];
    c.title = v.name;
    c.model = [[VenueDetailModel alloc] initWithVenue:v];
    [self.navigationController pushViewController:c animated:YES];
}


@end
