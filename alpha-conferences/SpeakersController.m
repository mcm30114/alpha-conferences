//
//  SpeakersController.m
//  alpha-conferences
//
//  Created by Cameron Cooke on 17/04/2012.
//  Copyright (c) 2012 Brightec Ltd. All rights reserved.
//

#import "SpeakersController.h"
#import "SpeakerDetailController.h"
#import "AlphaCell.h"


@interface SpeakersController ()

@property (nonatomic, unsafe_unretained) UITableView *tableView;
@property (nonatomic, strong) NSDictionary *data;

@end


@implementation SpeakersController

@synthesize tableView = _tableView;
@synthesize data = _data;


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
        // dummy datasource
        NSMutableDictionary *row1section1 = [NSMutableDictionary dictionary];
        [row1section1 setObject:@"speakers.first_name .last_name" forKey:@"cell_title"];
        [row1section1 setObject:@"speakers.position" forKey:@"cell_sub_title"];
        [row1section1 setObject:[UIImage imageNamed:@"cell-image.png"] forKey:@"cell_image"];        
        NSDictionary *section1 = [NSDictionary dictionaryWithObjectsAndKeys:[NSArray arrayWithObject:row1section1], @"rows", @"A", @"title", nil];        
        
        NSMutableDictionary *row1Section2 = [NSMutableDictionary dictionary];
        [row1Section2 setObject:@"speakers.alias (prefer if set)" forKey:@"cell_title"];
        [row1Section2 setObject:@"speakers.position" forKey:@"cell_sub_title"];
        [row1Section2 setObject:[UIImage imageNamed:@"cell-image.png"] forKey:@"cell_image"];           
        NSDictionary *section2 = [NSDictionary dictionaryWithObjectsAndKeys:[NSArray arrayWithObject:row1Section2], @"rows", @"B", @"title", nil];        
        
        NSMutableDictionary *row1Section3 = [NSMutableDictionary dictionary];
        [row1Section3 setObject:@"speakers.first_name .last_name" forKey:@"cell_title"];
        [row1Section3 setObject:@"speakers.position" forKey:@"cell_sub_title"];
        [row1Section3 setObject:[UIImage imageNamed:@"cell-image.png"] forKey:@"cell_image"];  
        NSDictionary *section3 = [NSDictionary dictionaryWithObjectsAndKeys:[NSArray arrayWithObject:row1Section3], @"rows", @"C", @"title", nil];        
        
        NSMutableDictionary *row1Section4 = [NSMutableDictionary dictionary];
        [row1Section4 setObject:@"speakers.first_name .last_name" forKey:@"cell_title"];
        [row1Section4 setObject:@"speakers.position" forKey:@"cell_sub_title"];
        [row1Section4 setObject:[UIImage imageNamed:@"cell-image.png"] forKey:@"cell_image"];         
        NSDictionary *section4 = [NSDictionary dictionaryWithObjectsAndKeys:[NSArray arrayWithObject:row1Section4], @"rows", @"D", @"title", nil];        
        
        NSArray *sections = [NSArray arrayWithObjects:section1, section2, section3, section4, nil];
        self.data = [NSDictionary dictionaryWithObjects:[NSArray arrayWithObjects:sections, nil] forKeys:[NSArray arrayWithObjects:@"sections", nil]];
    }
    
    return self;
}


#pragma mark - View lifecycle


- (void)loadView {
    
    UITableView *tableView = [[UITableView alloc] initWithFrame:[[UIScreen mainScreen] applicationFrame] style:UITableViewStylePlain];    
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
    return [[self.data objectForKey:@"sections"] count];
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [[[[self.data objectForKey:@"sections"] objectAtIndex:section] objectForKey:@"rows"] count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellIdentifier = @"Cell";
    
    AlphaCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        cell = [[AlphaCell alloc] initWithStyle:AlphaTableViewCellWithImageLeft reuseIdentifier:cellIdentifier];
    }
    
    NSDictionary *rowData = [[[[self.data objectForKey:@"sections"] objectAtIndex:indexPath.section] objectForKey:@"rows"] objectAtIndex:indexPath.row];
    
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
    cell.detailTextLabel.numberOfLines = 0;    
    
    cell.imageView.image = [rowData objectForKey:@"cell_image"];
    
    return cell;
}


- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return [[[self.data objectForKey:@"sections"] objectAtIndex:section] objectForKey:@"title"];    
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSDictionary *rowData = [[[[self.data objectForKey:@"sections"] objectAtIndex:indexPath.section] objectForKey:@"rows"] objectAtIndex:indexPath.row];    

    return [AlphaCell heightForRowWithTableView:self.tableView 
                     tableViewCellAccessoryType:UITableViewCellAccessoryDisclosureIndicator 
                        alphaTableViewCellStyle:AlphaTableViewCellWithImageLeft
                                  textLabelText:[rowData objectForKey:@"cell_title"] 
                            detailTextLabelText:[rowData objectForKey:@"cell_sub_title"] 
                                  imageViewSize:((UIImage *)[rowData objectForKey:@"cell_image"]).size];    
}


- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView {
    return [NSArray arrayWithObjects:@"A", @"B", @"C", @"D", @"E", @"F", @"G", @"H", @"I", @"J", @"K", @"L", @"M", @"N", @"O", @"P", @"Q", @"R", @"S", @"T", @"U", @"V", @"W", @"X", @"Y", @"Z", nil];
}


#pragma mark - Table view delegate


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    SpeakerDetailController *controller = [[SpeakerDetailController alloc] init];
    controller.title = @"alias or name";
    controller.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:controller animated:YES];
}


@end