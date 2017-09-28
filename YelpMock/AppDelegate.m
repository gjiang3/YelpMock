//
//  AppDelegate.m
//  YelpMock
//
//  Created by Guohua Jiang on 8/26/17.
//  Copyright © 2017 Gary. All rights reserved.
//

#import "AppDelegate.h"
#import "YelpNetworking.h"
#import "YelpViewController.h"
#import "MapViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
    YelpViewController *svc = [[YelpViewController alloc] init];
    
    UINavigationController *nvc1 = [[UINavigationController alloc] initWithRootViewController:svc];
    nvc1.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"Search" image:[UIImage imageNamed:@"search"] tag:0];
    
    nvc1.navigationBar.barStyle = UIBarStyleBlack;
    
    nvc1.navigationBar.barTintColor = [UIColor  colorWithRed:196.0f/255.0f green:19.0f/255.0f blue:0.0f/255.0f alpha:1.0f];
    nvc1.navigationBar.tintColor = [UIColor whiteColor];
    [nvc1.navigationBar
     setTitleTextAttributes:@{NSForegroundColorAttributeName: [UIColor whiteColor]}];
    
    
    MapViewController *mapVC = [[MapViewController alloc] init];
    UINavigationController *nvc2 = [[UINavigationController alloc] initWithRootViewController:mapVC];
    nvc2.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"Map" image: [UIImage imageNamed:@"map"] tag:0];
    
    nvc2.navigationBar.barStyle = UIBarStyleBlack;
    nvc2.navigationBar.barTintColor = [UIColor  colorWithRed:196.0f/255.0f green:19.0f/255.0f blue:0.0f/255.0f alpha:1.0f];
    nvc2.navigationBar.tintColor = [UIColor whiteColor];
    
    
    UITabBarController *tbc = [[UITabBarController alloc] init];
    
    [tbc setViewControllers:@[nvc1,nvc2]];
    
    self.window.rootViewController = tbc;
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    
    return YES;
    
}



- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
