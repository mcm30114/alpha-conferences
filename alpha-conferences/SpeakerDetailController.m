//
//  SpeakerDetailController.m
//  alpha-conferences
//
//  Created by Cameron Cooke on 16/04/2012.
//  Copyright (c) 2012 Brightec Ltd. All rights reserved.
//

#import "SpeakerDetailController.h"
#import "AlphaCell.h"


#define HEADER_SECTION_INDEX 0
#define SOCIAL_SECTION_INDEX 1
#define BIO_SECTION_INDEX 2
#define SESSIONS_SECTION_INDEX 3


@interface SpeakerDetailController ()
@property (nonatomic, unsafe_unretained) UITableView *tableView;
@property (nonatomic, strong) NSArray *sections;
@end


@implementation SpeakerDetailController

@synthesize tableView = _tableView;
@synthesize sections = _sections;


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
        // dummy datasource
        NSMutableDictionary *row1section1 = [NSMutableDictionary dictionary];
        [row1section1 setObject:@"The quick brown fox jumped over the lazy dog." forKey:@"cell_title"];
        [row1section1 setObject:@"Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed faucibus molestie laoreet. In nec ipsum massa, et imperdiet nisl. Pellentesque commodo pretium velit nec placerat. Proin varius gravida dolor, non ullamcorper nisl aliquam in. Maecenas vel elit eu libero ornare vulputate. In accumsan dapibus turpis et pharetra. Sed diam est, feugiat eget auctor at, hendrerit eu magna." forKey:@"cell_sub_title"];
        [row1section1 setObject:[UIImage imageNamed:@"cell-image.png"] forKey:@"cell_image"];        
        NSDictionary *section1 = [NSDictionary dictionaryWithObjectsAndKeys:[NSArray arrayWithObject:row1section1], @"rows", nil];             
        
        NSMutableDictionary *row1section2 = [NSMutableDictionary dictionary];
        [row1section2 setObject:@"The quick brown fox jumped over the lazy dog." forKey:@"cell_title"];
        [row1section2 setObject:@"Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed faucibus molestie laoreet. In nec ipsum massa, et imperdiet nisl. Pellentesque commodo pretium velit nec placerat. Proin varius gravida dolor, non ullamcorper nisl aliquam in. Maecenas vel elit eu libero ornare vulputate. In accumsan dapibus turpis et pharetra. Sed diam est, feugiat eget auctor at, hendrerit eu magna. \n\n Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed faucibus molestie laoreet. In nec ipsum massa, et imperdiet nisl. Pellentesque commodo pretium velit nec placerat. Proin varius gravida dolor, non ullamcorper nisl aliquam in. Maecenas vel elit eu libero ornare vulputate. In accumsan dapibus turpis et pharetra. Sed diam est, feugiat eget auctor at, hendrerit eu magna." forKey:@"cell_sub_title"];
        [row1section2 setObject:[UIImage imageNamed:@"cell-image.png"] forKey:@"cell_image"];                
        NSDictionary *section2 = [NSDictionary dictionaryWithObjectsAndKeys:[NSArray arrayWithObject:row1section2], @"rows", nil];      
        
        NSMutableDictionary *row1section3 = [NSMutableDictionary dictionary];
        [row1section3 setObject:@"Hello" forKey:@"cell_title"];
        [row1section3 setObject:@"World" forKey:@"cell_sub_title"];
        [row1section3 setObject:[UIImage imageNamed:@"cell-image.png"] forKey:@"cell_image"];        
        NSDictionary *section3 = [NSDictionary dictionaryWithObjectsAndKeys:[NSArray arrayWithObject:row1section3], @"rows", nil];          
        
        self.sections = [NSArray arrayWithObjects:section1, section2, section3, nil];
    }
    
    return self;
}


#pragma mark - View lifecycle


