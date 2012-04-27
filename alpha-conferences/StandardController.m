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
#import "ImageRow.h"
#import "ProgrammeRow.h"
#import "Constants.h"
#import "ButtonCell.h"
#import "ResourceCache.h"
#import "LabelTextProperties.h"
#import "ProgrammeCell.h"


@interface StandardController () {
    UITableViewStyle tableViewStyle;
    BOOL showPager;
    NSInteger selectedPage;
}

@property (nonatomic, unsafe_unretained) UITableView *tableView;
@property (nonatomic, unsafe_unretained) AlphaPager *pager;
@property (nonatomic, strong) LabelTextProperties *textLabelProperties;
@property (nonatomic, strong) LabelTextProperties *detailTextLabelProperties;
@property (nonatomic, strong) LabelTextProperties *programmeSpeakerTextLabelProperties;
@property (nonatomic, strong) LabelTextProperties *programmeTimeTextLabelProperties;

- (DTAttributedTextCell *)prepareAttributedTextCellWithMetadata:(RichTextRow *)md tableView:(UITableView *)tableView;
- (void)dataWasUpdated:(NSNotification *)n;

@end



@implementation StandardController

@synthesize tableView = _tableView;
@synthesize pager = _pager;
@synthesize model = _model;
@synthesize textLabelProperties;
@synthesize detailTextLabelProperties;
@synthesize programmeSpeakerTextLabelProperties;
@synthesize programmeTimeTextLabelProperties;


- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}


