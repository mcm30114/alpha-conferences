//
//  RawData.h
//  alpha-conferences
//
//  Created by Erik Erskine on 27/04/2012.
//  Copyright (c) 2012 Brightec Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface RawData : NSObject

@property (nonatomic, strong, readonly) NSMutableDictionary *dictionary;
@property (nonatomic, strong, readonly) NSDate *time;

- (void)populateWithJSON:(NSData *)json time:(NSDate *)time;

- (void)saveToFile:(NSString *)path;

+ (id)rawDataWithContentsOfFile:(NSString *)path;

@end
