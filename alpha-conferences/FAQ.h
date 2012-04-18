//
//  FAQ.h
//  AlphaConferences
//
//  Created by Erik Erskine on 17/04/2012.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface FAQ : NSObject

@property (nonatomic) NSInteger faqId;
@property (nonatomic) BOOL active;
@property (nonatomic, strong) NSString *question;
@property (nonatomic, strong) NSString *answer;

-(id)initWithDictionary:(NSDictionary *)dictionary;

@end
