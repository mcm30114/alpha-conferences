//
//  ACSpearker.h
//  AlphaConferences
//
//  Created by Erik Erskine on 30/03/2012.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Speaker : NSObject

@property (nonatomic) NSInteger speakerId;
@property (nonatomic) BOOL active;
@property (nonatomic, strong) NSString *firstName;
@property (nonatomic, strong) NSString *lastName;
@property (nonatomic, strong) NSString *alias;
@property (nonatomic, strong) NSString *twitterUsername;
@property (nonatomic, strong) NSString *websiteUrl;
@property (nonatomic, strong) NSString *biography;
@property (nonatomic, strong) NSString *position;
@property (nonatomic, strong) NSString *imageKey;

-(id)initWithDictionary:(NSDictionary *)dictionary;

-(NSString *)displayName;
-(NSString *)indexLetter;

-(NSComparisonResult)compare:(Speaker *)aSpeaker;

@end
