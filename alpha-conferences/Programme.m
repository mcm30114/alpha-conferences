//
//  Programme.m
//  alpha-conferences
//
//  Created by Erik Erskine on 20/04/2012.
//  Copyright (c) 2012 Brightec Ltd. All rights reserved.
//

#import "Programme.h"
#import "DataStore.h"
#import "NSDictionary+Alpha.h"
#import "ProgrammeRow.h"
#import "SeminarOptions.h"
#import "StandardController.h"
#import "SessionDetail.h"
#import "NSDateFormatter+Alpha.h"
#import "Room.h"
#import "Venue.h"
#import "ProgrammeChoices.h"


@interface Programme ()

@property (nonatomic, strong) NSMutableArray *pages;
@property (nonatomic, strong) NSMutableDictionary *pagesKeyedByDayId;
@property (nonatomic, strong) DataStore *data;

@end



@implementation Programme

@synthesize pages;
@synthesize pagesKeyedByDayId;
@synthesize data;


-(void)reloadData {
    self.data = [DataStore latestAvailableInstance];
    if (self.data.days.count == 0) {
        return;
    }
    
    self.pages = [NSMutableArray array];
    self.pagesKeyedByDayId = [NSMutableDictionary dictionary];
    for (Day *day in data.days) {
        ProgrammePage *pp = [[ProgrammePage alloc] initWithDay:day];
        [self.pages addObject:pp];
        [self.pagesKeyedByDayId setObject:pp forIntegerKey:day.dayId];
        
        NSMutableDictionary *sessionsKeyedByHour = [NSMutableDictionary dictionary];
        for (Session *session in [data sessionsWithDayId:day.dayId]) {
            
            NSCalendar *cal = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
            NSDateComponents *c = [cal components:(NSYearCalendarUnit|NSMonthCalendarUnit|NSDayCalendarUnit|NSHourCalendarUnit) fromDate:session.startDateTime];
            NSDate *hour = [cal dateFromComponents:c];
            
            NSMutableArray *a = [sessionsKeyedByHour objectForKey:hour];
            if (a == nil) {
                a = [NSMutableArray array];
                [sessionsKeyedByHour setObject:a forKey:hour];
            }
            [a addObject:session];
        }
        
        NSArray *sessionTimes = [[sessionsKeyedByHour allKeys] sortedArrayUsingSelector:@selector(compare:)];
        for (NSDate *time in sessionTimes) {
            ProgrammeSection *ps = [[ProgrammeSection alloc] initWithTime:time];

            // sessions are sorted by time, but sessions with the same time are sorted with 'seminar slot' type first
            NSArray *sessionsInThisHour = [sessionsKeyedByHour objectForKey:time];
            sessionsInThisHour = [sessionsInThisHour sortedArrayUsingComparator:^NSComparisonResult(Session *a, Session *b) {
                NSComparisonResult r = [a.startDateTime compare:b.startDateTime];
                if (r == NSOrderedSame) {
                    if (a.type == SessionTypeSeminarSlot && b.type != SessionTypeSeminarSlot) {
                        r = NSOrderedAscending;
                    } else if (a.type != SessionTypeSeminarSlot && b.type == SessionTypeSeminarSlot) {
                        r = NSOrderedDescending;
                    }
                }
                return r;
            }];
            
            for (Session *s in sessionsInThisHour) {
                
                if (s.type == SessionTypeSeminarOption && ![ProgrammeChoices isSessionBookmarked:s]) {
                    // don't show a seminar here seminars are not shown here
                }
                else if (s.type == SessionTypeSeminarSlot) {
                    // seminar slot
                    ProgrammeRow *programmeRow = [[ProgrammeRow alloc] init];
                    programmeRow.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
                    programmeRow.text = [ProgrammeChoices doesSessionGroupHaveBookmark:s.sessionGroupId] ? @"Change seminar choice" : @"View seminar options available";
                    programmeRow.barColour = [UIColor colorWithSessionType:SessionTypeSeminarSlot];
                    programmeRow.onSelected = ^(StandardController *controller) {
                        StandardController *childController = [[StandardController alloc] initWithStyle:UITableViewStylePlain pager:NO];
                        childController.title = @"Seminar options";
                        childController.model = [[SeminarOptions alloc] initWithSessions:[data sessionsWithGroupId:s.sessionGroupId type:SessionTypeSeminarOption] dataStore:data];
                        [controller.navigationController pushViewController:childController animated:YES];
                    };
                    [ps.rows addObject:programmeRow];
                }
                else {
                    // all other sessions
                    ProgrammeRow *programmeRow = [[ProgrammeRow alloc] init];
                    programmeRow.text = s.name;
                    programmeRow.speakerText = s.speakerText;
                    if (s.type != SessionTypeBreak && s.type != SessionTypeAdmin) {
                        programmeRow.detailText = s.room.venue.name;
                    }
                    programmeRow.dateTimeText = s.timeText;
                    
                    programmeRow.barColour = s.color;
                    
                    if (s.type != SessionTypeBreak && s.type != SessionTypeAdmin) {
                        programmeRow.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
                        programmeRow.onSelected = ^(StandardController *controller) {
                            StandardController *childController = [[StandardController alloc] initWithStyle:UITableViewStyleGrouped pager:NO];
                            childController.title = s.name;
                            childController.model = [[SessionDetail alloc] initWithSession:s data:self.data];
                            [controller.navigationController pushViewController:childController animated:YES];
                        };
                    }
                    
                    [ps.rows addObject:programmeRow];
                }
                
            }
            
            [pp.sections addObject:ps];
        }
        
    }
    
}


-(NSInteger)numberOfPages {
    return self.pages.count;
}


-(NSString *)pageTitleForPage:(NSInteger)page {
    ProgrammePage *pp = [self.pages objectAtIndex:page];
    return [[NSDateFormatter longDateFormatterWithUTCTimeZone] stringFromDate:pp.day.date];
}


-(NSInteger)numberOfSectionsInPage:(NSInteger)page {
    ProgrammePage *pp = [self.pages objectAtIndex:page];
    return pp.sections.count;
}


-(NSString *)sectionTitleForPage:(NSInteger)page section:(NSInteger)section {
    ProgrammePage *pp = [self.pages objectAtIndex:page];
    ProgrammeSection *ps = [pp.sections objectAtIndex:section];
    return [[NSDateFormatter timeFormatterWithUTCTimeZone] stringFromDate:ps.time];
}


-(NSInteger)numberOfRowsInPage:(NSInteger)page section:(NSInteger)section {
    ProgrammePage *pp = [self.pages objectAtIndex:page];
    ProgrammeSection *ps = [pp.sections objectAtIndex:section];
    return ps.rows.count;
}


-(id)rowForPage:(NSInteger)page section:(NSInteger)section row:(NSInteger)row {
    ProgrammePage *pp = [self.pages objectAtIndex:page];
    ProgrammeSection *ps = [pp.sections objectAtIndex:section];
    return [ps.rows objectAtIndex:row];
}


@end



@implementation ProgrammePage

@synthesize day = _day;
@synthesize sections = _sections;


-(id)initWithDay:(Day *)day {
    if (self = [super init]) {
        _day = day;
        _sections = [NSMutableArray array];
    }
    return self;
}


@end



@implementation ProgrammeSection

@synthesize time = _time;
@synthesize rows = _rows;


-(id)initWithTime:(NSDate *)time {
    if (self = [super init]) {
        _time = time;
        _rows = [NSMutableArray array];
    }
    return self;
}


@end
