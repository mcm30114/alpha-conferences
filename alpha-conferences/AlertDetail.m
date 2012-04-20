//
//  FAQDetail.m
//  alpha-conferences
//
//  Created by Erik Erskine on 19/04/2012.
//  Copyright (c) 2012 Brightec Ltd. All rights reserved.
//

#import "AlertDetail.h"
#import "AlphaRow.h"
#import "RichTextRow.h"


@interface AlertDetail ()

@property (nonatomic, readonly, strong) Alert *alert;

@end



@implementation AlertDetail

@synthesize alert = _alert;


-(id)initWithAlert:(Alert *)alert {
    if (self = [super init]) {
        _alert = alert;
    }
    return self;
}


-(NSInteger)numberOfSectionsInPage:(NSInteger)page {
    return 2;
}


-(NSInteger)numberOfRowsInPage:(NSInteger)page section:(NSInteger)section {
    switch (section) {
        case 0:
            return 1;
        case 1:
            return 1;
        default:
            return 0;
    }
}


-(id)rowForPage:(NSInteger)page section:(NSInteger)section row:(NSInteger)row {
    if (section == 0 && row == 0) {
        AlphaRow *r = [[AlphaRow alloc] init];
        r.style = AlphaTableViewCellNormal;
        r.text = self.alert.title;
        return r;
    }
    else if (section == 1 && row == 0) {
        RichTextRow *r = [[RichTextRow alloc] init];
        r.html = self.alert.message;
        return r;
    }
    else {
        return nil;
    }
}


@end
