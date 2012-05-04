//
//  SpeakerDetail.h
//  alpha-conferences
//
//  Created by Erik Erskine on 20/04/2012.
//  Copyright (c) 2012 Brightec Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "StandardControllerModel.h"
#import "Speaker.h"


@interface SpeakerDetail : NSObject <StandardControllerModel>

-(id)initWithSpeaker:(Speaker *)speaker data:(DataStore *)data;

@end
