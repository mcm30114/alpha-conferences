//
//  RichTextRow.h
//  alpha-conferences
//
//  Created by Erik Erskine on 19/04/2012.
//  Copyright (c) 2012 Brightec Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface RichTextRow : NSObject

@property (nonatomic, strong) NSString *html;

- (id)initWithHTML:(NSString *)html;

@end
