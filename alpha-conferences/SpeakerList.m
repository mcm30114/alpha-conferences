//
//  SpeakerList.m
//  alpha-conferences
//
//  Created by Erik Erskine on 20/04/2012.
//  Copyright (c) 2012 Brightec Ltd. All rights reserved.
//

#import "SpeakerList.h"
#import "AlphaRow.h"
#import "StandardController.h"
#import "DataStore.h"
#import "Speaker.h"
#import "SpeakerDetail.h"


@interface SpeakerList () {
    @private
    NSArray *sectionTitles;
    NSMutableArray *sectionRows;
}

@end



@implementation SpeakerList


-(void)reloadData {
    
    NSMutableDictionary *speakersKeyedByLetter = [NSMutableDictionary dictionary];
    
    NSArray *speakers = [DataStore latestAvailableInstance].speakers;
    for (Speaker *s in speakers) {
        NSString *key = [s indexLetter];
        NSMutableArray *a = [speakersKeyedByLetter objectForKey:key];
        if (a == nil) {
            a = [NSMutableArray array];
            [speakersKeyedByLetter setObject:a forKey:key];
        }
        [a addObject:s];
    }
    
    NSArray *sortedKeys = [[speakersKeyedByLetter allKeys] sortedArrayUsingSelector:@selector(compare:)];
    sectionTitles = sortedKeys;
    sectionRows = [NSMutableArray array];
    for (NSString *key in sortedKeys) {
        [sectionRows addObject:[[speakersKeyedByLetter objectForKey:key] sortedArrayUsingSelector:@selector(compare:)]];
    }
}


-(NSInteger)numberOfSectionsInPage:(NSInteger)page {
    return sectionRows.count;
}

-(NSString *)sectionTitleForPage:(NSInteger)page section:(NSInteger)section {
    return [sectionTitles objectAtIndex:section];
}

-(NSArray *)sectionIndexTitlesForPage:(NSInteger)page {
    return sectionTitles;
}


-(NSInteger)numberOfRowsInPage:(NSInteger)page section:(NSInteger)section {
    return ((NSArray *)[sectionRows objectAtIndex:section]).count;
}


-(id)rowForPage:(NSInteger)page section:(NSInteger)section row:(NSInteger)row {
    Speaker *s = [((NSArray *)[sectionRows objectAtIndex:section]) objectAtIndex:row];
    AlphaRow *r = [[AlphaRow alloc] init];
    r.text = s.displayName;
    r.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    r.onSelected = ^(StandardController *controller) {
        StandardController *childController = [[StandardController alloc] initWithStyle:UITableViewStyleGrouped pager:NO];
        childController.model = [[SpeakerDetail alloc] initWithSpeaker:s];
        [controller.navigationController pushViewController:childController animated:YES];
    };
    return r;
}


@end
