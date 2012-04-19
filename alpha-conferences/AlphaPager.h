//
//  AlphaPager.h
//  alpha-conferences
//
//  Created by Cameron Cooke on 16/04/2012.
//  Copyright (c) 2012 Brightec Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol AlphaPagerDelegate;
@protocol AlphaPagerDataSource;


@interface AlphaPager : UIView

@property (nonatomic, unsafe_unretained) UILabel *titleLabel;
@property (nonatomic) NSInteger pageIndex;
@property (nonatomic, unsafe_unretained) id<AlphaPagerDelegate> delegate;
@property (nonatomic, unsafe_unretained) id<AlphaPagerDataSource> dataSource;

- (id)initWithFrame:(CGRect)frame;
- (id)initWithStrings:(NSArray *)strings frame:(CGRect)frame; // deprecated
- (void)nextPage;
- (void)prevPage;
- (void)gotoPageAtIndex:(NSInteger)index;
- (void)reloadData;

@end

@protocol AlphaPagerDataSource
- (NSInteger)numberOfTitlesInAlphaPager:(AlphaPager *)alphaPager;
- (NSString *)alphaPager:(AlphaPager *)alphaPager titleForPageAtIndex:(NSInteger)index;
@end

@protocol AlphaPagerDelegate
- (void)alphaPager:(AlphaPager *)alphaPager didChangePageWithIndex:(NSInteger)index;
@end