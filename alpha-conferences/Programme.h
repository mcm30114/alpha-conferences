//
//  Programme.h
//  alpha-conferences
//
//  Created by Erik Erskine on 20/04/2012.
//  Copyright (c) 2012 Brightec Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "StandardControllerModel.h"
#import "Day.h"


@interface Programme : NSObject <StandardControllerModel>

@end



@interface ProgrammePage : NSObject

@property (nonatomic, strong, readonly) Day *day;
@property (nonatomic, strong, readonly) NSMutableArray *sections;

-(id)initWithDay:(Day *)day;

@end



@interface ProgrammeSection : NSObject

@property (nonatomic, strong, readonly) NSDate *time;
@property (nonatomic, strong, readonly) NSMutableArray *rows;

-(id)initWithTime:(NSDate *)time;

@end
