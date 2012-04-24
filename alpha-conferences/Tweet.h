//
//  Tweet.h
//  alpha-conferences
//
//  Created by Erik Erskine on 24/04/2012.
//  Copyright (c) 2012 Brightec Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Resource.h"


@interface Tweet : NSObject

- (id)initWithDictionary:(NSDictionary *)dictionary;

- (NSString *)displayName;
- (NSString *)displayText;
- (NSURL *)URL;
- (Resource *)avatarResource;

@end
