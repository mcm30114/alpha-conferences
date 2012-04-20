//
//  SeminarOptions.h
//  alpha-conferences
//
//  Created by Erik Erskine on 20/04/2012.
//  Copyright (c) 2012 Brightec Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "StandardControllerModel.h"
#import "Session.h"
#import "Stream.h"
#import "DataStore.h"


@interface SeminarOptions : NSObject <StandardControllerModel>

-(id)initWithSessions:(NSArray *)sessions dataStore:(DataStore *)dataStore;

@end



@interface SeminarOptionsSection : NSObject

@property (nonatomic, readonly, strong) Stream *stream;
@property (nonatomic, readonly, strong) NSMutableArray *rows;

-(id)initWithStream:(Stream *)stream;

@end
