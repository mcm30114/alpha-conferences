//
//  ResourceCache.m
//  alpha-conferences
//
//  Created by Erik Erskine on 20/04/2012.
//  Copyright (c) 2012 Brightec Ltd. All rights reserved.
//

#import "ResourceCache.h"


@interface ResourceCache () {
    @private
    NSString *documentsDirectory;
    BOOL retina;
}

-(NSURL *)urlForResource:(Resource *)resource;

-(UIImage *)placeholderImageForResource:(Resource *)resource;

-(NSString *)cachePathForResource:(Resource *)resource;

@end



@implementation ResourceCache

static ResourceCache *_defaultResourceCache = nil;


+(ResourceCache *)defaultResourceCache {
    @synchronized(self) {
        if (_defaultResourceCache == nil) {
            _defaultResourceCache = [[self alloc] init];
        }
        return _defaultResourceCache;
    }
}


-(id)init {
    if (self = [super init]) {
        documentsDirectory = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
        retina = [[UIScreen mainScreen] respondsToSelector:@selector(scale)] && [UIScreen mainScreen].scale == 2;
    }
    return self;
}


-(UIImage *)imageForResource:(Resource *)resource onComplete:(void (^)(UIImage *))onComplete {
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSData *realData = nil;
        NSString *fullPath = [self cachePathForResource:resource];
        
        if ([[NSFileManager defaultManager] fileExistsAtPath:fullPath]) {
            realData = [NSData dataWithContentsOfFile:fullPath];
            
        } else {
            // doesn't exist on disk, so get it from network
            [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
            NSURL *url = [self urlForResource:resource];
            realData = [NSData dataWithContentsOfURL:url];
            [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
            
            if (realData) {
                // save the data to a file
                NSError *err;
                [[NSFileManager defaultManager] createDirectoryAtPath:[fullPath stringByDeletingLastPathComponent] withIntermediateDirectories:YES attributes:nil error:&err];
                [realData writeToFile:fullPath atomically:YES];
            }
        }

        if (realData) {
            UIImage *realImage = [UIImage imageWithData:realData];
            dispatch_async(dispatch_get_main_queue(), ^{
                onComplete(realImage);
            });
        }
    });
    
    return [self placeholderImageForResource:resource];
}


-(NSURL *)urlForResource:(Resource *)resource {
    NSURL *baseURL = [NSURL URLWithString:@"http://static.alpha.org/acs/conferences/"];
    switch (resource.type) {
        case ResourceTypeConferenceImageSmall:
            return [NSURL URLWithString:[NSString stringWithFormat:@"branding/%@/%d.jpg", resource.key, (retina ? 240 : 120)] relativeToURL:baseURL];
        case ResourceTypeConferenceImageLarge:
            return [NSURL URLWithString:[NSString stringWithFormat:@"branding/%@/%d.jpg", resource.key, (retina ? 576 : 288)] relativeToURL:baseURL];
        case ResourceTypeSpeakerImageSmall:
            return [NSURL URLWithString:[NSString stringWithFormat:@"speakers/%@/%d.jpg", resource.key, (retina ? 100 : 50)] relativeToURL:baseURL];
        case ResourceTypeSpeakerImageMedium:
            return [NSURL URLWithString:[NSString stringWithFormat:@"speakers/%@/%d.jpg", resource.key, (retina ? 150 : 75)] relativeToURL:baseURL];
        case ResourceTypeSpeakerImageLarge:
            return [NSURL URLWithString:[NSString stringWithFormat:@"speakers/%@/%d.jpg", resource.key, (retina ? 200 : 100)] relativeToURL:baseURL];
        case ResourceTypeVenueImageSmall:
            return [NSURL URLWithString:[NSString stringWithFormat:@"venues/%@/%d.jpg", resource.key, (retina ? 100 : 50)] relativeToURL:baseURL];
        case ResourceTypeVenueImageMedium:
            return [NSURL URLWithString:[NSString stringWithFormat:@"venues/%@/%d.jpg", resource.key, (retina ? 150 : 75)] relativeToURL:baseURL];
        case ResourceTypeVenueImageLarge:
            return [NSURL URLWithString:[NSString stringWithFormat:@"venues/%@/%d.jpg", resource.key, (retina ? 200 : 100)] relativeToURL:baseURL];
        case ResourceTypeVenueFloorplan:
            return [NSURL URLWithString:[NSString stringWithFormat:@"venues/%@.pdf", resource.key] relativeToURL:baseURL];
        default:
            return nil;
    }
}


-(UIImage *)placeholderImageForResource:(Resource *)resource {
    switch (resource.type) {
        case ResourceTypeConferenceImageSmall:
            return [UIImage imageNamed:@"blank-320x120.png"];
        case ResourceTypeSpeakerImageSmall:
        case ResourceTypeVenueImageSmall:
            return [UIImage imageNamed:@"blank-50x50.png"];
        case ResourceTypeSpeakerImageMedium:
        case ResourceTypeVenueImageMedium:
            return [UIImage imageNamed:@"blank-75x75.png"];
        case ResourceTypeSpeakerImageLarge:
        case ResourceTypeVenueImageLarge:
            return [UIImage imageNamed:@"blank-100x100.png"];
        default:
            return nil;
    }
}


-(NSString *)cachePathForResource:(Resource *)resource {
    return [documentsDirectory stringByAppendingPathComponent:[NSString stringWithFormat:@"%@-%d", resource.key, resource.type]];
}


@end
