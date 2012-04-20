// Copyright 2012 Brightec Ltd

#import "NSDictionary+Alpha.h"


@implementation NSDictionary (Alpha)


-(NSString *)stringForKey:(id)key {
    id value = [self objectForKey:key];
    return [value isKindOfClass:[NSString class]] ? (NSString *)value : nil;
}

-(NSInteger)integerForKey:(id)key {
    return ((NSNumber *)[self objectForKey:key]).intValue;
}

-(float)floatForKey:(id)key {
    return ((NSNumber *)[self objectForKey:key]).floatValue;
}

-(NSDate *)dateForKey:(id)key {
    return [NSDate dateWithTimeIntervalSince1970:((NSNumber *)[self objectForKey:key]).integerValue];
}

-(BOOL)activeFlag {
    NSNumber *i = (NSNumber *)[self objectForKey:@"active"];
    return (i == nil || i.intValue != 0);
}

-(id)objectForIntegerKey:(NSInteger)key {
    return [self objectForKey:[NSNumber numberWithInt:key]];
}


@end



@implementation NSMutableDictionary (Alpha)


-(void)setObject:(id)object forIntegerKey:(NSInteger)key {
    [self setObject:object forKey:[NSNumber numberWithInt:key]];
}


@end
