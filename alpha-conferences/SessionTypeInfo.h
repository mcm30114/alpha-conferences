//
//  SessionTypeInfo.h
//  AlphaConferences
//
//  Created by Erik Erskine on 17/04/2012.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface SessionTypeInfo : NSObject

@property (nonatomic) NSInteger sessionTypeId;
@property (nonatomic) BOOL active;
@property (nonatomic, strong) NSString *name;

-(id)initWithDictionary:(NSDictionary *)dictionary;

@end
