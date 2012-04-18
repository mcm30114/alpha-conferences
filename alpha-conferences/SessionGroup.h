//
//  SessionGroup.h
//  AlphaConferences
//
//  Created by Erik Erskine on 17/04/2012.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface SessionGroup : NSObject

@property (nonatomic) NSInteger sessionGroupId;
@property (nonatomic) BOOL active;
@property (nonatomic) NSInteger dayId;
@property (nonatomic, strong) NSString *name;

-(id)initWithDictionary:(NSDictionary *)dictionary;

@end
