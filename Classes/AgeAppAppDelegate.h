//
//  AgeAppAppDelegate.h
//  AgeApp
//
//  Created by Vladimir Glavtchev on 3/18/11.
//  Copyright 2011 BMW Technology Office USA. All rights reserved.
//

#import <UIKit/UIKit.h>

@class AgeAppViewController;

@interface AgeAppAppDelegate : NSObject <UIApplicationDelegate> {
    UIWindow *window;
    AgeAppViewController *viewController;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet AgeAppViewController *viewController;

@end

