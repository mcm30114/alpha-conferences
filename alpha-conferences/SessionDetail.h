//
//  SessionDetail.h
//  alpha-conferences
//
//  Created by Erik Erskine on 20/04/2012.
//  Copyright (c) 2012 Brightec Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SessionDetail.h"
#import "StandardControllerModel.h"
#import "Session.h"
#import "DataStore.h"


@interface SessionDetail : NSObject <StandardControllerModel>

-(id)initWithSession:(Session *)session;

@end



@interface SessionDetailSection : NSObject

@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong, readonly) NSMutableArray *rows;

@end
