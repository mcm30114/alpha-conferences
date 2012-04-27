//
//  HomeController.m
//  alpha-conferences
//
//  Created by Erik Erskine on 23/04/2012.
//  Copyright (c) 2012 Brightec Ltd. All rights reserved.
//

#import "HomeController.h"
#import "AlphaCell.h"
#import "ResourceCache.h"
#import "Constants.h"
#import "DataStore.h"
#import "UIColor+Alpha.h"


@interface HomeController () {
    @private
    Conference *conference;
    DTAttributedTextCell *detailsCell;
}

+ (DTAttributedTextCell *)makeAttributedTextCellWithHTML:(NSString *)html;

- (void)refresh;

@end



@implementation HomeController


- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    ((UITableView *)self.view).dataSource = nil;
    ((UITableView *)self.view).delegate = nil;
}


- (id)initForHome {
    if (self = [self initWithConference:[[Conference alloc] init]]) {
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(dataWasUpdated:)
                                                     name:NOTIFICATION_DATA
                                                   object:nil];
    }
    return self;
}


- (id)initWithConference:(Conference *)c {
    if (self = [super initWithNibName:nil bundle:nil]) {
        conference = c;
    }
    return self;
}


- (void)loadView {
    UITableView *tv = [[UITableView alloc] initWithFrame:[[UIScreen mainScreen] applicationFrame] style:UITableViewStylePlain];
    tv.separatorStyle = UITableViewCellSeparatorStyleNone;
    tv.dataSource = self;
    tv.delegate = self;
    self.view = tv;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    [self refresh];
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 3;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.row == 0) {
        Resource *resource = [Resource resourceWithKey:conference.imageKey type:ResourceTypeConferenceImageSmall];
        UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, resource.size.width, resource.size.height)];
        imageView.autoresizingMask = UIViewAutoresizingNone;
        imageView.image = [[ResourceCache defaultResourceCache] imageForResource:resource onComplete:^(UIImage *image) {
            imageView.image = image;
        }];
        [cell.contentView addSubview:imageView];
        return cell;
    }
    else if (indexPath.row == 1) {
        return detailsCell;
    }
    else if (indexPath.row == 2) {
        UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        UIButton *b = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        b.frame = CGRectMake(10, 10, cell.contentView.bounds.size.width - 20, cell.contentView.bounds.size.height - 20);
        b.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        [b setTitle:@"Book online" forState:UIControlStateNormal];
        [b setTitleColor:[UIColor disabledButtonTextColour] forState:UIControlStateDisabled];
        [b addTarget:self action:@selector(bookingButtonTapped:) forControlEvents:UIControlEventTouchUpInside];
        b.enabled = conference.bookingURL.length > 0;
        [cell.contentView addSubview:b];
        return cell;
    }
    else {
        return nil;
    }
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        return [Resource resourceWithKey:conference.imageKey type:ResourceTypeConferenceImageSmall].size.height;
    }
    else if (indexPath.row == 1) {
        return MAX([detailsCell requiredRowHeightInTableView:tableView], 183);
    }
    else if (indexPath.row == 2) {
        return 64;
    }
    else {
        return 44;
    }
}


- (void)dataWasUpdated:(NSNotification *)n {
    conference = [DataStore latestAvailableInstance].conference;
    [self refresh];
}


- (void)refresh {
    detailsCell = [HomeController makeAttributedTextCellWithHTML:conference.text];
    detailsCell.selectionStyle = UITableViewCellSelectionStyleNone;
    [((UITableView *)self.view) reloadData];
}


- (void)bookingButtonTapped:(id)sender {
    if (conference.bookingURL.length > 0) {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:conference.bookingURL]];
    }
}


+ (DTAttributedTextCell *)makeAttributedTextCellWithHTML:(NSString *)html {

    DTAttributedTextCell *cell = [[DTAttributedTextCell alloc] initWithReuseIdentifier:nil accessoryType:UITableViewCellAccessoryNone];
    cell.attributedTextContextView.edgeInsets = UIEdgeInsetsMake(10, 15, 20, 15);
    
    if (html) {
        NSData *data = [[NSString stringWithFormat:@"<div style='font-family: helvetica; font-size: 16px; line-height: 24px;'>%@</div>", html] dataUsingEncoding:NSUTF8StringEncoding];
        NSAttributedString *string = [[NSAttributedString alloc] initWithHTML:data options:nil documentAttributes:nil];
        [cell setAttributedString:string];
    } else {
        [cell setHTMLString:@""];
    }
    
    return cell;
}


@end