- (void)loadView {
    
    UITableView *tableView = [[UITableView alloc] initWithFrame:[[UIScreen mainScreen] applicationFrame] style:UITableViewStyleGrouped];    
    tableView.dataSource = self;
    tableView.delegate = self;
    tableView.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
    self.view = tableView;
    self.tableView = tableView;
}


- (void)viewDidUnload {
    [super viewDidUnload];
    
    // Release any retained subviews of the main view.
    self.tableView = nil;
}


- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    //    return (interfaceOrientation == UIInterfaceOrientationPortrait);
    return YES;
}


-(void)viewDidAppear:(BOOL)animated {
    if (self.tableView.indexPathForSelectedRow) {
        [self.tableView deselectRowAtIndexPath:self.tableView.indexPathForSelectedRow animated:YES];
    }     
}


#pragma mark - Table view data source


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.sections.count;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [[[self.sections objectAtIndex:section] objectForKey:@"rows"] count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
        
    switch (indexPath.section) {
            
        case HEADER_SECTION_INDEX: {
            
            NSString *cellIdentifier = @"HeaderCell";
            
            AlphaCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
            if (cell == nil) {
                cell = [[AlphaCell alloc] initWithStyle:AlphaTableViewCellWithImageLeft reuseIdentifier:cellIdentifier];
            }
            
            NSDictionary *rowData = [self dataForIndexPath:indexPath];
            
            cell.textLabel.text = [rowData objectForKey:@"cell_title"];
            cell.textLabel.font = [UIFont tableCellTitleFont];
            cell.textLabel.textColor = [UIColor tableCellTitleColour];            
            cell.textLabel.lineBreakMode = UILineBreakModeWordWrap;
            cell.textLabel.numberOfLines = 0;
            
            cell.detailTextLabel.text = [rowData objectForKey:@"cell_sub_title"];
            cell.detailTextLabel.font = [UIFont tableCellSubTitleFont];
            cell.detailTextLabel.textColor = [UIColor tableSubTitleColour];            
            cell.detailTextLabel.lineBreakMode = UILineBreakModeWordWrap;
            cell.detailTextLabel.lineBreakMode = UILineBreakModeWordWrap;
            cell.detailTextLabel.numberOfLines = 0;            
            
            cell.imageView.image = [rowData objectForKey:@"cell_image"];
            
            return cell;            
            
            break;
        }
            
        case SOCIAL_SECTION_INDEX: {
            
            NSString *cellIdentifier = @"SocialCell";
            
            AlphaCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
            if (cell == nil) {
                cell = [[AlphaCell alloc] initWithStyle:AlphaTableViewCellWithImageLeft reuseIdentifier:cellIdentifier];
            }
            
            NSDictionary *rowData = [self dataForIndexPath:indexPath];
            
            cell.textLabel.text = [rowData objectForKey:@"cell_title"];
            cell.textLabel.font = [UIFont tableCellTitleFont];
            cell.textLabel.textColor = [UIColor tableCellTitleColour];            
            cell.textLabel.lineBreakMode = UILineBreakModeWordWrap;
            cell.textLabel.numberOfLines = 0;
            
            cell.detailTextLabel.text = [rowData objectForKey:@"cell_sub_title"];
            cell.detailTextLabel.font = [UIFont tableCellSubTitleFont];
            cell.detailTextLabel.textColor = [UIColor tableSubTitleColour];            
            cell.detailTextLabel.lineBreakMode = UILineBreakModeWordWrap;
            cell.detailTextLabel.numberOfLines = 0;            
            
            cell.imageView.image = [rowData objectForKey:@"cell_image"];
            
            return cell;            
            
            break;
        }
            
        case BIO_SECTION_INDEX: {
            
            NSString *cellIdentifier = @"BioCell";
            
            AlphaCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
            if (cell == nil) {
                cell = [[AlphaCell alloc] initWithStyle:AlphaTableViewCellWithImageRight reuseIdentifier:cellIdentifier];
            }
            
            NSDictionary *rowData = [self dataForIndexPath:indexPath];
            
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            
            cell.textLabel.text = [rowData objectForKey:@"cell_title"];
            cell.textLabel.font = [UIFont tableCellTitleFont];
            cell.textLabel.textColor = [UIColor tableCellTitleColour];            
            cell.textLabel.lineBreakMode = UILineBreakModeWordWrap;
            cell.textLabel.numberOfLines = 0;
            
            cell.detailTextLabel.text = [rowData objectForKey:@"cell_sub_title"];
            cell.detailTextLabel.font = [UIFont tableCellSubTitleFont];
            cell.detailTextLabel.textColor = [UIColor tableSubTitleColour];            
            cell.detailTextLabel.lineBreakMode = UILineBreakModeWordWrap;
            cell.detailTextLabel.lineBreakMode = UILineBreakModeWordWrap;
            cell.detailTextLabel.numberOfLines = 0;            
            
            cell.imageView.image = [rowData objectForKey:@"cell_image"];
            
            return cell;            
            
            break;
        }
            
        case SESSIONS_SECTION_INDEX:
        default: {
            
            NSString *cellIdentifier = @"SessionCell";
            
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
            if (cell == nil) {
                cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIdentifier];
            }
            
            return cell;
            
            break;
        }
    }
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSDictionary *rowData = [self dataForIndexPath:indexPath];
    
    UITableViewCellAccessoryType accessoryType = UITableViewCellAccessoryNone;
    if (indexPath.section == 2) {
        accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    
    AlphaTableViewCellStyle alphaCellStyle = AlphaTableViewCellWithImageLeft;
    if (indexPath.section == 3) {
        accessoryType = AlphaTableViewCellWithImageRight;
    }    
    
    return [AlphaCell heightForRowWithTableView:self.tableView 
                     tableViewCellAccessoryType:accessoryType 
            alphaTableViewCellStyle:alphaCellStyle
                                  textLabelText:[rowData objectForKey:@"cell_title"] 
                            detailTextLabelText:[rowData objectForKey:@"cell_sub_title"] 
                                 imageViewImage:[rowData objectForKey:@"cell_image"]];
}


//- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
//    CGFloat height = 0.0;
//    
//    // margin between cell elements
//    static CGFloat MARGIN = 10.0;
//    
//    // left and right margin between cell and tableview
//    static CGFloat OUTER_MARGIN = 10.0;
//    
//    // data
//    NSDictionary *rowData = [self dataForIndexPath:indexPath];
//    NSString *title = [rowData objectForKey:@"cell_title"];
//    NSString *subTitle = [rowData objectForKey:@"cell_sub_title"];
//    UIImage *image = [rowData objectForKey:@"cell_image"];
//    
//    // maximum width that a label can be
//    CGFloat labelMaxWidth = (self.view.bounds.size.width - (image.size.width + (MARGIN * 2) + (OUTER_MARGIN * 2)));    
//    
//    CGSize titleSize = [title sizeWithFont:[UIFont tableCellTitleFont] constrainedToSize:CGSizeMake(labelMaxWidth, 999) lineBreakMode:UILineBreakModeWordWrap];
//    height += titleSize.height;
//    
//    if (subTitle.length > 0) {
//        CGSize subTitleSize = [subTitle sizeWithFont:[UIFont tableCellSubTitleFont] constrainedToSize:CGSizeMake(labelMaxWidth, 999) lineBreakMode:UILineBreakModeWordWrap];        
//        height += subTitleSize.height + 10;
//    }
//    
//    // make sure the cell accommodates the image and is no smaller than the default row height
//    height = MAX(MAX(height, self.tableView.rowHeight), image.size.height + (MARGIN * 2));
//    
//    return height;
//}


#pragma mark - Table view delegate


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
}


#pragma mark


- (NSDictionary *)dataForIndexPath:(NSIndexPath *)indexPath {
    return (NSDictionary *)[[[self.sections objectAtIndex:indexPath.section] objectForKey:@"rows"] objectAtIndex:indexPath.row];
}


@end