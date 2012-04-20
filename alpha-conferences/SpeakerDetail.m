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


@interface SpeakerDetail ()

@property (nonatomic, readonly, strong) Speaker *speaker;

@end



@implementation SpeakerDetail

@synthesize speaker = _speaker;


-(id)initWithSpeaker:(Speaker *)speaker {
    if (self = [super init]) {
        _speaker = speaker;
    }
    return self;
}


-(NSInteger)numberOfSectionsInPage:(NSInteger)page {
    return 3;
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
        r.image = [UIImage imageNamed:@"cell-image.png"];
        return r;
    }
    else if (section == 1 && row == 0) {
        ButtonBarRow *r = [[ButtonBarRow alloc] init];
        r.button1Title = @"Visit website";
        if (self.speaker.websiteUrl.length > 0) {
            r.onButton1Selected = ^() {
                [[UIApplication sharedApplication] openURL:[NSURL URLWithString:self.speaker.websiteUrl]];
            };
        }
        r.button2Title = @"Follow on Twitter";
        if (self.speaker.twitterUsername.length > 0) {
            r.onButton2Selected = ^() {
                NSString *twitterUrl = [NSString stringWithFormat:@"http://mobile.twitter.com/%@", self.speaker.twitterUsername];
                [[UIApplication sharedApplication] openURL:[NSURL URLWithString:twitterUrl]];
            };
        }
        return r;
    }
    else if (section == 2 && row == 0) {
        RichTextRow *r = [[RichTextRow alloc] init];
        r.html = self.speaker.biography;
        return r;
    }
//    else if (section == 2 && row == 0) {
//        AlphaRow *r = [[AlphaRow alloc] init];
//        r.style = AlphaTableViewCellNormal;
//        r.text = [NSString stringWithFormat:@"View sessions with %@", self.speaker.displayName];
//        r.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
//        return r;
//    }
    else {
        return nil;
    }
}


@end
