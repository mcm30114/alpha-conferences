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


@interface StandardController ()

@property (nonatomic, unsafe_unretained) UITableView *tableView;
@property (nonatomic) NSInteger selectedPage;

- (DTAttributedTextCell *)prepareAttributedTextCellWithMetadata:(RichTextRow *)md tableView:(UITableView *)tableView;

@end



@implementation StandardController

@synthesize tableView = _tableView;
@synthesize model = _model;
@synthesize selectedPage = _selectedPage;


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        self.selectedPage = 0;
    }
    return self;
}


#pragma mark - View lifecycle


- (void)loadView {
    
    UIView *rootView = [[UIView alloc] initWithFrame:[[UIScreen mainScreen] applicationFrame]];
    rootView.backgroundColor = [UIColor whiteColor];
    self.view = rootView;
    
    NSArray *strings = [NSArray arrayWithObjects:@"A",@"B",@"C",nil];
    AlphaPager *pager = [[AlphaPager alloc] initWithStrings:strings frame:CGRectMake(0, 0, self.view.bounds.size.width, 44)];
    pager.delegate = self;
    pager.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    [rootView addSubview:pager];      
    //    self.pager = pager;
    
    CGRect tableViewFrame = pager ? CGRectMake(0, 44, self.view.bounds.size.width, self.view.bounds.size.height-pager.frame.size.height) : CGRectMake(0, 44, self.view.bounds.size.width, self.view.bounds.size.height); 
    UITableView *tableView = [[UITableView alloc] initWithFrame:tableViewFrame style:UITableViewStylePlain];    
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
    return [self.model numberOfSectionsInPage:self.selectedPage];
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.model numberOfRowsInPage:self.selectedPage section:section];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    id row = [self.model rowForPage:self.selectedPage section:indexPath.section row:indexPath.row];
    
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
        
        cell.imageView.image = alphaRow.image;
        
        return cell;
        
    } else if ([row isKindOfClass:[RichTextRow class]]) {
        
        DTAttributedTextCell *cell = [self prepareAttributedTextCellWithMetadata:(RichTextRow *)row tableView:tableView];
        return cell;
        
    } else if ([row isKindOfClass:[ButtonBarRow class]]) {
        
        UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
        cell.backgroundView = [[UIView alloc] initWithFrame:CGRectZero];
        cell.backgroundView.backgroundColor = [UIColor clearColor];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        ButtonBarRow *buttonBar = row;
        UIButton *button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        [button setTitle:buttonBar.title forState:UIControlStateNormal];
        button.frame = CGRectMake(0, 0, cell.contentView.bounds.size.width, cell.contentView.bounds.size.height);
        button.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        [cell.contentView addSubview:button];
        return cell;
        
    } else {
        return nil;
    }
}


#pragma mark - UITableViewDelegate methods


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    id row = [self.model rowForPage:self.selectedPage section:indexPath.section row:indexPath.row];
    
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


#pragma mark - AlphaPagerDelegate methods


- (void)alphaPager:(AlphaPager *)alphaPager didChangePageWithIndex:(NSInteger)index {
    self.selectedPage = index;
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


@end
