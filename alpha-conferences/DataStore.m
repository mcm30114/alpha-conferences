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

-(id)initWithData:(NSData *)data;

@end



@implementation DataStore

static DataStore *latestAvailableInstance = nil;


+(DataStore *)latestAvailableInstance {
    return latestAvailableInstance;
}


+(void)refresh {
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
        NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"http://acs.alpha.org/api/rest/v1/conferences/getObjects/%d/0", CONFERENCE_ID]];
        NSData *data = [NSData dataWithContentsOfURL:url];
        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;

        NSString *documentsDirectory = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
        NSString *path = [documentsDirectory stringByAppendingPathComponent:@"data.json"];
        
        if (data != nil) {
            // save file to documents directory
            [data writeToFile:path atomically:YES];
        } else {
            // no data was downloaded, try to read it from file
            if ([[NSFileManager defaultManager] fileExistsAtPath:path]) {
                data = [NSData dataWithContentsOfFile:path];
            }
        }
        
        if (data) {
            // if there is some data then parse it and notify delegates
            DataStore *ds = [[DataStore alloc] initWithData:data];
            latestAvailableInstance = ds;
            dispatch_async(dispatch_get_main_queue(), ^{
                [[NSNotificationCenter defaultCenter] postNotificationName:NOTIFICATION_DATA object:ds];
            });
        } else {
            // if there is no data at all show an alert
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Offline"
                                                            message:@"Sorry, content could not be downloaded."
                                                           delegate:nil
                                                  cancelButtonTitle:@"OK"
                                                  otherButtonTitles:nil];
            [alert show];
        }
    });
}


-(id)initWithData:(NSData *)data {
    if (self = [super init]) {

        NSDictionary *main = [[JSONDecoder decoder] objectWithData:data];
        NSDictionary *body = [main objectForKey:@"body"];
        
        // conference
        Conference *c = [[Conference alloc] initWithDictionary:[body objectForKey:@"conference"]];
        if (c.active) {
            conference = c;
        }

        // streams
        streams = [NSMutableDictionary dictionary];
        for (NSDictionary *d in [body objectForKey:@"streams"]) {
            Stream *s = [[Stream alloc] initWithDictionary:d];
            if (s.active) {
                [streams setObject:s forIntegerKey:s.streamId];
            }
        }

        // speakers
        speakers = [NSMutableDictionary dictionary];
        for (NSDictionary *d in [body objectForKey:@"speakers"]) {
            Speaker *s = [[Speaker alloc] initWithDictionary:d];
            if (s.active) {
                [speakers setObject:s forIntegerKey:s.speakerId];
            }
        }
        
        // faqs
        faqs = [NSMutableDictionary dictionary];
        for (NSDictionary *d in [body objectForKey:@"faqs"]) {
            FAQ *f = [[FAQ alloc] initWithDictionary:d];
            if (f.active) {
                [faqs setObject:f forIntegerKey:f.faqId];
            }
        }
        
        // venues
        venues = [NSMutableDictionary dictionary];
        for (NSDictionary *d in [body objectForKey:@"venues"]) {
            Venue *v = [[Venue alloc] initWithDictionary:d];
            if (v.active) {
                [venues setObject:v forIntegerKey:v.venueId];
            }
        }
        
        // rooms
        rooms = [NSMutableDictionary dictionary];
        for (NSDictionary *d in [body objectForKey:@"rooms"]) {
            Room *r = [[Room alloc] initWithDictionary:d data:self];
            if (r.active) {
                [rooms setObject:r forIntegerKey:r.roomId];
            }
        }
        
        // days
        days = [NSMutableDictionary dictionary];
        for (NSDictionary *d in [body objectForKey:@"days"]) {
            Day *day = [[Day alloc] initWithDictionary:d];
            if (day.active) {
                [days setObject:day forIntegerKey:day.dayId];
            }
        }
        
        // session types
        sessionTypes = [NSMutableDictionary dictionary];
        for (NSDictionary *d in [body objectForKey:@"session_types"]) {
            SessionTypeInfo *st = [[SessionTypeInfo alloc] initWithDictionary:d];
            if (st.active) {
                [sessionTypes setObject:st forIntegerKey:st.sessionTypeId];
            }
        }
        
        // session groups
        sessionGroups = [NSMutableDictionary dictionary];
        for (NSMutableDictionary *d in [body objectForKey:@"session_groups"]) {
            SessionGroup *sg = [[SessionGroup alloc] initWithDictionary:d];
            if (sg.active) {
                [sessionGroups setObject:sg forIntegerKey:sg.sessionGroupId];
            }
        }
        
        // sessions
        sessions = [NSMutableDictionary dictionary];
        for (NSMutableDictionary *d in [body objectForKey:@"sessions"]) {
            Session *s = [[Session alloc] initWithDictionary:d data:self];
            if (s.active) {
                [sessions setObject:s forIntegerKey:s.sessionId];
            }
        }
        
        // special offers
        specialOffers = [NSMutableDictionary dictionary];
        for (NSMutableDictionary *d in [body objectForKey:@"special_offers"]) {
            SpecialOffer *so = [[SpecialOffer alloc] initWithDictionary:d];
            if (so.active) {
                [specialOffers setObject:so forIntegerKey:so.specialOfferId];
            }
        }
        
        // alerts
        alerts = [NSMutableDictionary dictionary];
        for (NSMutableDictionary *d in [body objectForKey:@"alerts"]) {
            Alert *a = [[Alert alloc] initWithDictionary:d];
            if (a.active) {
                [alerts setObject:a forIntegerKey:a.alertId];
            }
        }
        
        // conferences
        otherConferences = [NSMutableDictionary dictionary];
        for (NSDictionary *d in [body objectForKey:@"other_conferences"]) {
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


@end
