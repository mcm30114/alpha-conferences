//
//  Resource.m
//  alpha-conferences
//
//  Created by Erik Erskine on 20/04/2012.
//  Copyright (c) 2012 Brightec Ltd. All rights reserved.
//

#import "Resource.h"


@implementation Resource

@synthesize key = _key;
@synthesize type = _type;


+(Resource *)resourceWithKey:(NSString *)key type:(ResourceType)type {
    return [[Resource alloc] initWithKey:key type:type];
}


-(id)initWithKey:(NSString *)key type:(ResourceType)type {
    if (self = [super init]) {
        _key = key;
        _type = type;
    }
    return self;
}


-(CGSize)size {
    switch (self.type) {
        case ResourceTypeConferenceImageSmall:
            return CGSizeMake(320, 120);
        case ResourceTypeSpeakerImageSmall:
        case ResourceTypeVenueImageSmall:
            return CGSizeMake(50, 50);
        case ResourceTypeSpeakerImageMedium:
        case ResourceTypeVenueImageMedium:
            return CGSizeMake(75, 75);
        case ResourceTypeSpeakerImageLarge:
        case ResourceTypeVenueImageLarge:
            return CGSizeMake(100, 100);
        default:
            return CGSizeZero;
    }
}


@end
