//
//  SeminarOptions.m
//  alpha-conferences
//
//  Created by Erik Erskine on 20/04/2012.
//  Copyright (c) 2012 Brightec Ltd. All rights reserved.
//

#import "SeminarOptions.h"
#import "NSDictionary+Alpha.h"
#import "ProgrammeRow.h"
#import "StandardController.h"
#import "SessionDetail.h"


@interface SeminarOptions () {
    @private
    NSMutableArray *sections;
    DataStore *data;
}

@end



@implementation SeminarOptions


-(id)initWithSessions:(NSArray *)sessions dataStore:(DataStore *)dataStore {
    if (self = [super init]) {
        data = dataStore;
        
        NSMutableDictionary *sessionsKeyedByStreamId = [NSMutableDictionary dictionary];
        for (Session *s in sessions) {
            NSMutableArray *a = [sessionsKeyedByStreamId objectForIntegerKey:s.streamId];
            if (a == nil) {
                a = [NSMutableArray array];
                [sessionsKeyedByStreamId setObject:a forIntegerKey:s.streamId];
            }
            [a addObject:s];
        }
        
        sections = [NSMutableArray array];
        for (NSNumber *streamId in [sessionsKeyedByStreamId allKeys]) {
            Stream *stream = [dataStore streamWithId:streamId.integerValue];
            SeminarOptionsSection *section = [[SeminarOptionsSection alloc] initWithStream:stream];
            [sections addObject:section];
            
            for (Session *s in [sessionsKeyedByStreamId objectForKey:streamId]) {
                ProgrammeRow *programmeRow = [[ProgrammeRow alloc] init];
                programmeRow.text = s.name;
                programmeRow.speakerText = s.speakerText;
                programmeRow.detailText = s.room.venue.name;
                programmeRow.dateTimeText = s.timeText;
                programmeRow.barColour = s.stream.color;
                programmeRow.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
                programmeRow.onSelected = ^(StandardController *controller) {
                    StandardController *childController = [[StandardController alloc] initWithStyle:UITableViewStyleGrouped pager:NO];
                    childController.title = s.name;
                    childController.model = [[SessionDetail alloc] initWithSession:s data:data];
                    [controller.navigationController pushViewController:childController animated:YES];
                };
                [section.rows addObject:programmeRow];
            }
        }
        
        // order streams by name
        [sections sortUsingComparator:^NSComparisonResult(SeminarOptionsSection *a, SeminarOptionsSection *b) {
            return [a.stream.name compare:b.stream.name];
        }];
    }
    return self;
}


-(NSInteger)numberOfSectionsInPage:(NSInteger)page {
    return sections.count;
}


-(NSString *)sectionTitleForPage:(NSInteger)page section:(NSInteger)section {
    SeminarOptionsSection *ss = [sections objectAtIndex:section];
    return ss.stream.name;
}


-(NSInteger)numberOfRowsInPage:(NSInteger)page section:(NSInteger)section {
    SeminarOptionsSection *ss = [sections objectAtIndex:section];
    return ss.rows.count;
}


-(id)rowForPage:(NSInteger)page section:(NSInteger)section row:(NSInteger)row {
    SeminarOptionsSection *ss = [sections objectAtIndex:section];
    return [ss.rows objectAtIndex:row];
}


@end



@implementation SeminarOptionsSection

@synthesize stream = _stream;
@synthesize rows = _rows;


-(id)initWithStream:(Stream *)stream {
    if (self = [super init]) {
        _stream = stream;
        _rows = [NSMutableArray array];
    }
    return self;
}


@end
