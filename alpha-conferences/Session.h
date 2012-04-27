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


typedef enum {
    SessionTypeNone = 0,
    SessionTypeMain = 1,
    SessionTypeSeminarOption = 2,
    SessionTypeSeminarSlot = 3,
    SessionTypeBreak = 4,
    SessionTypeAdmin = 5
} SessionType;


@interface Session : NSObject

@property (nonatomic) NSInteger sessionId;
@property (nonatomic) BOOL active;
@property (nonatomic) NSInteger dayId;
@property (nonatomic) SessionType type;
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
-(NSArray *)speakers;

// suitable for showing on Programme and SeminarOptions screens
-(NSString *)speakerText;
-(NSString *)timeText;
-(NSString *)venueText;

// suitable for showing on SessionsBySpeaker screen
-(NSString *)dateTimeText;

// suitable for showing on SessionDetail screen
-(NSString *)detailDetailText;

-(UIColor *)color;

-(NSComparisonResult)compareByStartDateTime:(Session *)aSession;

@end
