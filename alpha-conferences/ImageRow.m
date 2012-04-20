//
//  ImageRow.m
//  alpha-conferences
//
//  Created by Erik Erskine on 20/04/2012.
//  Copyright (c) 2012 Brightec Ltd. All rights reserved.
//

#import "ImageRow.h"


@implementation ImageRow

@synthesize resource = _resource;


-(id)initWithResource:(Resource *)resource {
    if (self = [super init]) {
        _resource = resource;
    }
    return self;
}


@end
