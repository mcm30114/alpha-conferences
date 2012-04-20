// Copyright 2012 Brightec Ltd

#import <Foundation/Foundation.h>


@interface NSDictionary (Alpha)

-(NSString *)stringForKey:(id)key;
-(NSInteger)integerForKey:(id)key;
-(float)floatForKey:(id)key;
-(NSDate *)dateForKey:(id)key;
-(BOOL)activeFlag;  // true unless active=0

-(id)objectForIntegerKey:(NSInteger)key;

@end



@interface NSMutableDictionary (Alpha)

-(void)setObject:(id)object forIntegerKey:(NSInteger)key;

@end
