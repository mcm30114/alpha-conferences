//
//  ProgrammeController.m
//  alpha-conferences
//
//  Created by Cameron Cooke on 16/04/2012.
//  Copyright (c) 2012 Brightec Ltd. All rights reserved.
//

#import "ProgrammeController.h"
#import "AlphaCell.h"
#import "Model.h"


@interface ProgrammeController ()
@property (nonatomic, unsafe_unretained) UITableView *tableView;
@property (nonatomic, strong) NSArray *data;
@property (nonatomic, unsafe_unretained) AlphaPager *pager;
@end


@implementation ProgrammeController

@synthesize tableView = _tableView;
@synthesize data = _data;
@synthesize pager = _pager;


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
        // dummy datasource
        NSMutableDictionary *row1section1 = [NSMutableDictionary dictionary];
        [row1section1 setObject:@"session.name sjfkj dsjfh dskjfh djf dskfh sdkfjhd skhkd" forKey:@"session_name"];
        [row1section1 setObject:@"session.start_datetime" forKey:@"session_start_datetime"];
        [row1section1 setObject:@"session.end_datetime" forKey:@"session_end_datetime"];        
        [row1section1 setObject:[UIColor redColor] forKey:@"session_colour"];        
        NSDictionary *section1 = [NSDictionary dictionaryWithObjectsAndKeys:[NSArray arrayWithObject:row1section1], @"rows", @"9:00", @"title", nil];
        
        NSMutableDictionary *row1Section2 = [NSMutableDictionary dictionary];
        [row1Section2 setObject:@"session.name" forKey:@"session_name"];
        [row1Section2 setObject:@"session.start_datetime" forKey:@"session_start_datetime"];
        [row1Section2 setObject:@"session.end_datetime" forKey:@"session_end_datetime"];        
        [row1Section2 setObject:[UIColor blueColor] forKey:@"session_colour"];        
        NSDictionary *section2 = [NSDictionary dictionaryWithObjectsAndKeys:[NSArray arrayWithObject:row1Section2], @"rows", @"10:00", @"title", nil];
        
        NSMutableDictionary *row1Section3 = [NSMutableDictionary dictionary];
        [row1Section3 setObject:@"session.name" forKey:@"session_name"];
        [row1Section3 setObject:@"session.start_datetime" forKey:@"session_start_datetime"];
        [row1Section3 setObject:@"session.end_datetime isodjf doif jdoifj ofi dsiofj dsofij dsofijds foidfj doifj dsoifj doifjd ofijdf  sfudi siuiuf iuhs idfhsdiuf hdsiufh dsfiuhf idsuhf dsiufh dsiufhdsiufhd ifudhfi udshfdisuhf" forKey:@"session_end_datetime"];                
        [row1Section3 setObject:[UIColor greenColor] forKey:@"session_colour"];        
        NSDictionary *section3 = [NSDictionary dictionaryWithObjectsAndKeys:[NSArray arrayWithObject:row1Section3], @"rows", @"11:00", @"title", nil];
        
        NSMutableDictionary *row1Section4 = [NSMutableDictionary dictionary];
        [row1Section4 setObject:@"session.name" forKey:@"session_name"];
        [row1Section4 setObject:@"session.start_datetime" forKey:@"session_start_datetime"];
        [row1Section4 setObject:@"session.end_datetime isodjf doif jdoifj ofi dsiofj dsofij dsofijds foidfj doifj dsoifj doifjd ofijdf  sfudi siuiuf iuhs idfhsdiuf hdsiufh dsfiuhf idsuhf dsiufh dsiufhdsiufhd ifudhfi udshfdisuhf" forKey:@"session_end_datetime"];                
        [row1Section4 setObject:[UIColor greenColor] forKey:@"session_colour"];        
        NSDictionary *section4 = [NSDictionary dictionaryWithObjectsAndKeys:[NSArray arrayWithObject:row1Section4], @"rows", @"11:00", @"title", nil];        
        
        
        NSArray *sections = [NSArray arrayWithObjects:section1, section2, section3, section4, nil];
                
        NSDictionary *dataPage1 = [NSDictionary dictionaryWithObjects:[NSArray arrayWithObjects:sections, [NSDate dateWithTimeIntervalSinceNow:0], nil] forKeys:[NSArray arrayWithObjects:@"sections", @"date", nil]];
        NSDictionary *dataPage2 = [NSDictionary dictionaryWithObjects:[NSArray arrayWithObjects:sections, [NSDate dateWithTimeIntervalSinceNow:86400], nil] forKeys:[NSArray arrayWithObjects:@"sections", @"date", nil]];
        NSDictionary *dataPage3 = [NSDictionary dictionaryWithObjects:[NSArray arrayWithObjects:sections, [NSDate dateWithTimeIntervalSinceNow:172800], nil] forKeys:[NSArray arrayWithObjects:@"sections", @"date", nil]];        
        
        self.data = [NSArray arrayWithObjects:dataPage1, dataPage2, dataPage3, nil];
    }
    
    return self;
}


