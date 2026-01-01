/*
This file is part of Telegram Desktop,
the official desktop application for the Telegram messaging service.

For license and copyright information please follow this link:
https://github.com/telegramdesktop/tdesktop/blob/master/LEGAL
*/
#include "platform/ios/ui/AppDelegate.h"
#include "core/launcher.h"
#include "mainwidget.h"
#include "window/window_controller.h"
#include "platform/ios/ui/MainWidgetIOS.h"

#import <UIKit/UIKit.h>

@interface AppDelegate ()

@property (strong, nonatomic) MainWidgetIOS *mainWidgetController;

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Create window
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
    // Initialize Telegram Desktop launcher
    // Note: Full integration requires creating Window::Controller and MainWidget
    // For now, create a placeholder UI
    
    // Create main widget controller
    // MainWidget *mainWidget = /* create from Window::Controller */;
    // self.mainWidgetController = [[MainWidgetIOS alloc] initWithMainWidget:mainWidget];
    // self.window.rootViewController = self.mainWidgetController;
    
    // Temporary: Create a basic view controller
    UIViewController *rootVC = [[UIViewController alloc] init];
    rootVC.view.backgroundColor = [UIColor systemBackgroundColor];
    self.window.rootViewController = rootVC;
    
    [self.window makeKeyAndVisible];
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, etc.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused while the application was inactive
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate
}

@end

