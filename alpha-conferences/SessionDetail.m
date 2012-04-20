//
//  SessionDetail.m
//  alpha-conferences
//
//  Created by Erik Erskine on 20/04/2012.
//  Copyright (c) 2012 Brightec Ltd. All rights reserved.
//

#import "SessionDetail.h"
#import "StandardController.h"
#import "AlphaRow.h"
#import "RichTextRow.h"
#import "ButtonBarRow.h"
#import "SpeakerDetail.h"


@interface SessionDetail () {
    NSMutableArray *sections;
}

@end



@implementation SessionDetail


-(id)initWithSession:(Session *)session data:(DataStore *)data {
    if (self = [super init]) {
        sections = [NSMutableArray array];
        
        AlphaRow *titleRow = [[AlphaRow alloc] init];
        titleRow.style = AlphaTableViewCellWithImageRight;
        titleRow.text = session.name;
        titleRow.detailText = session.detailDetailText;
        SessionDetailSection *top = [[SessionDetailSection alloc] init];
        [top.rows addObject:titleRow];
        [sections addObject:top];
        
//        ButtonBarRow *buttons = [[ButtonBarRow alloc] init];
//        buttons.button1Title = @"Bookmark";
//        SessionDetailSection *buttonSection = [[SessionDetailSection alloc] init];
//        [buttonSection.rows addObject:buttons];
//        [sections addObject:buttonSection];
        
        if (session.text.length > 0) {
            SessionDetailSection *descriptionSection = [[SessionDetailSection alloc] init];
            [descriptionSection.rows addObject:[[RichTextRow alloc] initWithHTML:session.text]];
            [sections addObject:descriptionSection];
        }
        
        // speakers
        SessionDetailSection *speakers = [[SessionDetailSection alloc] init];
        speakers.title = @"Speakers";
        
        for (NSNumber *speakerId in session.speakerIds) {
            Speaker *speaker = [data speakerWithId:speakerId.integerValue];
            AlphaRow *speakerRow = [[AlphaRow alloc] init];
            speakerRow.style = AlphaTableViewCellWithImageRight;
            speakerRow.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            speakerRow.text = speaker.displayName;
            speakerRow.detailText = speaker.position;
            speakerRow.onSelected = ^(StandardController *controller) {
                StandardController *childController = [[StandardController alloc] initWithStyle:UITableViewStyleGrouped pager:NO];
                childController.title = speaker.displayName;
                childController.model = [[SpeakerDetail alloc] initWithSpeaker:speaker];
                [controller.navigationController pushViewController:childController animated:YES];
            };
            [speakers.rows addObject:speakerRow];
        }
        
        if (speakers.rows > 0) {
            [sections addObject:speakers];
        }
        
    }
    return self;
}


-(NSInteger)numberOfSectionsInPage:(NSInteger)page {
    return sections.count;
}

-(NSString *)sectionTitleForPage:(NSInteger)page section:(NSInteger)section {
    return ((SessionDetailSection *)[sections objectAtIndex:section]).title;
}

-(NSInteger)numberOfRowsInPage:(NSInteger)page section:(NSInteger)section {
    return ((SessionDetailSection *)[sections objectAtIndex:section]).rows.count;
}

-(id)rowForPage:(NSInteger)page section:(NSInteger)section row:(NSInteger)row {
    return [((SessionDetailSection *)[sections objectAtIndex:section]).rows objectAtIndex:row];
}


@end



@implementation SessionDetailSection

@synthesize title = _title;
@synthesize rows = _rows;


-(id)init {
    if (self = [super init]) {
        _rows = [NSMutableArray array];
    }
    return self;
}


@end
