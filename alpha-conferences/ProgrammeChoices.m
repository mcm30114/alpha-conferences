//
//  ProgrammeChoices.m
//  alpha-conferences
//
//  Created by Erik Erskine on 27/04/2012.
//  Copyright (c) 2012 Brightec Ltd. All rights reserved.
//

#import "ProgrammeChoices.h"
#import "AppDelegate.h"
#import "NSDictionary+Alpha.h"
#import "Constants.h"


@interface ProgrammeChoices ()

+ (NSDictionary *)dictionary;

@end



@implementation ProgrammeChoices


+ (NSDictionary *)dictionary {
    NSDictionary *d = [[NSUserDefaults standardUserDefaults] objectForKey:USER_DEFAULTS_CHOICES];
    if (d == nil) {
        d = [NSDictionary dictionary];
    }
    return d;
}


+ (BOOL)isSessionBookmarked:(Session *)session {
    return [ProgrammeChoices bookmarkedSessionIdForSessionGroup:session.sessionGroupId] == session.sessionId;
}


+ (BOOL)doesSessionGroupHaveBookmark:(NSInteger)sessionGroupId {
    return [[ProgrammeChoices dictionary] objectForKey:[NSString stringWithFormat:@"%d", sessionGroupId]] != nil;
}


+ (NSInteger)bookmarkedSessionIdForSessionGroup:(NSInteger)sessionGroupId {
    return [[ProgrammeChoices dictionary] integerForKey:[NSString stringWithFormat:@"%d", sessionGroupId]];
}


+ (void)setBookmarkedSessionId:(NSInteger)sessionId forSessionGroupId:(NSInteger)sessionGroupId {
    NSMutableDictionary *dictionary = [NSMutableDictionary dictionaryWithDictionary:[ProgrammeChoices dictionary]];
    [dictionary setObject:[NSNumber numberWithInt:sessionId] forKey:[NSString stringWithFormat:@"%d", sessionGroupId]];
    [[NSUserDefaults standardUserDefaults] setObject:dictionary forKey:USER_DEFAULTS_CHOICES];
    [[NSNotificationCenter defaultCenter] postNotificationName:NOTIFICATION_PROGRAMME_CHOICE object:nil];
}


@end
