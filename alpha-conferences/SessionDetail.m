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
#import "VenueDetailModel.h"
#import "ProgrammeChoices.h"


@interface SessionDetail () {
    NSMutableArray *sections;
    DataStore *data;
}

@end



@implementation SessionDetail


-(id)initWithSession:(Session *)session data:(DataStore *)ds {
    if (self = [super init]) {
        sections = [NSMutableArray array];
        data = ds;
        
        AlphaRow *titleRow = [[AlphaRow alloc] init];
        titleRow.style = AlphaTableViewCellWithImageRight;
        titleRow.text = session.name;
        titleRow.detailText = session.detailDetailText;
        SessionDetailSection *top = [[SessionDetailSection alloc] init];
        [top.rows addObject:titleRow];
        [sections addObject:top];
        
        ButtonBarRow *buttons = [[ButtonBarRow alloc] init];
        buttons.button1Title = @"Venue";
        if (session.room.venue) {
            buttons.onButton1Selected = ^(id sender, UIViewController *controller) {
                StandardController *childController = [[StandardController alloc] initWithStyle:UITableViewStyleGrouped pager:NO];
                childController.title = session.room.venue.name;
                childController.model = [[VenueDetailModel alloc] initWithVenue:session.room.venue];
                [controller.navigationController pushViewController:childController animated:YES];
            };
        }
        
        if ([ProgrammeChoices isSessionBookmarked:session]) {
          buttons.button2Title = @"Bookmarked";
        }
        else {
          buttons.button2Title = @"Bookmark";
        }
        
        if (session.type == SessionTypeSeminarOption && session.sessionGroupId > 0 && ![ProgrammeChoices isSessionBookmarked:session]) {
            buttons.onButton2Selected = ^(id sender, UIViewController *controller) {
                [ProgrammeChoices setBookmarkedSessionId:session.sessionId forSessionGroupId:session.sessionGroupId];
                [controller.navigationController popToViewController:[[controller.navigationController viewControllers] objectAtIndex:0] animated:YES];
            };
        }
        SessionDetailSection *buttonSection = [[SessionDetailSection alloc] init];
        [buttonSection.rows addObject:buttons];
        [sections addObject:buttonSection];
        
        if (session.text.length > 0) {
            SessionDetailSection *descriptionSection = [[SessionDetailSection alloc] init];
            [descriptionSection.rows addObject:[[RichTextRow alloc] initWithHTML:session.text]];
            [sections addObject:descriptionSection];
        }
        
        // speakers
        SessionDetailSection *speakers = [[SessionDetailSection alloc] init];
        speakers.title = @"Speakers";
        
        for (Speaker *speaker in session.speakers) {
            AlphaRow *speakerRow = [[AlphaRow alloc] init];
            speakerRow.style = AlphaTableViewCellWithImageLeft;
            speakerRow.imageResource = [Resource resourceWithKey:speaker.imageKey type:ResourceTypeSpeakerImageSmall];
            speakerRow.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            speakerRow.text = speaker.displayName;
            speakerRow.detailText = speaker.position;
            speakerRow.onSelected = ^(StandardController *controller) {
                StandardController *childController = [[StandardController alloc] initWithStyle:UITableViewStyleGrouped pager:NO];
                childController.title = speaker.displayName;
                childController.model = [[SpeakerDetail alloc] initWithSpeaker:speaker data:data];
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
