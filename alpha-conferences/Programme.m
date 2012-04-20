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
#import "AlphaRow.h"
#import "SeminarOptions.h"
#import "StandardController.h"
#import "SessionDetail.h"


@interface Programme ()

@property (nonatomic, strong) NSMutableArray *pages;
@property (nonatomic, strong) NSMutableDictionary *pagesKeyedByDayId;

@end



@implementation Programme

@synthesize pages;
@synthesize pagesKeyedByDayId;


-(void)reloadData {
    DataStore *data = [DataStore latestAvailableInstance];
    
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

            NSMutableArray *hiddenSessionsInSlot = [NSMutableArray array];
            
            for (Session *s in [sessionsKeyedByHour objectForKey:time]) {
                
                // seminars are held back, and are shown by a child controller
                if (s.sessionTypeId == 2) {
                    [hiddenSessionsInSlot addObject:s];
                } else {
                    AlphaRow *alphaRow = [[AlphaRow alloc] init];
                    alphaRow.style = AlphaTableViewCellWithColourBar;
                    alphaRow.text = s.name;
                    alphaRow.detailText = [NSString stringWithFormat:@"type %d, %@ - %@", s.sessionTypeId, s.startDateTime, s.endDateTime];
                    alphaRow.onSelected = ^(StandardController *controller) {
                        StandardController *childController = [[StandardController alloc] initWithStyle:UITableViewStyleGrouped pager:NO];
                        childController.model = [[SessionDetail alloc] initWithSession:s data:data];
                        [controller.navigationController pushViewController:childController animated:YES];
                    };
                    [ps.rows addObject:alphaRow];
                }
                
            }
            
            // if there are any hidden sessions, show a link
            if (hiddenSessionsInSlot.count > 0) {
                AlphaRow *alphaRow = [[AlphaRow alloc] init];
                alphaRow.style = AlphaTableViewCellNormal;
                alphaRow.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
                alphaRow.text = @"View seminar options available";
                alphaRow.onSelected = ^(StandardController *controller) {
                    StandardController *childController = [[StandardController alloc] initWithStyle:UITableViewStylePlain pager:NO];
                    childController.model = [[SeminarOptions alloc] initWithSessions:hiddenSessionsInSlot dataStore:data];
                    [controller.navigationController pushViewController:childController animated:YES];
                };
                [ps.rows addObject:alphaRow];
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
    return pp.day.date.description;
}


-(NSInteger)numberOfSectionsInPage:(NSInteger)page {
    ProgrammePage *pp = [self.pages objectAtIndex:page];
    return pp.sections.count;
}


-(NSString *)sectionTitleForPage:(NSInteger)page section:(NSInteger)section {
    ProgrammePage *pp = [self.pages objectAtIndex:page];
    ProgrammeSection *ps = [pp.sections objectAtIndex:section];
    return ps.time.description;
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
