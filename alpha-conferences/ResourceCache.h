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

// a placeholder image is returned immediately, the real one is passed to the onComplete block
-(UIImage *)imageForResource:(Resource *)resource onComplete:(void (^)(UIImage *))onComplete;

+(UIImage *)imageWithColor:(UIColor *)color size:(CGSize)size scale:(CGFloat)scale;

-(void)dataForResource:(Resource *)resource onComplete:(void (^)(NSData *))onComplete;

@end
