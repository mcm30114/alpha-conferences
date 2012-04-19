//
//  VenueDetailModel.h
//  alpha-conferences
//
//  Created by Erik Erskine on 19/04/2012.
//  Copyright (c) 2012 Brightec Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "StandardControllerModel.h"
#import "Venue.h"


@interface VenueDetailModel : NSObject <StandardControllerModel>

-(id)initWithVenue:(Venue *)venue;

@end
