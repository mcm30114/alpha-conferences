//
//  ResourceCache.h
//  alpha-conferences
//
//  Created by Erik Erskine on 20/04/2012.
//  Copyright (c) 2012 Brightec Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Resource.h"


@interface ResourceCache : NSObject

+(ResourceCache *)defaultResourceCache;

-(UIImage *)imageForResource:(Resource *)resource onComplete:(void (^)(UIImage *))onComplete;

@end
