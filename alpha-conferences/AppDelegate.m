//
//  AppDelegate.m
//  alpha-conferences
//
//  Created by Cameron Cooke on 16/04/2012.
//  Copyright (c) 2012 Brightec Ltd. All rights reserved.
//

#import "AppDelegate.h"
#import "Programme.h"
#import "SpeakerList.h"
#import "StandardController.h"
#import "VenueListModel.h"
#import "FAQList.h"
#import "AlertList.h"
#import "OtherEvents.h"
#import "Donate.h"
#import "SpecialOfferList.h"
#import "DataStore.h"
#import "Constants.h"
#import "HomeController.h"
#import "TwitterFeed.h"
#import "TwitterController.h"
#import "NSDictionary+Alpha.h"

#define kTabOrder @"TAB_ORDER"
#define kTabHome 0
#define kTabSpeakers 1
#define kTabProgramme 2
#define kTabMaps 3
#define kTabTwitter 4
#define kTabDonate 5
#define kTabAlerts 6
#define kTabFAQs 7
#define kTabOtherEvents 8
#define kTabSpecialOffers 9


@implementation AppDelegate

@synthesize window = _window;
@synthesize tabBarController = _tabBarController;
@synthesize refreshTimer = _refreshTimer;
@synthesize alertViewController = _alertViewController;


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    NSTimeZone.defaultTimeZone = [NSTimeZone timeZoneWithAbbreviation:@"UTC"];
    
    NSMutableDictionary *tabControllers = [NSMutableDictionary dictionary];

    // home
    HomeController *homeController = [[HomeController alloc] initForHome];
    homeController.title = CONFERENCE_TITLE;
    UINavigationController *homeNavController = [[UINavigationController alloc] initWithRootViewController:homeController];
    homeNavController.tabBarItem.title = @"Home";
    homeNavController.tabBarItem.tag = kTabHome;
    homeNavController.tabBarItem.image = [UIImage imageNamed:@"home.png"];
    homeNavController.navigationBar.tintColor = [UIColor navigationBarTintColour];
    [tabControllers setObject:homeNavController forIntegerKey:kTabHome];
    
    // speakers
    StandardController *speakersController = [[StandardController alloc] initWithStyle:UITableViewStylePlain pager:NO];
    speakersController.model = [[SpeakerList alloc] init];
    speakersController.title = @"Speakers";
    speakersController.tabBarItem.tag = kTabSpeakers;
    speakersController.tabBarItem.image = [UIImage imageNamed:@"speakers.png"];
    UINavigationController *speakersNavController = [[UINavigationController alloc] initWithRootViewController:speakersController];
    speakersNavController.navigationBar.tintColor = [UIColor navigationBarTintColour];
    [tabControllers setObject:speakersNavController forIntegerKey:kTabSpeakers];

    // programme
    StandardController *programmeController = [[StandardController alloc] initWithStyle:UITableViewStylePlain pager:YES];
    programmeController.model = [[Programme alloc] init];
    programmeController.title = @"Programme";
    programmeController.tabBarItem.tag = kTabProgramme;
    programmeController.tabBarItem.image = [UIImage imageNamed:@"programme.png"];
    UINavigationController *programmeNavController = [[UINavigationController alloc] initWithRootViewController:programmeController];
    programmeNavController.navigationBar.tintColor = [UIColor navigationBarTintColour];
    [tabControllers setObject:programmeNavController forIntegerKey:kTabProgramme];
    
    // maps
    StandardController *mapsController = [[StandardController alloc] initWithStyle:UITableViewStylePlain pager:NO];
    mapsController.model = [[VenueListModel alloc] init];
    mapsController.title = @"Maps";
    mapsController.tabBarItem.tag = kTabMaps;
    mapsController.tabBarItem.image = [UIImage imageNamed:@"maps.png"];
    UINavigationController *mapsNavController = [[UINavigationController alloc] initWithRootViewController:mapsController];
    mapsNavController.navigationBar.tintColor = [UIColor navigationBarTintColour];
    [tabControllers setObject:mapsNavController forIntegerKey:kTabMaps];

    // twitter
    TwitterController *twitterController = [[TwitterController alloc] initWithNibName:nil bundle:nil];
    twitterController.title = @"Twitter Stream";
    twitterController.tabBarItem.tag = kTabTwitter;
    twitterController.tabBarItem.image = [UIImage imageNamed:@"twitter.png"];
    UINavigationController *twitterNavController = [[UINavigationController alloc] initWithRootViewController:twitterController];
    twitterNavController.navigationBar.tintColor = [UIColor navigationBarTintColour];
    [tabControllers setObject:twitterNavController forIntegerKey:kTabTwitter];
    
    // donate
    StandardController *donateController = [[StandardController alloc] initWithStyle:UITableViewStyleGrouped pager:NO];
    donateController.model = [[Donate alloc] init];
    donateController.title = @"Donate";
    donateController.tabBarItem.tag = kTabDonate;
    donateController.tabBarItem.image = [UIImage imageNamed:@"donate.png"];
    UINavigationController *donateNavController = [[UINavigationController alloc] initWithRootViewController:donateController];
    donateNavController.navigationBar.tintColor = [UIColor navigationBarTintColour];
    [tabControllers setObject:donateNavController forIntegerKey:kTabDonate];
    
    // alerts
    StandardController *alertsController = [[StandardController alloc] initWithStyle:UITableViewStylePlain pager:NO];
    alertsController.model = [[AlertList alloc] init];
    alertsController.title = @"Alerts";
    alertsController.tabBarItem.tag = kTabAlerts;
    alertsController.tabBarItem.image = [UIImage imageNamed:@"alerts.png"];
    UINavigationController *alertsNavController = [[UINavigationController alloc] initWithRootViewController:alertsController];
    alertsNavController.navigationBar.tintColor = [UIColor navigationBarTintColour];
    [tabControllers setObject:alertsNavController forIntegerKey:kTabAlerts];
    
    // faqs
    StandardController *faqsController = [[StandardController alloc] initWithStyle:UITableViewStylePlain pager:NO];
    faqsController.model = [[FAQList alloc] init];
    faqsController.title = @"FAQs";
    faqsController.tabBarItem.tag = kTabFAQs;
    faqsController.tabBarItem.image = [UIImage imageNamed:@"faqs.png"];
    UINavigationController *faqsNavController = [[UINavigationController alloc] initWithRootViewController:faqsController];
    faqsNavController.navigationBar.tintColor = [UIColor navigationBarTintColour];
    [tabControllers setObject:faqsNavController forIntegerKey:kTabFAQs];
    
    // other events
    StandardController *otherEventsController = [[StandardController alloc] initWithStyle:UITableViewStylePlain pager:NO];
    otherEventsController.title = @"Other events";
    otherEventsController.tabBarItem.tag = kTabOtherEvents;
    otherEventsController.tabBarItem.image = [UIImage imageNamed:@"other-events.png"];
    otherEventsController.model = [[OtherEvents alloc] init];
    UINavigationController *otherEventsNavController = [[UINavigationController alloc] initWithRootViewController:otherEventsController];
    otherEventsNavController.navigationBar.tintColor = [UIColor navigationBarTintColour];
    [tabControllers setObject:otherEventsNavController forIntegerKey:kTabOtherEvents];
    
    // special offers
    StandardController *offersController = [[StandardController alloc] initWithStyle:UITableViewStylePlain pager:NO];
    offersController.title = @"Special offers";
    offersController.tabBarItem.tag = kTabSpecialOffers;
    offersController.tabBarItem.image = [UIImage imageNamed:@"special-offers.png"];
    offersController.model = [[SpecialOfferList alloc] init];
    UINavigationController *offersNavController = [[UINavigationController alloc] initWithRootViewController:offersController];
    offersNavController.navigationBar.tintColor = [UIColor navigationBarTintColour];
    [tabControllers setObject:offersNavController forIntegerKey:kTabSpecialOffers];
    
    // how are tabs sorted?
    NSArray *tabOrder = [[NSUserDefaults standardUserDefaults] objectForKey:kTabOrder];
    if (tabOrder == nil) {
        tabOrder = [NSArray arrayWithObjects: [NSNumber numberWithInt:kTabHome], [NSNumber numberWithInt:kTabSpeakers], [NSNumber numberWithInt:kTabProgramme], [NSNumber numberWithInt:kTabMaps], [NSNumber numberWithInt:kTabTwitter], [NSNumber numberWithInt:kTabDonate], [NSNumber numberWithInt:kTabAlerts], [NSNumber numberWithInt:kTabFAQs], [NSNumber numberWithInt:kTabOtherEvents], [NSNumber numberWithInt:kTabSpecialOffers], nil];
    }
    NSMutableArray *tabViewControllers = [NSMutableArray arrayWithCapacity:tabOrder.count];
    for (NSNumber *tag in tabOrder) {
        [tabViewControllers addObject:[tabControllers objectForKey:tag]];
    }
    
    UITabBarController *tabController = [[UITabBarController alloc] init];
    tabController.moreNavigationController.navigationBar.tintColor = [UIColor navigationBarTintColour];
    tabController.viewControllers = tabViewControllers;
    self.tabBarController = tabController;
    self.tabBarController.delegate = self;

    [[UIApplication sharedApplication] registerForRemoteNotificationTypes:(UIRemoteNotificationTypeAlert | UIRemoteNotificationTypeBadge | UIRemoteNotificationTypeSound)];
    application.applicationIconBadgeNumber = 0;

    self.window.rootViewController = self.tabBarController;
    [self.window makeKeyAndVisible];
    return YES;
}

