//
//  SessionsBySpeaker.m
//  alpha-conferences
//
//  Created by Erik Erskine on 27/04/2012.
//  Copyright (c) 2012 Brightec Ltd. All rights reserved.
//

#import "SessionsBySpeaker.h"
#import "ProgrammeRow.h"
#import "StandardController.h"
#import "SessionDetail.h"


@interface SessionsBySpeaker () {
    @private
    NSMutableArray *rows;
    DataStore *data;
}
@end



@implementation SessionsBySpeaker


- (id)initWithSessions:(NSArray *)sessions data:(DataStore *)ds {
    if (self = [super init]) {
        data = ds;
        rows = [NSMutableArray array];
        
        for (Session *s in sessions) {
            ProgrammeRow *programmeRow = [[ProgrammeRow alloc] init];
            programmeRow.text = s.name;
            programmeRow.speakerText = s.speakerText;
            programmeRow.detailText = s.room.venue.name;
            programmeRow.dateTimeText = s.dateTimeText;
            programmeRow.barColour = s.color;
            programmeRow.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            programmeRow.onSelected = ^(StandardController *controller) {
                StandardController *childController = [[StandardController alloc] initWithStyle:UITableViewStyleGrouped pager:NO];
                childController.title = s.name;
                childController.model = [[SessionDetail alloc] initWithSession:s data:data];
                [controller.navigationController pushViewController:childController animated:YES];
            };
            [rows addObject:programmeRow];
        }
        
    }
    return self;
}


-(NSInteger)numberOfRowsInPage:(NSInteger)page section:(NSInteger)section {
    return rows.count;
}


-(id)rowForPage:(NSInteger)page section:(NSInteger)section row:(NSInteger)row {
    return [rows objectAtIndex:row];
}


@end
