//
//  RichTextRow.m
//  alpha-conferences
//
//  Created by Erik Erskine on 19/04/2012.
//  Copyright (c) 2012 Brightec Ltd. All rights reserved.
//

#import "RichTextRow.h"


@implementation RichTextRow

@synthesize html = _html;


- (id)initWithHTML:(NSString *)html {
    if (self = [super init]) {
        self.html = html;
    }
    return self;
}


@end
