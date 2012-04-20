//
//  StandardController.m
//  alpha-conferences
//
//  Created by Erik Erskine on 19/04/2012.
//  Copyright (c) 2012 Brightec Ltd. All rights reserved.
//

#import "StandardController.h"
#import "AlphaCell.h"
#import "AlphaRow.h"
#import "RichTextRow.h"
#import "ButtonBarRow.h"
#import "Constants.h"
#import "ButtonCell.h"


@interface StandardController () {
    UITableViewStyle tableViewStyle;
    BOOL showPager;
    NSInteger selectedPage;
}

@property (nonatomic, unsafe_unretained) UITableView *tableView;
@property (nonatomic, unsafe_unretained) AlphaPager *pager;

- (DTAttributedTextCell *)prepareAttributedTextCellWithMetadata:(RichTextRow *)md tableView:(UITableView *)tableView;

- (void)dataWasUpdated:(NSNotification *)n;

@end



@implementation StandardController

@synthesize tableView = _tableView;
@synthesize pager = _pager;
@synthesize model = _model;


- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}


- (id)initWithStyle:(UITableViewStyle)style pager:(BOOL)pager {
    if (self = [super initWithNibName:nil bundle:nil]) {
        tableViewStyle = style;
        showPager = pager;
        selectedPage = 0;
        
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(dataWasUpdated:)
                                                     name:NOTIFICATION_DATA
                                                   object:nil];
    }
    return self;
}


#pragma mark - View lifecycle


- (void)loadView {
    
    UIView *rootView = [[UIView alloc] initWithFrame:[[UIScreen mainScreen] applicationFrame]];
    rootView.backgroundColor = [UIColor whiteColor];
    self.view = rootView;
    
    CGFloat y = 0;
    if (showPager) {
        AlphaPager *pager = [[AlphaPager alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 44)];
        pager.dataSource = self;
        pager.delegate = self;
        pager.autoresizingMask = UIViewAutoresizingFlexibleWidth;
        [rootView addSubview:pager];      
        self.pager = pager;
        [pager reloadData];
        y += pager.frame.size.height;
    }
    
    CGRect tableViewFrame = CGRectMake(0, y, self.view.bounds.size.width, self.view.bounds.size.height-y); 
    UITableView *tableView = [[UITableView alloc] initWithFrame:tableViewFrame style:tableViewStyle];    
    tableView.dataSource = self;
    tableView.delegate = self;
    tableView.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
    [rootView addSubview:tableView];
    self.tableView = tableView;
    
//    UIView *footerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 64)];
//    footerView.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
//    self.tableView.tableFooterView = footerView;
//    
//    UIButton *websiteButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
//    [websiteButton setTitle:@"Book now" forState:UIControlStateNormal];
//    websiteButton.frame = CGRectMake(10, 10, (footerView.bounds.size.width - 15), 44);
//    websiteButton.enabled = self.conference.bookingURL.length > 0;
//    [footerView addSubview:websiteButton];
}



- (void)viewDidUnload {
    [super viewDidUnload];
    self.tableView = nil;
    self.pager = nil;
}


-(void)viewDidAppear:(BOOL)animated {
    if (self.tableView.indexPathForSelectedRow) {
        [self.tableView deselectRowAtIndexPath:self.tableView.indexPathForSelectedRow animated:YES];
    }     
}


- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    return YES;
}


#pragma mark - UITableViewDataSource methods


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    if ([self.model respondsToSelector:@selector(numberOfSectionsInPage:)]) {
        return [self.model numberOfSectionsInPage:selectedPage];
    } else {
        return 1;
    }
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.model numberOfRowsInPage:selectedPage section:section];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    id row = [self.model rowForPage:selectedPage section:indexPath.section row:indexPath.row];
    
    if ([row isKindOfClass:[AlphaRow class]]) {
        
        AlphaRow *alphaRow = row;
        AlphaCell *cell = [[AlphaCell alloc] initWithStyle:AlphaTableViewCellWithImageRight reuseIdentifier:nil];
        
        cell.textLabel.text = alphaRow.text;
        cell.textLabel.font = [UIFont tableCellTitleFont];
        cell.textLabel.textColor = [UIColor tableCellTitleColour];            
        cell.textLabel.lineBreakMode = UILineBreakModeWordWrap;
        cell.textLabel.numberOfLines = 0;
        
        cell.detailTextLabel.text = alphaRow.detailText;
        cell.detailTextLabel.font = [UIFont tableCellSubTitleFont];
        cell.detailTextLabel.textColor = [UIColor tableSubTitleColour];
        cell.detailTextLabel.lineBreakMode = UILineBreakModeWordWrap;
        cell.detailTextLabel.numberOfLines = 0;
        
        cell.accessoryType = alphaRow.accessoryType;
        cell.imageView.image = alphaRow.image;
        
        return cell;
        
    } else if ([row isKindOfClass:[RichTextRow class]]) {
        
        DTAttributedTextCell *cell = [self prepareAttributedTextCellWithMetadata:(RichTextRow *)row tableView:tableView];
        return cell;
        
    } else if ([row isKindOfClass:[ButtonBarRow class]]) {
        
//        UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
//        cell.backgroundView = [[UIView alloc] initWithFrame:CGRectZero];
//        cell.backgroundView.backgroundColor = [UIColor clearColor];
//        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
//        ButtonBarRow *buttonBar = row;
//        UIButton *button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
//        [button addTarget:self action:@selector(handleButtonTap:) forControlEvents:UIControlEventTouchUpInside];
//        [button setTitle:buttonBar.title forState:UIControlStateNormal];
//        button.frame = CGRectMake(0, 0, cell.contentView.bounds.size.width, cell.contentView.bounds.size.height);
//        button.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
//        [cell.contentView addSubview:button];
//        return cell;
        return [[ButtonCell alloc] initWithButtonBarRow:(ButtonBarRow *)row];
        
        
    } else {
        NSLog(@"don't know how to get a cell for page %d, section %d, row %d", selectedPage, indexPath.section, indexPath.row);
        return nil;
    }
}


- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    if ([self.model respondsToSelector:@selector(sectionTitleForPage:section:)]) {
        return [self.model sectionTitleForPage:selectedPage section:section];
    } else {
        return nil;
    }
}


- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView {
    if ([self.model respondsToSelector:@selector(sectionIndexTitlesForPage:)]) {
        return [self.model sectionIndexTitlesForPage:selectedPage];
    } else {
        return nil;
    }
}


#pragma mark - UITableViewDelegate methods


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    id row = [self.model rowForPage:selectedPage section:indexPath.section row:indexPath.row];
    
    if ([row isKindOfClass:[AlphaRow class]]) {
        
        AlphaRow *alphaRow = row;
        return [AlphaCell heightForRowWithTableView:self.tableView
                         tableViewCellAccessoryType:alphaRow.accessoryType
                            alphaTableViewCellStyle:alphaRow.style
                                      textLabelText:alphaRow.text
                                detailTextLabelText:alphaRow.detailText
                                     imageViewImage:alphaRow.image];
        
    } else if ([row isKindOfClass:[RichTextRow class]]) {
        
        DTAttributedTextCell *cell = [self prepareAttributedTextCellWithMetadata:(RichTextRow *)row tableView:tableView];
        return [cell requiredRowHeightInTableView:tableView];
        
    } else if ([row isKindOfClass:[ButtonBarRow class]]) {
        return 44.0;
        
    } else {
        return 44.0;
    }
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    id row = [self.model rowForPage:selectedPage section:indexPath.section row:indexPath.row];

    if ([row isKindOfClass:[AlphaRow class]]) {
        AlphaRow *alphaRow = row;
        if (alphaRow.onSelected) {
            NSLog(@"alphaRow has an onSelected block");
            alphaRow.onSelected(self);
        } else {
            NSLog(@"alphaRow does not have an onSelected block");
        }
    }
}


#pragma mark - AlphaPagerDataSource methods


- (NSInteger)numberOfTitlesInAlphaPager:(AlphaPager *)alphaPager {
    if ([self.model respondsToSelector:@selector(numberOfPages)]) {
        return [self.model numberOfPages];
    } else {
        return 0;
    }
}


- (NSString *)alphaPager:(AlphaPager *)alphaPager titleForPageAtIndex:(NSInteger)index {
    if ([self.model respondsToSelector:@selector(pageTitleForPage:)]) {
        return [self.model pageTitleForPage:index];
    } else {
        return nil;
    }
}


#pragma mark - AlphaPagerDelegate methods


- (void)alphaPager:(AlphaPager *)alphaPager didChangePageWithIndex:(NSInteger)index {
    selectedPage = index;
    [self.tableView reloadData];
}


#pragma mark -


- (DTAttributedTextCell *)prepareAttributedTextCellWithMetadata:(RichTextRow *)md tableView:(UITableView *)tableView  {
    NSString *cellIdentifier = @"AttributedCell";
    DTAttributedTextCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        cell = [[DTAttributedTextCell alloc] initWithReuseIdentifier:cellIdentifier accessoryType:UITableViewCellAccessoryNone];
        cell.attributedTextContextView.edgeInsets = UIEdgeInsetsMake(10, 10, 10, 10);
    }
    
    NSMutableDictionary *options = [NSMutableDictionary dictionary];
    [options setObject:[NSNumber numberWithFloat:1.0] forKey:NSTextSizeMultiplierDocumentOption];
    [options setObject:@"Helvetica" forKey:DTDefaultFontFamily];
    [options setObject:@"blue" forKey:DTDefaultLinkColor];
    
    if (md.html) {
        NSData *data = [md.html dataUsingEncoding:NSUTF8StringEncoding];
        NSAttributedString *string = [[NSAttributedString alloc] initWithHTML:data options:options documentAttributes:nil];
        [cell setAttributedString:string];
    } else {
        [cell setHTMLString:@""];
    }
    
    return cell;
}


- (void)dataWasUpdated:(NSNotification *)notification {
    if ([self.model respondsToSelector:@selector(reloadData)]) {
        [self.model reloadData];
        [self.tableView reloadData];
        [self.pager reloadData];
    }
}


@end
