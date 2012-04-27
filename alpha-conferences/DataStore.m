//
//  DataStore.m
//  AlphaConferences
//
//  Created by Erik Erskine on 30/03/2012.
//  Copyright (c) 2012 Brightec Ltd. All rights reserved.
//

#import "DataStore.h"
#import "Constants.h"
#import "JSONKit.h"
#import "NSDictionary+Alpha.h"
#import "NSDateFormatter+Alpha.h"
#import "RawData.h"


@interface DataStore() {
    @private
    __strong Conference *conference;
    __strong NSMutableDictionary *speakers;
    __strong NSMutableDictionary *streams;
    __strong NSMutableDictionary *faqs;
    __strong NSMutableDictionary *venues;
    __strong NSMutableDictionary *rooms;
    __strong NSMutableDictionary *days;
    __strong NSMutableDictionary *sessionTypes;
    __strong NSMutableDictionary *sessionGroups;
    __strong NSMutableDictionary *sessions;
    __strong NSMutableDictionary *specialOffers;
    __strong NSMutableDictionary *alerts;
    __strong NSMutableDictionary *otherConferences;
}

-(id)initWithRawData:(RawData *)rawData;

@end



@implementation DataStore

static DataStore *latestAvailableInstance = nil;


+(DataStore *)latestAvailableInstance {
    return latestAvailableInstance;
}


+(void)refresh {
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        // load any cached data we have
        NSString *documentsDirectory = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
        NSString *path = [documentsDirectory stringByAppendingPathComponent:@"RawData"];
        RawData *rawData = [RawData rawDataWithContentsOfFile:path];
        if (rawData == nil) {
            rawData = [[RawData alloc] init];
        }

        NSString *timestamp = (rawData.time != nil) ? [[NSDateFormatter iso8601Formatter] stringFromDate:rawData.time] : @"0";
        
        [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
        NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"http://acs.alpha.org/api/rest/v1/conferences/getObjects/%d/%@", CONFERENCE_ID, timestamp]];
        NSLog(@"fetching %@", url);
        NSData *data = [NSData dataWithContentsOfURL:url];
        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;

        if (data == nil) {
            if (rawData == nil) {
                // got no data at all, inform the user of this
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Offline"
                                                                message:@"Sorry, content could not be downloaded."
                                                               delegate:nil
                                                      cancelButtonTitle:@"OK"
                                                      otherButtonTitles:nil];
                [alert performSelectorOnMainThread:@selector(show) withObject:nil waitUntilDone:NO];
            }
            return;
        }

        // if we get here we potentially have new data
        [rawData populateWithJSON:data];
        [rawData saveToFile:path];
        DataStore *ds = [[DataStore alloc] initWithRawData:rawData];
        latestAvailableInstance = ds;
        dispatch_async(dispatch_get_main_queue(), ^{
            [[NSNotificationCenter defaultCenter] postNotificationName:NOTIFICATION_DATA object:ds];
        });
    });
}


