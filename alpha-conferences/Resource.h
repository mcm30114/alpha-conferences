//
//  Resource.h
//  alpha-conferences
//
//  Created by Erik Erskine on 20/04/2012.
//  Copyright (c) 2012 Brightec Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>


typedef enum {
    ResourceTypeConferenceImageSmall = 10,
    ResourceTypeConferenceImageLarge = 11,
    ResourceTypeSpeakerImageSmall = 20,
    ResourceTypeSpeakerImageMedium = 21,
    ResourceTypeSpeakerImageLarge = 22,
    ResourceTypeVenueImageSmall = 30,
    ResourceTypeVenueImageMedium = 31,
    ResourceTypeVenueImageLarge = 32,
    ResourceTypeVenueFloorplan = 40
} ResourceType;


@interface Resource : NSObject

@property (nonatomic, strong, readonly) NSString *key;
@property (nonatomic, readonly) ResourceType type;

+(Resource *)resourceWithKey:(NSString *)key type:(ResourceType)type;

-(id)initWithKey:(NSString *)key type:(ResourceType)type;

-(CGSize)size;

@end
