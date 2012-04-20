//
//  AppDelegate.m
//  alpha-conferences
//
//  Created by Cameron Cooke on 16/04/2012.
//  Copyright (c) 2012 Brightec Ltd. All rights reserved.
//

#import "AppDelegate.h"
#import "Home.h"
#import "Programme.h"
#import "ProgrammeController.h"
#import "SpeakerList.h"
#import "SpeakersController.h"
#import "StandardController.h"
#import "VenueListModel.h"
#import "FAQList.h"
#import "AlertList.h"
#import "OtherEvents.h"
#import "Donate.h"
#import "SpecialOfferList.h"
#import "DataStore.h"


@implementation AppDelegate

@synthesize window = _window;
@synthesize tabBarController = _tabBarController;


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
    NSMutableArray *tabControllers = [NSMutableArray  array];
    
//    // home
//    StandardController *homeController = [[StandardController alloc] initWithStyle:UITableViewStylePlain pager:NO];
//    homeController.model = [[Home alloc] init];
//    homeController.title = @"Home";
//    UINavigationController *homeNavController = [[UINavigationController alloc] initWithRootViewController:homeController];
//    homeNavController.navigationBar.tintColor = [UIColor navigationBarTintColour];
//    [tabControllers addObject:homeNavController]; 
//    
//    // speakers
//    StandardController *speakersController = [[StandardController alloc] initWithStyle:UITableViewStylePlain pager:NO];
//    speakersController.model = [[SpeakerList alloc] init];
//    speakersController.title = @"Speakers";
//    UINavigationController *speakersNavController = [[UINavigationController alloc] initWithRootViewController:speakersController];
//    speakersNavController.navigationBar.tintColor = [UIColor navigationBarTintColour];
//    [tabControllers addObject:speakersNavController]; 

    // programme
    StandardController *programmeController = [[StandardController alloc] initWithStyle:UITableViewStylePlain pager:YES];
    programmeController.model = [[Programme alloc] init];
    programmeController.title = @"Programme";
    UINavigationController *programmeNavController = [[UINavigationController alloc] initWithRootViewController:programmeController];
    programmeNavController.navigationBar.tintColor = [UIColor navigationBarTintColour];
    [tabControllers addObject:programmeNavController];
    
    // programme (old)
//    ProgrammeController *programmeController = [[ProgrammeController alloc] init];
//    programmeController.title = @"Programme";
//    UINavigationController *programmeNavController = [[UINavigationController alloc] initWithRootViewController:programmeController];
//    programmeNavController.navigationBar.tintColor = [UIColor navigationBarTintColour];
//    [tabControllers addObject:programmeNavController];
    
    // speakers (old)
//    SpeakersController *speakersController = [[SpeakersController alloc] init];
//    speakersController.title = @"Speakers";
//    UINavigationController *speakersNavController = [[UINavigationController alloc] initWithRootViewController:speakersController];
//    speakersNavController.navigationBar.tintColor = [UIColor navigationBarTintColour];
//    [tabControllers addObject:speakersNavController]; 
    
    // maps
    StandardController *mapsController = [[StandardController alloc] initWithStyle:UITableViewStylePlain pager:NO];
    mapsController.model = [[VenueListModel alloc] init];
    mapsController.title = @"Maps";
    UINavigationController *mapsNavController = [[UINavigationController alloc] initWithRootViewController:mapsController];
    mapsNavController.navigationBar.tintColor = [UIColor navigationBarTintColour];
    [tabControllers addObject:mapsNavController];

    // donate
    StandardController *donateController = [[StandardController alloc] initWithStyle:UITableViewStyleGrouped pager:NO];
    donateController.model = [[Donate alloc] init];
    donateController.title = @"Donate";
    UINavigationController *donateNavController = [[UINavigationController alloc] initWithRootViewController:donateController];
    donateNavController.navigationBar.tintColor = [UIColor navigationBarTintColour];
    [tabControllers addObject:donateNavController];
    
    // alerts
    StandardController *alertsController = [[StandardController alloc] initWithStyle:UITableViewStylePlain pager:NO];
    alertsController.model = [[AlertList alloc] init];
    alertsController.title = @"Alerts";
    UINavigationController *alertsNavController = [[UINavigationController alloc] initWithRootViewController:alertsController];
    alertsNavController.navigationBar.tintColor = [UIColor navigationBarTintColour];
    [tabControllers addObject:alertsNavController];
    
    // faqs
    StandardController *faqsController = [[StandardController alloc] initWithStyle:UITableViewStylePlain pager:NO];
    faqsController.model = [[FAQList alloc] init];
    faqsController.title = @"FAQs";
    UINavigationController *faqsNavController = [[UINavigationController alloc] initWithRootViewController:faqsController];
    faqsNavController.navigationBar.tintColor = [UIColor navigationBarTintColour];
    [tabControllers addObject:faqsNavController];
    
    // other events
    StandardController *otherEventsController = [[StandardController alloc] initWithStyle:UITableViewStylePlain pager:NO];
    otherEventsController.title = @"Other events";
    otherEventsController.model = [[OtherEvents alloc] init];
    UINavigationController *otherEventsNavController = [[UINavigationController alloc] initWithRootViewController:otherEventsController];
    otherEventsNavController.navigationBar.tintColor = [UIColor navigationBarTintColour];
    [tabControllers addObject:otherEventsNavController];
    
    // special offers
    StandardController *offersController = [[StandardController alloc] initWithStyle:UITableViewStylePlain pager:NO];
    offersController.title = @"Special offers";
    offersController.model = [[SpecialOfferList alloc] init];
    UINavigationController *offersNavController = [[UINavigationController alloc] initWithRootViewController:offersController];
    offersNavController.navigationBar.tintColor = [UIColor navigationBarTintColour];
    [tabControllers addObject:offersNavController];
    
    UITabBarController *tabController = [[UITabBarController alloc] init];
    tabController.moreNavigationController.navigationBar.tintColor = [UIColor navigationBarTintColour];
    tabController.viewControllers = tabControllers;
    self.tabBarController = tabController;
    
    self.window.rootViewController = self.tabBarController;
    [self.window makeKeyAndVisible];
    [DataStore refresh];
    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end