-(id)initWithRawData:(RawData *)rawData {
    if (self = [super init]) {

        NSDictionary *body = rawData.dictionary;
        
        // conference
        Conference *c = [[Conference alloc] initWithDictionary:[body objectForKey:@"conference"]];
        if (c.active) {
            conference = c;
        }

        // streams
        streams = [NSMutableDictionary dictionary];
        for (NSDictionary *d in [[body objectForKey:@"streams"] allValues]) {
            Stream *s = [[Stream alloc] initWithDictionary:d];
            if (s.active) {
                [streams setObject:s forIntegerKey:s.streamId];
            }
        }

        // speakers
        speakers = [NSMutableDictionary dictionary];
        for (NSDictionary *d in [[body objectForKey:@"speakers"] allValues]) {
            Speaker *s = [[Speaker alloc] initWithDictionary:d data:self];
            if (s.active) {
                [speakers setObject:s forIntegerKey:s.speakerId];
            }
        }
        
        // faqs
        faqs = [NSMutableDictionary dictionary];
        for (NSDictionary *d in [[body objectForKey:@"faqs"] allValues]) {
            FAQ *f = [[FAQ alloc] initWithDictionary:d];
            if (f.active) {
                [faqs setObject:f forIntegerKey:f.faqId];
            }
        }
        
        // venues
        venues = [NSMutableDictionary dictionary];
        for (NSDictionary *d in [[body objectForKey:@"venues"] allValues]) {
            Venue *v = [[Venue alloc] initWithDictionary:d];
            if (v.active) {
                [venues setObject:v forIntegerKey:v.venueId];
            }
        }
        
        // rooms
        rooms = [NSMutableDictionary dictionary];
        for (NSDictionary *d in [[body objectForKey:@"rooms"] allValues]) {
            Room *r = [[Room alloc] initWithDictionary:d data:self];
            if (r.active) {
                [rooms setObject:r forIntegerKey:r.roomId];
            }
        }
        
        // days
        days = [NSMutableDictionary dictionary];
        for (NSDictionary *d in [[body objectForKey:@"days"] allValues]) {
            Day *day = [[Day alloc] initWithDictionary:d];
            if (day.active) {
                [days setObject:day forIntegerKey:day.dayId];
            }
        }
        
        // session types
        sessionTypes = [NSMutableDictionary dictionary];
        for (NSDictionary *d in [[body objectForKey:@"session_types"] allValues]) {
            SessionTypeInfo *st = [[SessionTypeInfo alloc] initWithDictionary:d];
            if (st.active) {
                [sessionTypes setObject:st forIntegerKey:st.sessionTypeId];
            }
        }
        
        // session groups
        sessionGroups = [NSMutableDictionary dictionary];
        for (NSMutableDictionary *d in [[body objectForKey:@"session_groups"] allValues]) {
            SessionGroup *sg = [[SessionGroup alloc] initWithDictionary:d];
            if (sg.active) {
                [sessionGroups setObject:sg forIntegerKey:sg.sessionGroupId];
            }
        }
        
        // sessions
        sessions = [NSMutableDictionary dictionary];
        for (NSMutableDictionary *d in [[body objectForKey:@"sessions"] allValues]) {
            Session *s = [[Session alloc] initWithDictionary:d data:self];
            if (s.active) {
                [sessions setObject:s forIntegerKey:s.sessionId];
            }
        }
        
        // special offers
        specialOffers = [NSMutableDictionary dictionary];
        for (NSMutableDictionary *d in [[body objectForKey:@"special_offers"] allValues]) {
            SpecialOffer *so = [[SpecialOffer alloc] initWithDictionary:d];
            if (so.active) {
                [specialOffers setObject:so forIntegerKey:so.specialOfferId];
            }
        }
        
        // alerts
        alerts = [NSMutableDictionary dictionary];
        for (NSMutableDictionary *d in [[body objectForKey:@"alerts"] allValues]) {
            Alert *a = [[Alert alloc] initWithDictionary:d];
            if (a.active) {
                [alerts setObject:a forIntegerKey:a.alertId];
            }
        }
        
        // other conferences
        otherConferences = [NSMutableDictionary dictionary];
        for (NSDictionary *d in [[body objectForKey:@"other_conferences"] allValues]) {
            Conference *c = [[Conference alloc] initWithDictionary:d];
            if (c.active) {
                [otherConferences setObject:c forIntegerKey:c.conferenceId];
            }
        }
        
    }
    return self;
}


-(Conference *)conference {
    return conference;
}

-(NSArray *)speakers {
    return speakers.allValues;
}

-(NSArray *)days {
    return days.allValues;
}

-(NSArray *)venues {
    return venues.allValues;
}

-(NSArray *)faqs {
    return faqs.allValues;
}

-(NSArray *)otherConferences {
    return otherConferences.allValues;
}

-(NSArray *)alerts {
    return alerts.allValues;
}

-(NSArray *)specialOffers {
    return specialOffers.allValues;
}

-(NSArray *)sessionsWithDayId:(NSInteger)dayId {
    NSMutableArray *a = [NSMutableArray array];
    for (Session *s in sessions.allValues) {
        if (s.dayId == dayId) {
            [a addObject:s];
        }
    }
    return a;
}

-(NSArray *)sessionsWithGroupId:(NSInteger)sessionGroupId type:(SessionType)type {
    NSMutableArray *a = [NSMutableArray array];
    for (Session *s in sessions.allValues) {
        if (s.sessionGroupId == sessionGroupId && s.type == type) {
            [a addObject:s];
        }
    }
    return a;
}

-(Stream *)streamWithId:(NSInteger)streamId {
    return [streams objectForIntegerKey:streamId];
}

-(Speaker *)speakerWithId:(NSInteger)speakerId {
    return [speakers objectForIntegerKey:speakerId];
}

-(Session *)sessionWithId:(NSInteger)sessionId {
    return [sessions objectForIntegerKey:sessionId];
}

-(Room *)roomWithId:(NSInteger)roomId {
    return [rooms objectForIntegerKey:roomId];
}

-(Venue *)venueWithId:(NSInteger)venueId {
    return [venues objectForIntegerKey:venueId];
}

-(Alert *)alertWithId:(NSInteger)alertId {
    return [alerts objectForIntegerKey:alertId];
}


@end
