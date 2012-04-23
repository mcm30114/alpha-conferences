//
//  Pin.h
//  alpha-conferences
//
//  Created by Erik Erskine on 23/04/2012.
//  Copyright (c) 2012 Brightec Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>
#import "Venue.h"


@interface Pin : NSObject <MKAnnotation>

@property (nonatomic, strong) Venue *venue;

- (id)initWithVenue:(Venue *)v;

- (NSString *)title;
- (NSString *)subtitle;
- (CLLocationCoordinate2D)coordinate;

@end
