//
//  ConferenceDetail.h
//  alpha-conferences
//
//  Created by Erik Erskine on 19/04/2012.
//  Copyright (c) 2012 Brightec Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "StandardControllerModel.h"
#import "Conference.h"


@interface ConferenceDetail : NSObject <StandardControllerModel>

-(id)initWithConference:(Conference *)c;

@end
