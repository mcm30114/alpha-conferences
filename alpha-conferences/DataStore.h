//
//  DataStore.h
//  AlphaConferences
//
//  Created by Erik Erskine on 30/03/2012.
//  Copyright (c) 2012 Brightec Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Model.h"


@interface DataStore : NSObject

+(DataStore *)latestAvailableInstance;
+(void)refresh;

-(Conference *)conference;
-(NSArray *)speakers;
-(NSArray *)days;
-(NSArray *)venues;
-(NSArray *)faqs;
-(NSArray *)otherConferences;
-(NSArray *)alerts;
-(NSArray *)specialOffers;

-(Speaker *)speakerWithId:(NSInteger)speakerId;
-(Session *)sessionWithId:(NSInteger)sessionId;

@end