- (id)initWithStyle:(UITableViewStyle)style pager:(BOOL)pager {
    if (self = [super initWithNibName:nil bundle:nil]) {
        tableViewStyle = style;
        showPager = pager;
        selectedPage = 0;
        
        // set default styles for cells
        self.textLabelProperties = [[LabelTextProperties alloc] initWithFont:[UIFont tableCellTitleFont] textColour:[UIColor tableCellTitleColour] lineBreakMode:UILineBreakModeWordWrap];
        self.detailTextLabelProperties = [[LabelTextProperties alloc] initWithFont:[UIFont tableCellSubTitleFont] textColour:[UIColor tableSubTitleColour] lineBreakMode:UILineBreakModeWordWrap];
        self.programmeSpeakerTextLabelProperties = [[LabelTextProperties alloc] initWithFont:[UIFont tableCellSubTitleFont] textColour:[UIColor tableSubTitleColour] lineBreakMode:UILineBreakModeWordWrap];
        self.programmeTimeTextLabelProperties = [[LabelTextProperties alloc] initWithFont:[UIFont systemFontOfSize:11] textColour:[UIColor grayColor] lineBreakMode:UILineBreakModeWordWrap];
        
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
        NSString *cellId = [NSString stringWithFormat:@"AlphaCellWithStyleId%i",  alphaRow.style];
        
        AlphaCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
        if (cell == nil) {
            cell = [[AlphaCell alloc] initWithStyle:alphaRow.style reuseIdentifier:cellId];
            [self.textLabelProperties setPropertiesForLabel:cell.textLabel];
            [self.detailTextLabelProperties setPropertiesForLabel:cell.detailTextLabel];            
        }
        
        cell.textLabel.text = alphaRow.text;
        cell.detailTextLabel.text = alphaRow.detailText;
        cell.accessoryType = alphaRow.accessoryType;
        
        if (alphaRow.imageResource) {
            cell.cellImageView.image = [[ResourceCache defaultResourceCache] imageForResource:alphaRow.imageResource onComplete:^(UIImage *image) {
                cell.cellImageView.image = image;
            }];
        }
        else {
            cell.cellImageView.image = nil;
        }

        if (alphaRow.onSelected == nil) {
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        else {
            cell.selectionStyle = UITableViewCellSelectionStyleBlue;
        }
        
        return cell;
    
    } else if ([row isKindOfClass:[ProgrammeRow class]]) {
        
        ProgrammeRow *programmeRow = row;
        NSString *cellId = @"ProgrammeCell";
        
        ProgrammeCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
        if (cell == nil) {
            cell = [[ProgrammeCell alloc] initWithReuseIdentifier:cellId];
            
            [self.textLabelProperties setPropertiesForLabel:cell.textLabel];
            [self.detailTextLabelProperties setPropertiesForLabel:cell.detailTextLabel];
            [self.programmeSpeakerTextLabelProperties setPropertiesForLabel:cell.speakerTextLabel];
            [self.programmeTimeTextLabelProperties setPropertiesForLabel:cell.timeTextLabel];
        }
        
        
        cell.textLabel.text = programmeRow.text;
        cell.detailTextLabel.text = programmeRow.detailText;
        cell.speakerTextLabel.text = programmeRow.speakerText;
        cell.timeTextLabel.text = programmeRow.dateTimeText;
        cell.accessoryType = programmeRow.accessoryType;
        cell.barColour = programmeRow.barColour;
        
        if (programmeRow.onSelected == nil) {
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        else {
            cell.selectionStyle = UITableViewCellSelectionStyleBlue;
        }
        
        return cell;
        
    } else if ([row isKindOfClass:[RichTextRow class]]) {
        
        DTAttributedTextCell *cell = [self prepareAttributedTextCellWithMetadata:(RichTextRow *)row tableView:tableView];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
        
    } else if ([row isKindOfClass:[ButtonBarRow class]]) {
        
        return [[ButtonCell alloc] initWithButtonBarRow:(ButtonBarRow *)row controller:self];
        
    } else if ([row isKindOfClass:[ImageRow class]]) {
        
        // for some reason, we can't make the original cell imageView be full width
        Resource *resource = ((ImageRow *)row).resource;
        UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, resource.size.width, resource.size.height)];
        imageView.autoresizingMask = UIViewAutoresizingNone;
        imageView.image = [[ResourceCache defaultResourceCache] imageForResource:resource onComplete:^(UIImage *image) {
            imageView.image = image;
        }];
        [cell.contentView addSubview:imageView];
        return cell;
        
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
        CGSize imageViewSize = alphaRow.imageResource ? alphaRow.imageResource.size : CGSizeZero;
        
        NSMutableArray *labelStrings = [NSMutableArray arrayWithObject:alphaRow.text];
        NSMutableArray *labelProperties = [NSMutableArray arrayWithObject:self.textLabelProperties];
        
        if (alphaRow.detailText.length > 0) {
            [labelStrings addObject:alphaRow.detailText];
            [labelProperties addObject:self.detailTextLabelProperties];
        }        
        
        return [AlphaCell heightForRowWithTableView:tableView 
                         tableViewCellAccessoryType:alphaRow.accessoryType 
                                   labelTextStrings:labelStrings 
                                labelTextProperties:labelProperties 
                                          imageSize:imageViewSize];
        
    } else if ([row isKindOfClass:[ProgrammeRow class]]) {
        
        ProgrammeRow *programmeRow = row;
        
        NSMutableArray *labelStrings = [NSMutableArray arrayWithObject:programmeRow.text];
        NSMutableArray *labelProperties = [NSMutableArray arrayWithObject:self.textLabelProperties];
        
        if (programmeRow.detailText.length > 0) {
            [labelStrings addObject:programmeRow.detailText];
            [labelProperties addObject:self.detailTextLabelProperties];
        }
        
        if (programmeRow.speakerText.length > 0) {
            [labelStrings addObject:programmeRow.speakerText];
            [labelProperties addObject:self.programmeSpeakerTextLabelProperties];
        }
        
        if (programmeRow.dateTimeText.length > 0) {
            [labelStrings addObject:programmeRow.dateTimeText];
            [labelProperties addObject:self.programmeTimeTextLabelProperties];
        }           
        
        return [ProgrammeCell heightForRowWithTableView:tableView 
                             tableViewCellAccessoryType:programmeRow.accessoryType 
                                       labelTextStrings:labelStrings 
                                    labelTextProperties:labelProperties];
        
    } else if ([row isKindOfClass:[RichTextRow class]]) {
        
        DTAttributedTextCell *cell = [self prepareAttributedTextCellWithMetadata:(RichTextRow *)row tableView:tableView];
        return [cell requiredRowHeightInTableView:tableView];
        
    } else if ([row isKindOfClass:[ButtonBarRow class]]) {
        return 44.0;
        
    } else if ([row isKindOfClass:[ImageRow class]]) {
        return ((ImageRow *)row).resource.size.height;

    } else {
        return 44.0;
    }
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    id row = [self.model rowForPage:selectedPage section:indexPath.section row:indexPath.row];

    if ([row isKindOfClass:[AlphaRow class]]) {
        AlphaRow *alphaRow = row;
        if (alphaRow.onSelected) {
            alphaRow.onSelected(self);
        }
    }
    else if ([row isKindOfClass:[ProgrammeRow class]]) {
        ProgrammeRow *programmeRow = row;
        if (programmeRow.onSelected) {
            programmeRow.onSelected(self);
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
        cell.attributedTextContextView.edgeInsets = UIEdgeInsetsMake(5, 10, 10, 10);
    }
    
    NSMutableDictionary *options = [NSMutableDictionary dictionary];
    [options setObject:[NSNumber numberWithFloat:1.2] forKey:NSTextSizeMultiplierDocumentOption];
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
