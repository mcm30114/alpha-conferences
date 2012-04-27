//
//  ProgrammeChoices.h
//  alpha-conferences
//
//  Created by Erik Erskine on 27/04/2012.
//  Copyright (c) 2012 Brightec Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Session.h"


@interface ProgrammeChoices : NSObject

+ (BOOL)isSessionBookmarked:(Session *)session;

+ (BOOL)doesSessionGroupHaveBookmark:(NSInteger)sessionGroupId;

+ (NSInteger)bookmarkedSessionIdForSessionGroup:(NSInteger)sessionGroupId;

+ (void)setBookmarkedSessionId:(NSInteger)sessionId forSessionGroupId:(NSInteger)sessionGroupId;

@end
