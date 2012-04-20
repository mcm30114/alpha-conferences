//
//  Session.h
//  AlphaConferences
//
//  Created by Erik Erskine on 17/04/2012.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Room.h"
#import "Stream.h"

@class DataStore;


@interface Session : NSObject

@property (nonatomic) NSInteger sessionId;
@property (nonatomic) BOOL active;
@property (nonatomic) NSInteger dayId;
@property (nonatomic) NSInteger sessionTypeId;
@property (nonatomic) NSInteger roomId;
@property (nonatomic) NSInteger streamId;
@property (nonatomic) NSInteger sessionGroupId;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSDate *startDateTime;
@property (nonatomic, strong) NSDate *endDateTime;
@property (nonatomic, strong) NSString *text;
@property (nonatomic, strong) NSArray *speakerIds;

-(id)initWithDictionary:(NSDictionary *)dictionary data:(DataStore *)data;

-(Room *)room;
-(Stream *)stream;

// suitable for showing on Programme and SeminarOptions screens
-(NSString *)programmeDetailText;

// suitable for showing on SessionDetail screen
-(NSString *)detailDetailText;

@end
