//
//  ImageRow.h
//  alpha-conferences
//
//  Created by Erik Erskine on 20/04/2012.
//  Copyright (c) 2012 Brightec Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Resource.h"


@interface ImageRow : NSObject

@property (nonatomic, strong, readonly) Resource *resource;

-(id)initWithResource:(Resource *)resource;

@end
