//
//  Stream.h
//  AlphaConferences
//
//  Created by Erik Erskine on 17/04/2012.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface Stream : NSObject

@property (nonatomic) NSInteger streamId;
@property (nonatomic) BOOL active;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) UIColor *color;

-(id)initWithDictionary:(NSDictionary *)dictionary;

@end
