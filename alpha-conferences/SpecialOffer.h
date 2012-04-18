//
//  SpecialOffer.h
//  AlphaConferences
//
//  Created by Erik Erskine on 17/04/2012.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface SpecialOffer : NSObject

@property (nonatomic) NSInteger specialOfferId;
@property (nonatomic) BOOL active;
@property (nonatomic) NSInteger conferenceId;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *html;

-(id)initWithDictionary:(NSDictionary *)dictionary;

@end
