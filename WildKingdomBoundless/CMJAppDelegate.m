//
//  CMJAppDelegate.m
//  WildKingdomBoundless
//
//  Created by Claire Jencks on 3/29/14.
//  Copyright (c) 2014 Claire Jencks. All rights reserved.
//

#import "CMJAppDelegate.h"
#import "CMJPhotosViewController.h"

@implementation CMJAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
    //create instance of CMJPVcontroller, nest it by setting it as the root inside an instance of nav controller and then set that as the overall root view controller.
    
    CMJPhotosViewController *cmjPhotosViewController = [[CMJPhotosViewController alloc]init];
    
    UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:cmjPhotosViewController];
    
    UINavigationBar *navigationBar = navigationController.navigationBar;
    navigationBar.barTintColor = [UIColor colorWithRed:37.0 / 255.0 green:109.0 / 255.0 blue:5.0 / 255.0 alpha:1.0];
    navigationBar.barStyle = UIBarStyleBlackOpaque;
    self.window.rootViewController = navigationController;
    
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    

    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the bCMJPhotosViewControllerackground.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
