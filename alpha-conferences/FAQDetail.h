//
//  FAQDetail.h
//  alpha-conferences
//
//  Created by Erik Erskine on 19/04/2012.
//  Copyright (c) 2012 Brightec Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "StandardControllerModel.h"
#import "FAQ.h"


@interface FAQDetail : NSObject <StandardControllerModel>

-(id)initWithFAQ:(FAQ *)faq;

@end
