//
//  SpeakerDetail.m
//  alpha-conferences
//
//  Created by Erik Erskine on 20/04/2012.
//  Copyright (c) 2012 Brightec Ltd. All rights reserved.
//

#import "SpeakerDetail.h"
#import "AlphaRow.h"
#import "ButtonBarRow.h"
#import "RichTextRow.h"
#import "SessionsBySpeaker.h"
#import "StandardController.h"


@interface SpeakerDetail ()

@property (nonatomic, readonly, strong) Speaker *speaker;
@property (nonatomic, readonly, strong) DataStore *data;

@end



@implementation SpeakerDetail

@synthesize speaker = _speaker;
@synthesize data = _data;


-(id)initWithSpeaker:(Speaker *)speaker data:(DataStore *)data {
    if (self = [super init]) {
        _speaker = speaker;
        _data = data;
    }
    return self;
}


-(NSInteger)numberOfSectionsInPage:(NSInteger)page {
    return 4;
}


-(NSInteger)numberOfRowsInPage:(NSInteger)page section:(NSInteger)section {
    switch (section) {
        case 0:
            return 1;
        case 1:
            return 1;
        case 2:
            return 1;
        case 3:
            return 1;
        default:
            return 0;
    }
}


-(id)rowForPage:(NSInteger)page section:(NSInteger)section row:(NSInteger)row {
    if (section == 0 && row == 0) {
        AlphaRow *r = [[AlphaRow alloc] init];
        r.style = AlphaTableViewCellWithImageRight;
        r.text = self.speaker.displayName;
        r.detailText = self.speaker.position;
        r.imageResource = [Resource resourceWithKey:self.speaker.imageKey type:ResourceTypeSpeakerImageSmall];
        return r;
    }
    else if (section == 2 && row == 0) {
        ButtonBarRow *r = [[ButtonBarRow alloc] init];
        r.button1Title = @"Visit Website";
        if (self.speaker.websiteUrl.length > 0) {
            r.onButton1Selected = ^(id sender, UIViewController *controller) {
                [[UIApplication sharedApplication] openURL:[NSURL URLWithString:self.speaker.websiteUrl]];
            };
        }
        r.button2Title = @"Follow on Twitter";
        if (self.speaker.twitterUsername.length > 0) {
            r.onButton2Selected = ^(id sender, UIViewController *controller) {
                NSString *twitterUrl = [NSString stringWithFormat:@"http://mobile.twitter.com/%@", self.speaker.twitterUsername];
                [[UIApplication sharedApplication] openURL:[NSURL URLWithString:twitterUrl]];
            };
        }
        return r;
    }
    else if (section == 1 && row == 0) {
        RichTextRow *r = [[RichTextRow alloc] init];
        r.html = self.speaker.biography;
        return r;
    }
    else if (section == 3 && row == 0) {
        AlphaRow *r = [[AlphaRow alloc] init];
        r.style = AlphaTableViewCellNormal;
        r.text = @"View their sessions";
        r.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        r.onSelected = ^(StandardController *controller) {
            StandardController *childController = [[StandardController alloc] initWithStyle:UITableViewStylePlain pager:NO];
            childController.model = [[SessionsBySpeaker alloc] initWithSessions:self.speaker.sessions data:self.data];
            childController.title = @"Sessions";
            [controller.navigationController pushViewController:childController animated:YES];
        };
        return r;
    }
    else {
        return nil;
    }
}


@end
