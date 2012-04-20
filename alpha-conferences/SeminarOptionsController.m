//
//  SeminarOptionsController.m
//  alpha-conferences
//
//  Created by Cameron Cooke on 18/04/2012.
//  Copyright (c) 2012 Brightec Ltd. All rights reserved.
//

#import "SeminarOptionsController.h"
#import "AlphaCell.h"
#import "Model.h"


@interface SeminarOptionsController ()
@property (nonatomic, unsafe_unretained) UITableView *tableView;
@property (nonatomic, strong) NSArray *sections;
@end


@implementation SeminarOptionsController

@synthesize tableView = _tableView;
@synthesize sections = _sections;


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
        // dummy datasource
        NSMutableDictionary *row1section1 = [NSMutableDictionary dictionary];
        [row1section1 setObject:@"session_name" forKey:@"title"];
        [row1section1 setObject:@"The quick brown fox jumped over the lazy dog." forKey:@"sub_title"];
        
        NSMutableDictionary *row2Section1 = [NSMutableDictionary dictionary];
        [row2Section1 setObject:@"session_name" forKey:@"title"];
        [row2Section1 setObject:@"The quick brown fox jumped over the lazy dog." forKey:@"sub_title"];

        NSDictionary *section1 = [NSDictionary dictionaryWithObjectsAndKeys:[NSArray arrayWithObjects:row1section1, row2Section1, nil], @"rows", @"session.stream_name", @"title", [UIColor greenColor], @"colour", nil];        
        
        NSMutableDictionary *row1Section2 = [NSMutableDictionary dictionary];
        [row1Section2 setObject:@"session_name" forKey:@"title"];
        [row1Section2 setObject:@"The quick brown fox jumped over the lazy dog." forKey:@"sub_title"];
        
        NSDictionary *section2 = [NSDictionary dictionaryWithObjectsAndKeys:[NSArray arrayWithObject:row1Section2], @"rows", @"session.stream_name", @"title", [UIColor orangeColor], @"colour", nil];
        
        self.sections = [NSArray arrayWithObjects:section1, section2, nil];
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
    return [self.sections count];
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [[[self.sections objectAtIndex:section] objectForKey:@"rows"] count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellIdentifier = @"Cell";
    
    AlphaCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        cell = [[AlphaCell alloc] initWithStyle:AlphaTableViewCellWithColourBar reuseIdentifier:cellIdentifier];
    }
    
    NSDictionary *section = [self.sections objectAtIndex:indexPath.section];
    NSDictionary *row = [[section objectForKey:@"rows"] objectAtIndex:indexPath.row];
    
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.barColour = (UIColor *)[section objectForKey:@"colour"];
    
    cell.textLabel.text = [row objectForKey:@"title"];
    cell.textLabel.font = [UIFont tableCellTitleFont];
    cell.textLabel.textColor = [UIColor tableCellTitleColour];
    cell.textLabel.lineBreakMode = UILineBreakModeWordWrap;
    cell.textLabel.numberOfLines = 0;
    
    cell.detailTextLabel.text = [row objectForKey:@"sub_title"];
    cell.detailTextLabel.font = [UIFont tableCellSubTitleFont];
    cell.detailTextLabel.textColor = [UIColor tableSubTitleColour];
    cell.detailTextLabel.lineBreakMode = UILineBreakModeWordWrap;
    cell.detailTextLabel.numberOfLines = 0;    
    
    return cell;
}


- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return [[self.sections objectAtIndex:section] objectForKey:@"title"];    
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSDictionary *rowData = [[[self.sections objectAtIndex:indexPath.section] objectForKey:@"rows"] objectAtIndex:indexPath.row];
    
    return [AlphaCell heightForRowWithTableView:tableView tableViewCellAccessoryType:UITableViewCellAccessoryDisclosureIndicator 
                        alphaTableViewCellStyle:AlphaTableViewCellWithColourBar 
                                  textLabelText:[rowData objectForKey:@"title"] 
                            detailTextLabelText:[rowData objectForKey:@"sub_title"] 
                                  imageViewSize:CGSizeZero];    
}


#pragma mark - Table view delegate


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
}


@end