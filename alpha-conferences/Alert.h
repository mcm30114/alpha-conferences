//
//  Alert.h
//  AlphaConferences
//
//  Created by Erik Erskine on 17/04/2012.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface Alert : NSObject

@property (nonatomic) NSInteger alertId;
@property (nonatomic) BOOL active;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *message;
@property (nonatomic, strong) NSDate *dateTime;

-(id)initWithDictionary:(NSDictionary *)dictionary;

@end
