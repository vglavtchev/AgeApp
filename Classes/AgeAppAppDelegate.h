//
//  AgeAppAppDelegate.h
//  AgeApp
//
//  Created by Vladimir Glavtchev on 3/18/11.
//  Copyright Vladimir Glavtchev. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "IntroScreenViewController.h"
#import "AgeAppViewController.h"
#import "Crittercism.h"

@class AgeAppViewController;
@class IntroScreenViewController;

@interface AgeAppAppDelegate : NSObject <UIApplicationDelegate> {
    UIWindow *window;
    AgeAppViewController *viewController;
    IntroScreenViewController *introController;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet AgeAppViewController *viewController;
@property (nonatomic, retain) IBOutlet IntroScreenViewController *introController;
- (void)showMainView;

@end

