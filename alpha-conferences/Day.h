//
//  Day.h
//  AlphaConferences
//
//  Created by Erik Erskine on 17/04/2012.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface Day : NSObject

@property (nonatomic) NSInteger dayId;
@property (nonatomic) BOOL active;
@property (nonatomic, strong) NSDate *date;

-(id)initWithDictionary:(NSDictionary *)dictionary;

@end
