//
//  SeminarOptions.m
//  alpha-conferences
//
//  Created by Erik Erskine on 20/04/2012.
//  Copyright (c) 2012 Brightec Ltd. All rights reserved.
//

#import "SeminarOptions.h"
#import "NSDictionary+Alpha.h"
#import "AlphaRow.h"
#import "StandardController.h"
#import "SessionDetail.h"


@interface SeminarOptions () {
    @private
    NSMutableArray *sections;
}

@end



@implementation SeminarOptions


-(id)initWithSessions:(NSArray *)sessions dataStore:(DataStore *)dataStore {
    if (self = [super init]) {
        
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
                AlphaRow *alphaRow = [[AlphaRow alloc] init];
                alphaRow.style = AlphaTableViewCellWithColourBar;
                alphaRow.text = s.name;
                alphaRow.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
                alphaRow.onSelected = ^(StandardController *controller) {
                    StandardController *childController = [[StandardController alloc] initWithStyle:UITableViewStyleGrouped pager:NO];
                    childController.model = [[SessionDetail alloc] initWithSession:s data:dataStore];
                    [controller.navigationController pushViewController:childController animated:YES];
                };
                [section.rows addObject:alphaRow];
            }
        }
    }
    return self;
}


-(NSInteger)numberOfSectionsInPage:(NSInteger)page {
    return sections.count;
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