- (void)tabBarController:(UITabBarController *)tabBarController willBeginCustomizingViewControllers:(NSArray *)viewControllers {
  id modalViewCtrl = [[[tabBarController view] subviews] objectAtIndex:1];  
  if([modalViewCtrl isKindOfClass:NSClassFromString(@"UITabBarCustomizeView")] == YES)
    ((UINavigationBar*)[[modalViewCtrl subviews] objectAtIndex:0]).tintColor = [UIColor navigationBarTintColour];
}


- (void)tabBarController:(UITabBarController *)tabBarController didEndCustomizingViewControllers:(NSArray *)viewControllers changed:(BOOL)changed {
    if (changed) {
        NSMutableArray *tabOrder = [NSMutableArray array];
        for (UIViewController *c in viewControllers) {
            [tabOrder addObject:[NSNumber numberWithInt:c.tabBarItem.tag]];
        }
        [[NSUserDefaults standardUserDefaults] setObject:tabOrder forKey:kTabOrder];
    }
}


- (void)applicationWillResignActive:(UIApplication *)application {
    [self.refreshTimer invalidate];
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    self.refreshTimer = [NSTimer timerWithTimeInterval:TWITTER_REFRESH_INTERVAL target:[TwitterFeed class] selector:@selector(refresh) userInfo:nil repeats:YES];
    [[NSRunLoop currentRunLoop] addTimer:self.refreshTimer forMode:NSDefaultRunLoopMode];
    [DataStore refresh];
    [TwitterFeed refresh];
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)devToken
{
#if !TARGET_IPHONE_SIMULATOR
  
	NSString *appName = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleDisplayName"];
	NSString *appVersion = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleVersion"];
	NSUInteger rntypes = [[UIApplication sharedApplication] enabledRemoteNotificationTypes];
  
	NSString *pushBadge = @"disabled";
	NSString *pushAlert = @"disabled";
	NSString *pushSound = @"disabled";
  
	if(rntypes == UIRemoteNotificationTypeBadge){
		pushBadge = @"enabled";
	}
	else if(rntypes == UIRemoteNotificationTypeAlert){
		pushAlert = @"enabled";
	}
	else if(rntypes == UIRemoteNotificationTypeSound){
		pushSound = @"enabled";
	}
	else if(rntypes == ( UIRemoteNotificationTypeBadge | UIRemoteNotificationTypeAlert)){
		pushBadge = @"enabled";
		pushAlert = @"enabled";
	}
	else if(rntypes == ( UIRemoteNotificationTypeBadge | UIRemoteNotificationTypeSound)){
		pushBadge = @"enabled";
		pushSound = @"enabled";
	}
	else if(rntypes == ( UIRemoteNotificationTypeAlert | UIRemoteNotificationTypeSound)){
		pushAlert = @"enabled";
		pushSound = @"enabled";
	}
	else if(rntypes == ( UIRemoteNotificationTypeBadge | UIRemoteNotificationTypeAlert | UIRemoteNotificationTypeSound)){
		pushBadge = @"enabled";
		pushAlert = @"enabled";
		pushSound = @"enabled";
	}
  
	UIDevice *dev = [UIDevice currentDevice];
  NSString *deviceName = dev.name;
	NSString *deviceModel = dev.model;
	NSString *deviceSystemVersion = dev.systemVersion;
  
	NSString *deviceToken = [[[[devToken description]
                             stringByReplacingOccurrencesOfString:@"<"withString:@""]
                            stringByReplacingOccurrencesOfString:@">" withString:@""]
                           stringByReplacingOccurrencesOfString: @" " withString: @""];
  
	NSString *host = @"apns.alpha.org";
	NSString *urlString = [@"/?"stringByAppendingString:@"task=register"];
  
	urlString = [urlString stringByAppendingString:@"&appname="];
	urlString = [urlString stringByAppendingString:appName];
	urlString = [urlString stringByAppendingString:@"&appversion="];
	urlString = [urlString stringByAppendingString:appVersion];
	urlString = [urlString stringByAppendingString:@"&devicetoken="];
	urlString = [urlString stringByAppendingString:deviceToken];
	urlString = [urlString stringByAppendingString:@"&devicename="];
	urlString = [urlString stringByAppendingString:deviceName];
	urlString = [urlString stringByAppendingString:@"&devicemodel="];
	urlString = [urlString stringByAppendingString:deviceModel];
	urlString = [urlString stringByAppendingString:@"&deviceversion="];
	urlString = [urlString stringByAppendingString:deviceSystemVersion];
	urlString = [urlString stringByAppendingString:@"&pushbadge="];
	urlString = [urlString stringByAppendingString:pushBadge];
	urlString = [urlString stringByAppendingString:@"&pushalert="];
	urlString = [urlString stringByAppendingString:pushAlert];
	urlString = [urlString stringByAppendingString:@"&pushsound="];
	urlString = [urlString stringByAppendingString:pushSound];
  
	NSURL *url = [[NSURL alloc] initWithScheme:@"http" host:host path:urlString];
  NSURLRequest *request = [[NSURLRequest alloc] initWithURL:url];
	[NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
  
#endif
}

/**
 * Failed to Register for Remote Notifications
 */
- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error
{
	NSLog(@"Error in registration. Error: %@", error);
}

/**
 * Remote Notification Received while application was open.
 */
- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo
{
#if !TARGET_IPHONE_SIMULATOR
    [DataStore refresh];
    NSDictionary *apsInfo = [userInfo objectForKey:@"aps"];
    NSString *alert = [apsInfo objectForKey:@"alert"];
    NSNumber *alertId = [userInfo objectForKey:@"alertId"];
    
    self.alertViewController = [[AlertPopupController alloc] initWithAlertId:[alertId integerValue]];
    self.alertViewController.title = @"Alert";
    
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Conference Alert"
                                                        message:alert
                                                       delegate:self
                                              cancelButtonTitle:@"Dismiss"
                                              otherButtonTitles:@"Read more", nil];
    [alertView show];
#endif
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    NSString *title = [alertView buttonTitleAtIndex:buttonIndex];
    if ([title isEqualToString:@"Read more"]) {
        UINavigationController *popupNavController = [[UINavigationController alloc] initWithRootViewController:self.alertViewController];
        popupNavController.navigationBar.tintColor = [UIColor navigationBarTintColour];
        [self.tabBarController presentModalViewController:popupNavController animated:YES];
    }
}


@end