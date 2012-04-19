//
//  AlphaPager.m
//  alpha-conferences
//
//  Created by Cameron Cooke on 16/04/2012.
//  Copyright (c) 2012 Brightec Ltd. All rights reserved.
//

#import "AlphaPager.h"
#import "CGUtils.h"


@interface AlphaPager ()
@property (nonatomic, unsafe_unretained) UIButton *nextButton;
@property (nonatomic, unsafe_unretained) UIButton *prevButton;
@property (nonatomic, strong) NSArray *strings;
@end


@implementation AlphaPager

@synthesize nextButton = _nextButton;
@synthesize prevButton = _prevButton;
@synthesize titleLabel = _titleLabel;
@synthesize strings = _strings;
@synthesize pageIndex = _pageIndex;
@synthesize delegate = _delegate;
@synthesize dataSource = _dataSource;


- (id)initWithFrame:(CGRect)frame {
    return [self initWithStrings:[NSArray arrayWithObject:@""] frame:frame];
}


- (id)initWithStrings:(NSArray *)strings frame:(CGRect)frame {
    frame.size.height = 44;
    self = [super initWithFrame:frame];
    if (self) {
        _pageIndex = 0;
        _strings = strings;
        self.backgroundColor = [UIColor colorWithHex:0xcdcdd2ff];
        
        // next button
        UIButton *nextButton = [UIButton buttonWithType:UIButtonTypeCustom];
        nextButton.frame = CGRectMake(self.bounds.size.width-26, 14, 13, 16);
        nextButton.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin;
        [nextButton setImage:[UIImage imageNamed:@"right-arrow.png"] forState:UIControlStateNormal];
        [nextButton addTarget:self action:@selector(nextPage) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:nextButton];
        self.nextButton = nextButton;
        
        // prev button
        UIButton *prevButton = [UIButton buttonWithType:UIButtonTypeCustom];
        prevButton.frame = CGRectMake(10, 14, 13, 16);
        prevButton.autoresizingMask = UIViewAutoresizingFlexibleRightMargin;        
        [prevButton setImage:[UIImage imageNamed:@"left-arrow.png"] forState:UIControlStateNormal];
        [prevButton addTarget:self action:@selector(prevPage) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:prevButton];
        self.prevButton = prevButton;  
        
        // label
        UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.bounds.size.width, 16)];
        titleLabel.textAlignment = UITextAlignmentCenter;
        titleLabel.font = [UIFont boldSystemFontOfSize:16.0];
        titleLabel.textColor = [UIColor colorWithHex:0x313c49ff];
        titleLabel.shadowColor = [UIColor whiteColor];
        titleLabel.shadowOffset = CGSizeMake(0, 1);
        titleLabel.center = self.center;
        titleLabel.backgroundColor = [UIColor clearColor];
        titleLabel.opaque = NO;
        titleLabel.autoresizingMask = UIViewAutoresizingFlexibleWidth;
        [self addSubview:titleLabel];
        self.titleLabel = titleLabel;
        [self gotoPageAtIndex:self.pageIndex];
    }
    return self;
}


- (void)drawRect:(CGRect)rect {
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    UIColor *topGradientColour = [UIColor colorWithHex:0xf5f5f6ff];
    UIColor *bottomGradientColour = [UIColor colorWithHex:0xcdcdd2ff];
    
    CGContextSetLineWidth(context, 1.0);
    
    drawLinearGradient(context, rect, topGradientColour, bottomGradientColour);
    draw1PxStroke(context, CGPointMake(0, rect.size.height-1), CGPointMake(rect.size.width, rect.size.height-1), [UIColor colorWithHex:0xaaaeb6ff].CGColor);    
}


#pragma mark


- (void)nextPage {
    [self gotoPageAtIndex:self.pageIndex+1];
}


- (void)prevPage {
    [self gotoPageAtIndex:self.pageIndex-1];
}


- (void)gotoPageAtIndex:(NSInteger)index {
    
    self.prevButton.enabled = (index > 0);
    self.nextButton.enabled = (index < self.strings.count-1);
    
    self.pageIndex = index;
    self.titleLabel.text = [self.strings objectAtIndex:index];
    
    // inform delegate
    if ([(id)self.delegate respondsToSelector:@selector(alphaPager:didChangePageWithIndex:)]) {
        [self.delegate alphaPager:self didChangePageWithIndex:index];
    }
}


- (void)reloadData {
    if (self.dataSource) {
        NSInteger count = [self.dataSource numberOfTitlesInAlphaPager:self];
        NSMutableArray *a = [NSMutableArray arrayWithCapacity:count];
        for (NSInteger x=0; x<count; x++) {
            NSString *title = [self.dataSource alphaPager:self titleForPageAtIndex:x];
            if (!title) {
                title = @"";
            }
            [a addObject:title];
        }
        self.strings = a;
    } else {
        self.strings = [NSArray arrayWithObject:@""];
    }
    [self gotoPageAtIndex:0];
}


@end