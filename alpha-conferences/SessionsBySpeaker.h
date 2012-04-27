//
//  SessionsBySpeaker.h
//  alpha-conferences
//
//  Created by Erik Erskine on 27/04/2012.
//  Copyright (c) 2012 Brightec Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Session.h"
#import "StandardControllerModel.h"


@interface SessionsBySpeaker : NSObject <StandardControllerModel>

- (id)initWithSessions:(NSArray *)sessions;

@end
