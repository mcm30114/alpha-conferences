//
//  StandardControllerModel.h
//  alpha-conferences
//
//  Created by Erik Erskine on 19/04/2012.
//  Copyright (c) 2012 Brightec Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>


@protocol StandardControllerModel <NSObject>

-(NSInteger)numberOfPages;

-(NSString *)pageTitleForPage:(NSInteger)page;

-(NSInteger)numberOfSectionsInPage:(NSInteger)page;

-(NSString *)sectionTitleForPage:(NSInteger)page section:(NSInteger)section;

-(NSInteger)numberOfRowsInPage:(NSInteger)page section:(NSInteger)section;

-(id)rowForPage:(NSInteger)page section:(NSInteger)section row:(NSInteger)row;

@end
