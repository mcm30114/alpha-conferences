//
//  TemplateViewController.m
//  alpha-conferences
//
//  Created by Cameron Cooke on 16/04/2012.
//  Copyright (c) 2012 Brightec Ltd. All rights reserved.
//

#import "TemplateViewController.h"


@interface TemplateViewController ()

@property (nonatomic, unsafe_unretained) UITableView *tableView;
@property (nonatomic, strong) NSDictionary *data;

@end


@implementation TemplateTableViewController

@synthesize tableView = _tableView;
@synthesize data = _data;


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
        // dummy datasource
        NSMutableDictionary *row1section1 = [NSMutableDictionary dictionary];
        [row1section1 setObject:@"" forKey:@"cell_title"];
        [row1section1 setObject:@"" forKey:@"cell_sub_title"];
        [row1section1 setObject:[UIImage imageNamed:@""] forKey:@"cell_image"];        
        NSDictionary *section1 = [NSDictionary dictionaryWithObjectsAndKeys:[NSArray arrayWithObject:row1section1], @"rows", @"A", @"title", nil];        

        NSMutableDictionary *row1Section2 = [NSMutableDictionary dictionary];
        [row1Section2 setObject:@"" forKey:@"cell_title"];
        [row1Section2 setObject:@"" forKey:@"cell_sub_title"];
        [row1Section2 setObject:[UIImage imageNamed:@""] forKey:@"cell_image"];           
        NSDictionary *section2 = [NSDictionary dictionaryWithObjectsAndKeys:[NSArray arrayWithObject:row1Section2], @"rows", @"B", @"title", nil];        
        
        NSMutableDictionary *row1Section3 = [NSMutableDictionary dictionary];
        [row1Section3 setObject:@"" forKey:@"cell_title"];
        [row1Section3 setObject:@"" forKey:@"cell_sub_title"];
        [row1Section3 setObject:[UIImage imageNamed:@""] forKey:@"cell_image"];  
        NSDictionary *section3 = [NSDictionary dictionaryWithObjectsAndKeys:[NSArray arrayWithObject:row1Section3], @"rows", @"C", @"title", nil];        
        
        NSMutableDictionary *row1Section4 = [NSMutableDictionary dictionary];
        [row1Section4 setObject:@"" forKey:@"cell_title"];
        [row1Section4 setObject:@"" forKey:@"cell_sub_title"];
        [row1Section4 setObject:[UIImage imageNamed:@""] forKey:@"cell_image"];         
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
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIdentifier];
    }
    
    NSDictionary *rowData = [[[[self.data objectForKey:@"sections"] objectAtIndex:indexPath.section] objectForKey:@"rows"] objectAtIndex:indexPath.row];
    
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    cell.textLabel.text = [rowData objectForKey:@"cell_title"];
    cell.textLabel.font = [UIFont tableCellTitleFont];
    cell.textLabel.textColor = [UIColor tableCellTitleColour];
    
    cell.detailTextLabel.text = [rowData objectForKey:@"cell_sub_title"];
    cell.detailTextLabel.font = [UIFont tableCellSubTitleFont];
    cell.detailTextLabel.textColor = [UIColor tableSubTitleColour];
    
    cell.imageView.image = [rowData objectForKey:@"cell_image"];
    
    return cell;
}


- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return [[[self.data objectForKey:@"sections"] objectAtIndex:section] objectForKey:@"title"];    
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    CGFloat height = 0.0;
    
    NSDictionary *rowData = [[[[self.data objectForKey:@"sections"] objectAtIndex:indexPath.section] objectForKey:@"rows"] objectAtIndex:indexPath.row];
    NSString *title = (NSString *)[rowData objectForKey:@"cell_title"];
    NSString *subTitle = (NSString *)[rowData objectForKey:@"cell_sub_title"];
    
    CGSize titleSize = [title sizeWithFont:[UIFont tableCellTitleFont] constrainedToSize:CGSizeMake(280, 999) lineBreakMode:UILineBreakModeTailTruncation];
    height += titleSize.height;
    
    if (subTitle.length > 0) {
        CGSize subTitleSize = [subTitle sizeWithFont:[UIFont tableCellSubTitleFont] constrainedToSize:CGSizeMake(280, 999) lineBreakMode:UILineBreakModeWordWrap];        
        height += subTitleSize.height + 10;
    }
    
    return MAX(height, self.tableView.rowHeight);
}


#pragma mark - Table view delegate


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
}


@end