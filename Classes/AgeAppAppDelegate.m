//
//  AgeAppAppDelegate.m
//  AgeApp
//
//  Created by Vladimir Glavtchev on 3/18/11.
//  Copyright Vladimir Glavtchev. All rights reserved.
//

#import "AgeAppAppDelegate.h"

//#define GOOGLE_ANALYTICS

// Dispatch period in seconds
static const NSInteger kGANDispatchPeriodSec = 10;

@implementation AgeAppAppDelegate

@synthesize window;
@synthesize viewController;
@synthesize introController;

#pragma mark -
#pragma mark Application lifecycle

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {    
    
    // Override point for customization after application launch.

	// Set the view controller as the window's root view controller and display.
    IntroScreenViewController *introScrController = [[IntroScreenViewController alloc] initWithNibName:@"IntroScreenViewController" bundle:nil];
    
    AgeAppViewController *mainViewController = [[AgeAppViewController alloc] initWithNibName:@"AgeAppViewController" bundle:nil];
    
    self.introController = introScrController;
    self.viewController = mainViewController;
    
    //[self.window.rootViewController.view insertSubview: introScrController.view atIndex: 0];
    self.window.rootViewController = introScrController;
    [self.window makeKeyAndVisible];
	    
    [introController init];
    
    // Integrate Crittercism for analytics and crashes
    [Crittercism initWithAppID: @"4f7214e9b093157449000022"
                        andKey:@"0disgwxxg4cvvsjqq5r1zujerbtd"
                     andSecret:@"nv20tdjkrkrdbah4sf9mncglijhz3xxc"];
    
    // Integrate Google Analytics for stat tracking
#ifdef GOOGLE_ANALYTICS
    [[GANTracker sharedTracker] startTrackerWithAccountID:@"UA-30593893-1"
                                           dispatchPeriod:kGANDispatchPeriodSec
                                                 delegate:nil];
#endif
    
    // Keep track of users hitting the app entry
    NSError *error;
    if (![[GANTracker sharedTracker] trackPageview:@"/app_entry_point"
                                         withError:&error]) {    }
    
    
    [[NSNotificationCenter defaultCenter]
     addObserver:self
     selector:@selector(showMainView)
     name:@"hideIntroView"
     object:nil];
        
    [introScrController release];
    [mainViewController release];
    
    return YES;
}

- (void)showMainView
{
    [introController.view removeFromSuperview];
    //[self.window.rootViewController.view removeFromSuperview];
    [self.window addSubview: self.viewController.view];
    [viewController init];
}

- (void)applicationWillResignActive:(UIApplication *)application {
    
    // Will get minimized
    NSLog(@"CurrentSoundPlaying");

    [[NSNotificationCenter defaultCenter] postNotificationName:@"appBecameMinimized" object:self    ];

    /*
     Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
     Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
     */
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    
    // Is already minimized
 
    /*
     Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
     If your application supports background execution, called instead of applicationWillTerminate: when the user quits.
     */
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
   
    // Getting re-called again from minimized
 
    [[NSNotificationCenter defaultCenter] postNotificationName:@"appBecameMaximized" object:self    ];
    
    /*
     Called as part of  transition from the background to the inactive state: here you can undo many of the changes made on entering the background.
     */
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    
    // Is now fully maximized
 
    /*
     Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
     */
}


- (void)applicationWillTerminate:(UIApplication *)application {
    /*
     Called when the application is about to terminate.
     See also applicationDidEnterBackground:.
     */
}


#pragma mark -
#pragma mark Memory management

- (void)applicationDidReceiveMemoryWarning:(UIApplication *)application {
    /*
     Free up as much memory as possible by purging cached data objects that can be recreated (or reloaded from disk) later.
     */
}


- (void)dealloc {
    [viewController release];
    [window release];
    [super dealloc];
}


@end
