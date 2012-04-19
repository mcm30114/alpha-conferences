//
//  FAQDetail.m
//  alpha-conferences
//
//  Created by Erik Erskine on 19/04/2012.
//  Copyright (c) 2012 Brightec Ltd. All rights reserved.
//

#import "FAQDetail.h"
#import "AlphaRow.h"
#import "ButtonBarRow.h"
#import "RichTextRow.h"


@interface FAQDetail ()

@property (nonatomic, readonly, strong) FAQ *faq;

@end



@implementation FAQDetail

@synthesize faq = _faq;


-(id)initWithFAQ:(FAQ *)faq {
    if (self = [super init]) {
        _faq = faq;
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
        r.text = self.faq.question;
        return r;
    }
    else if (section == 1 && row == 0) {
        RichTextRow *r = [[RichTextRow alloc] init];
        r.html = self.faq.answer;
        return r;
    }
    else {
        return nil;
    }
}


@end