#pragma mark - View lifecycle


- (void)loadView {
    
    UIView *rootView = [[UIView alloc] initWithFrame:[[UIScreen mainScreen] applicationFrame]];
    rootView.backgroundColor = [UIColor whiteColor];
    self.view = rootView;
    
    NSMutableArray *strings = [NSMutableArray arrayWithCapacity:self.data.count];
    for (int i = 0; i < self.data.count; i++) {
        NSDate *date = (NSDate *)[[self.data objectAtIndex:i] objectForKey:@"date"];
        NSDateFormatter *format = [[NSDateFormatter alloc] init];
        [format setDateFormat:@"d MMMM yyyy"];        
        [strings addObject:[format stringFromDate:date]];
    }
    
    // pager
    AlphaPager *pager = [[AlphaPager alloc] initWithStrings:strings frame:CGRectMake(0, 0, self.view.bounds.size.width, 44)];
    pager.delegate = self;
    pager.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    [self.view addSubview:pager];      
    self.pager = pager;
    
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 44, self.view.bounds.size.width, self.view.bounds.size.height-pager.frame.size.height) style:UITableViewStylePlain];    
    tableView.dataSource = self;
    tableView.delegate = self;
    tableView.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
    [self.view addSubview:tableView];
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
    return [[[self.data objectAtIndex:self.pager.pageIndex] objectForKey:@"sections"] count];
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [[[[[self.data objectAtIndex:self.pager.pageIndex] objectForKey:@"sections"] objectAtIndex:section] objectForKey:@"rows"] count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellIdentifier = @"Cell";
    
    AlphaCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        cell = [[AlphaCell alloc] initWithStyle:AlphaTableViewCellWithColourBar reuseIdentifier:cellIdentifier];
    }
    
    NSDictionary *rowData = [[[[[self.data objectAtIndex:self.pager.pageIndex] objectForKey:@"sections"] objectAtIndex:indexPath.section] objectForKey:@"rows"] objectAtIndex:indexPath.row];
    
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.barColour = (UIColor *)[rowData objectForKey:@"session_colour"];
    
    cell.textLabel.text = [rowData objectForKey:@"session_name"];
    cell.textLabel.font = [UIFont tableCellTitleFont];
    cell.textLabel.textColor = [UIColor tableCellTitleColour];
    cell.textLabel.lineBreakMode = UILineBreakModeWordWrap;
    cell.textLabel.numberOfLines = 0;
    
    cell.detailTextLabel.text = [NSString stringWithFormat:@"%@, %@", [rowData objectForKey:@"session_start_datetime"], [rowData objectForKey:@"session_end_datetime"]];
    cell.detailTextLabel.font = [UIFont tableCellSubTitleFont];
    cell.detailTextLabel.textColor = [UIColor tableSubTitleColour];
    cell.detailTextLabel.lineBreakMode = UILineBreakModeWordWrap;
    cell.detailTextLabel.numberOfLines = 0;    
    
    return cell;
}


- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return [[[[self.data objectAtIndex:self.pager.pageIndex] objectForKey:@"sections"] objectAtIndex:section] objectForKey:@"title"];    
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSDictionary *rowData = [[[[[self.data objectAtIndex:self.pager.pageIndex] objectForKey:@"sections"] objectAtIndex:indexPath.section] objectForKey:@"rows"] objectAtIndex:indexPath.row];
    
    return [AlphaCell heightForRowWithTableView:tableView tableViewCellAccessoryType:UITableViewCellAccessoryDisclosureIndicator 
                        alphaTableViewCellStyle:AlphaTableViewCellWithColourBar 
                                  textLabelText:[rowData objectForKey:@"session_name"] 
                            detailTextLabelText:[NSString stringWithFormat:@"%@, %@", [rowData objectForKey:@"session_start_datetime"], [rowData objectForKey:@"session_end_datetime"]] 
                                 imageViewImage:nil];    
}


#pragma mark - Table view delegate


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
}


#pragma mark


- (void)alphaPager:(AlphaPager *)alphaPager didChangePageWithIndex:(NSInteger)index {
    [self.tableView reloadData];
}


@end