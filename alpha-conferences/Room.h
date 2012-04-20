//
//  Room.h
//  AlphaConferences
//
//  Created by Erik Erskine on 17/04/2012.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Venue.h"

@class DataStore;


@interface Room : NSObject

@property (nonatomic) NSInteger roomId;
@property (nonatomic) BOOL active;
@property (nonatomic) NSInteger venueId;
@property (nonatomic, strong) NSString *name;

-(id)initWithDictionary:(NSDictionary *)dictionary data:(DataStore *)data;

-(Venue *)venue;

@end
