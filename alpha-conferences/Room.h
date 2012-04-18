//
//  Room.h
//  AlphaConferences
//
//  Created by Erik Erskine on 17/04/2012.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface Room : NSObject

@property (nonatomic) NSInteger roomId;
@property (nonatomic) BOOL active;
@property (nonatomic) NSInteger venueId;
@property (nonatomic, strong) NSString *name;

-(id)initWithDictionary:(NSDictionary *)dictionary;

@end
