//
//  SpeakerDetailController.m
//  alpha-conferences
//
//  Created by Cameron Cooke on 16/04/2012.
//  Copyright (c) 2012 Brightec Ltd. All rights reserved.
//

#import "SpeakerDetailController.h"
#import "AlphaCell.h"
#import "Model.h"


#define HEADER_SECTION_INDEX 0
#define BIO_SECTION_INDEX 1
#define SESSIONS_SECTION_INDEX 2


@interface SpeakerDetailController ()
@property (nonatomic, unsafe_unretained) UITableView *tableView;
@property (nonatomic, strong) Speaker *speaker;

- (NSString *)speakerName;

@end


@implementation SpeakerDetailController

@synthesize tableView = _tableView;
@synthesize speaker = _speaker;


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
        Speaker *speaker = [[Speaker alloc] init];
        speaker.firstName = @"Andy";
        speaker.lastName = @"Emerton";
        speaker.alias = @"Andy Emerton (alias)";
        speaker.twitterUsername = @"twitter";
        speaker.websiteUrl = @"http://www.brightec.co.uk";
        speaker.biography = @"<p>Lorem ipsum dolor sit amet, <strong>consectetur</strong> adipiscing elit. Vivamus pulvinar felis et ipsum vestibulum viverra. Suspendisse pulvinar diam suscipit mi convallis at scelerisque justo pretium. Cras ultricies pretium metus vel rhoncus. Phasellus posuere scelerisque urna in blandit. Nulla orci nisl, auctor nec tristique vitae, sollicitudin sit amet mi. Proin et erat nisl.</p><p>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Vivamus pulvinar felis et ipsum vestibulum viverra. Suspendisse pulvinar diam suscipit mi convallis at scelerisque justo pretium. Cras ultricies pretium metus vel rhoncus. Phasellus posuere scelerisque urna in blandit. Nulla orci nisl, auctor nec tristique vitae, sollicitudin sit amet mi. Proin et erat nisl.</p>";
        speaker.position = @"Speakers position";
        self.speaker = speaker;
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
    return 3;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
        
    switch (indexPath.section) {
            
        case HEADER_SECTION_INDEX: {
            
            NSString *cellIdentifier = @"HeaderCell";
            
            AlphaCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
            if (cell == nil) {
                cell = [[AlphaCell alloc] initWithStyle:AlphaTableViewCellWithImageRight reuseIdentifier:cellIdentifier];
            }
            
            cell.textLabel.text = [self speakerName];
            cell.textLabel.font = [UIFont tableCellTitleFont];
            cell.textLabel.textColor = [UIColor tableCellTitleColour];            
            cell.textLabel.lineBreakMode = UILineBreakModeWordWrap;
            cell.textLabel.numberOfLines = 0;
            
            cell.detailTextLabel.text = self.speaker.position;
            cell.detailTextLabel.font = [UIFont tableCellSubTitleFont];
            cell.detailTextLabel.textColor = [UIColor tableSubTitleColour];            
            cell.detailTextLabel.lineBreakMode = UILineBreakModeWordWrap;
            cell.detailTextLabel.numberOfLines = 0;            
            
            cell.imageView.image = [UIImage imageNamed:@"cell-image.png"];
            
            return cell;            
            
            break;
        }
            
        case BIO_SECTION_INDEX: {
            
            NSString *cellIdentifier = @"BioCell";
            
            AlphaCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
            if (cell == nil) {
                cell = [[AlphaCell alloc] initWithStyle:AlphaTableViewCellNormal reuseIdentifier:cellIdentifier];
            }
            
            cell.textLabel.text = self.speaker.biography;
            cell.textLabel.font = [UIFont tableCellTitleFont];
            cell.textLabel.textColor = [UIColor tableCellTitleColour];            
            cell.textLabel.lineBreakMode = UILineBreakModeWordWrap;
            cell.textLabel.numberOfLines = 0;
            
            return cell;            
            
            break;
        }
            
        case SESSIONS_SECTION_INDEX:
        default: {
            
            NSString *cellIdentifier = @"SessionCell";
            
            AlphaCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
            if (cell == nil) {
                cell = [[AlphaCell alloc] initWithStyle:AlphaTableViewCellNormal reuseIdentifier:cellIdentifier];
            }
            
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;            
            cell.textLabel.text = [NSString stringWithFormat:@"View sessions with %@", [self speakerName]];
            cell.textLabel.font = [UIFont tableCellTitleFont];
            cell.textLabel.textColor = [UIColor tableCellTitleColour];            
            cell.textLabel.lineBreakMode = UILineBreakModeWordWrap;
            cell.textLabel.numberOfLines = 0;         
            
            return cell; 
            
            break;
        }
    }
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCellAccessoryType accessoryType = UITableViewCellAccessoryNone;
    if (indexPath.section == SESSIONS_SECTION_INDEX) {
        accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    
    AlphaTableViewCellStyle alphaCellStyle = AlphaTableViewCellNormal;
    if (indexPath.section == HEADER_SECTION_INDEX) {
        accessoryType = AlphaTableViewCellWithImageRight;
    }   
    
    NSString *cellTitle;
    NSString *cellSubTitle;
    UIImage *cellImage;
    if (indexPath.section == HEADER_SECTION_INDEX) {
        cellTitle = [self speakerName];
        cellSubTitle = self.speaker.position;
        cellImage = [UIImage imageNamed:@"cell-image.png"];
    }
    else if (indexPath.section == BIO_SECTION_INDEX) {
        cellTitle = self.speaker.biography;        
    }
    else if (indexPath.section == SESSIONS_SECTION_INDEX) {
        cellTitle = [NSString stringWithFormat:@"View sessions with %@", [self speakerName]];
    }
    
    return [AlphaCell heightForRowWithTableView:self.tableView 
                     tableViewCellAccessoryType:accessoryType 
            alphaTableViewCellStyle:alphaCellStyle
                                  textLabelText:cellTitle 
                            detailTextLabelText:cellSubTitle 
                                 imageViewImage:cellImage];
}


#pragma mark - Table view delegate


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
}


#pragma mark


- (NSString *)speakerName {
    if (self.speaker.alias.length > 0) {
        return self.speaker.alias;
    }
    else {
        return [NSString stringWithFormat:@"%@ %@", self.speaker.firstName, self.speaker.lastName];
    }
}


@end