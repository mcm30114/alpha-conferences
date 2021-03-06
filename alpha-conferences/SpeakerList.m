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
    __strong DataStore *data;
}

@end



@implementation SpeakerList


-(void)reloadData {
    
    NSMutableDictionary *speakersKeyedByLetter = [NSMutableDictionary dictionary];
    
    data = [DataStore latestAvailableInstance];
    NSArray *speakers = data.speakers;
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

// disabled for now as AlphaCell doesn't take the section index into account when calculating required size
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
    r.detailText = s.position;
    r.style = AlphaTableViewCellWithImageLeft;
    r.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    r.imageResource = [Resource resourceWithKey:s.imageKey type:ResourceTypeSpeakerImageSmall];
    r.onSelected = ^(StandardController *controller) {
        StandardController *childController = [[StandardController alloc] initWithStyle:UITableViewStyleGrouped pager:NO];
        childController.title = s.displayName;
        childController.model = [[SpeakerDetail alloc] initWithSpeaker:s data:data];
        [controller.navigationController pushViewController:childController animated:YES];
    };
    return r;
}


@end
