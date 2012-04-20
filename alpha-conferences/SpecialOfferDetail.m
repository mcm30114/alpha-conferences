//
//  SpecialOfferDetail.m
//  alpha-conferences
//
//  Created by Erik Erskine on 20/04/2012.
//  Copyright (c) 2012 Brightec Ltd. All rights reserved.
//

#import "SpecialOfferDetail.h"
#import "RichTextRow.h"


@interface SpecialOfferDetail ()

@property (nonatomic, readonly, strong) SpecialOffer *offer;

@end



@implementation SpecialOfferDetail

@synthesize offer = _offer;


-(id)initWithSpecialOffer:(SpecialOffer *)offer {
    if (self = [super init]) {
        _offer = offer;
    }
    return self;
}


-(NSInteger)numberOfSectionsInPage:(NSInteger)page {
    return 1;
}


-(NSInteger)numberOfRowsInPage:(NSInteger)page section:(NSInteger)section {
    return 1;
}


-(id)rowForPage:(NSInteger)page section:(NSInteger)section row:(NSInteger)row {
    NSString *html = [NSString stringWithFormat:@"<p><b>%@</b></p>%@", self.offer.title, self.offer.html];
    return [[RichTextRow alloc] initWithHTML:html];
}


@end
