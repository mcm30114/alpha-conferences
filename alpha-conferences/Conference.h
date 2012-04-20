//
//  ACConference.h
//  AlphaConferences
//
//  Created by Erik Erskine on 30/03/2012.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Conference : NSObject

@property (nonatomic) NSInteger conferenceId;
@property (nonatomic) BOOL active;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *text;
@property (nonatomic, strong) NSDate *startDate;
@property (nonatomic, strong) NSDate *endDate;
@property (nonatomic, strong) NSString *imageKey;
@property (nonatomic, strong) NSString *bookingURL;
@property (nonatomic, strong) NSString *donationURL;
@property (nonatomic, strong) NSString *donationDescription;
@property (nonatomic, strong) NSString *donationTelephoneNumber;

-(id)initWithDictionary:(NSDictionary *)dictionary;

@end
