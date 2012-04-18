//
//  Venue.h
//  AlphaConferences
//
//  Created by Erik Erskine on 17/04/2012.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface Venue : NSObject

@property (nonatomic) NSInteger venueId;
@property (nonatomic) BOOL active;
@property (nonatomic, strong) NSString *name;
@property (nonatomic) float latitude;
@property (nonatomic) float longitude;
@property (nonatomic, strong) NSString *streetAddress;
@property (nonatomic, strong) NSString *county;
@property (nonatomic, strong) NSString *country;
@property (nonatomic, strong) NSString *postcode;
@property (nonatomic, strong) NSString *details;
@property (nonatomic, strong) NSString *imageKey;
@property (nonatomic, strong) NSString *floorplanKey;

-(id)initWithDictionary:(NSDictionary *)dictionary;

@end
