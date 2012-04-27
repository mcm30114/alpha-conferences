//
//  RawData.m
//  alpha-conferences
//
//  Created by Erik Erskine on 27/04/2012.
//  Copyright (c) 2012 Brightec Ltd. All rights reserved.
//

#import "RawData.h"
#import "JSONKit.h"
#import "NSDictionary+Alpha.h"


@interface RawData ()

- (id)initWithDictionary:(NSMutableDictionary *)dictionary time:(NSDate *)time;

@end



@implementation RawData

@synthesize dictionary = _dictionary;
@synthesize time = _time;


- (id)init {
    NSMutableDictionary *d = [NSMutableDictionary dictionary];
    [d setObject:[NSNull null] forKey:@"conference"];
    [d setObject:[NSMutableDictionary dictionary] forKey:@"streams"];
    [d setObject:[NSMutableDictionary dictionary] forKey:@"speakers"];
    [d setObject:[NSMutableDictionary dictionary] forKey:@"faqs"];
    [d setObject:[NSMutableDictionary dictionary] forKey:@"venues"];
    [d setObject:[NSMutableDictionary dictionary] forKey:@"rooms"];
    [d setObject:[NSMutableDictionary dictionary] forKey:@"days"];
    [d setObject:[NSMutableDictionary dictionary] forKey:@"session_types"];
    [d setObject:[NSMutableDictionary dictionary] forKey:@"session_groups"];
    [d setObject:[NSMutableDictionary dictionary] forKey:@"sessions"];
    [d setObject:[NSMutableDictionary dictionary] forKey:@"special_offers"];
    [d setObject:[NSMutableDictionary dictionary] forKey:@"alerts"];
    [d setObject:[NSMutableDictionary dictionary] forKey:@"other_conferences"];
    return [self initWithDictionary:d time:nil];
}


- (id)initWithDictionary:(NSMutableDictionary *)dictionary time:(NSDate *)time {
    if (self = [super init]) {
        _dictionary = dictionary;
        _time = time;
    }
    return self;
}


- (void)populateWithJSON:(NSData *)json {
    
    NSDictionary *main = [[JSONDecoder decoder] objectWithData:json];
    NSDictionary *body = [main objectForKey:@"body"];

    NSArray *keys = self.dictionary.allKeys;
    for (NSString *key in keys) {

        id values = [body objectForKey:key];
        if ([values isKindOfClass:[NSArray class]]) {
            // multiple entities
        
            NSArray *entities = (NSArray *)values;
            for (NSDictionary *entityDict in entities) {
                NSInteger entityId = [entityDict integerForKey:@"id"];
                if ([entityDict activeFlag]) {
                    //NSLog(@"adding entity with id %d to %@", entityId, key);
                    [((NSMutableDictionary *)[self.dictionary objectForKey:key]) setObject:entityDict forIntegerKey:entityId];
                } else {
                    //NSLog(@"removing entity with id %d from %@", entityId, key);
                    [((NSMutableDictionary *)[self.dictionary objectForKey:key]) removeObjectForIntegerKey:entityId];
                }
            }
        
        }
        else if ([values isKindOfClass:[NSDictionary class]]) {
            // single entity

            NSDictionary *entityDict = (NSDictionary *)values;
            if ([entityDict activeFlag]) {
                //NSLog(@"adding single %@ entity", key);
                [self.dictionary setObject:entityDict forKey:key];
            } else {
                //NSLog(@"removing single %@ entity", key);
                [self.dictionary removeObjectForKey:key];
            }
        
        }
    }
    
    _time = [NSDate dateWithTimeIntervalSince1970:[[body objectForKey:@"request_timestamp"] intValue]];
}


- (void)saveToFile:(NSString *)path {
    NSMutableData *data = [NSMutableData data];
    NSKeyedArchiver *archiver = [[NSKeyedArchiver alloc] initForWritingWithMutableData:data];
    [archiver encodeObject:self.time forKey:@"time"];
    [archiver encodeObject:self.dictionary forKey:@"dictionary"];
    [archiver finishEncoding];
    [data writeToFile:path atomically:YES];
}


+ (RawData *)rawDataWithContentsOfFile:(NSString *)path {
    if ([[NSFileManager defaultManager] fileExistsAtPath:path]) {
        NSData *data = [NSData dataWithContentsOfFile:path];
        NSKeyedUnarchiver *unarchiver = [[NSKeyedUnarchiver alloc] initForReadingWithData:data];
        NSDate *time = [unarchiver decodeObjectForKey:@"time"];
        NSMutableDictionary *dictionary = [unarchiver decodeObjectForKey:@"dictionary"];
        [unarchiver finishDecoding];
        return [[RawData alloc] initWithDictionary:dictionary time:time];
    } else {
        return nil;
    }
}


@end
