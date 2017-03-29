//
//  AppDelegate.m
//  GoLogo
//
//  Created by CSM on 1/27/17.
//  Copyright © 2017 CSM. All rights reserved.
//

#import "AppDelegate.h"
#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]


@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    self.deviceTokenString = @"";

    
    [[UITabBar appearance] setBarTintColor:UIColorFromRGB(0x01A1DE)];
    
    
    UITabBarController *tabBarController = (UITabBarController *)self.window.rootViewController;
    UITabBar *tabBar = tabBarController.tabBar;
    UITabBarItem *tabBarItem1 = [tabBar.items objectAtIndex:0];
    UITabBarItem *tabBarItem2 = [tabBar.items objectAtIndex:1];
    UITabBarItem *tabBarItem3 = [tabBar.items objectAtIndex:2];
    UITabBarItem *tabBarItem4 = [tabBar.items objectAtIndex:3];
    
    [[UITabBarItem appearance] setTitleTextAttributes:@{ NSForegroundColorAttributeName : UIColorFromRGB(0xFBE3BF) }
                                             forState:UIControlStateNormal];
    [[UITabBarItem appearance] setTitleTextAttributes:@{ NSForegroundColorAttributeName : [UIColor whiteColor] }
                                             forState:UIControlStateSelected];
    
    tabBarItem1.selectedImage = [[UIImage imageNamed:@"catalogIcon"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal ];
    tabBarItem1.image = [[UIImage imageNamed:@"catalogIcon"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal ];
    tabBarItem1.title = @"Catalog";
    
    tabBarItem2.selectedImage = [[UIImage imageNamed:@"GoLogoIcon"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal ];
    tabBarItem2.image = [[UIImage imageNamed:@"GoLogoIcon"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal ];
    tabBarItem2.title = @"GoLogo";
    
    tabBarItem3.selectedImage = [[UIImage imageNamed:@"contactIcon"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal ];
    tabBarItem3.image = [[UIImage imageNamed:@"contactIcon"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal ];
    tabBarItem3.title = @"Contact";
    
    tabBarItem4.selectedImage = [[UIImage imageNamed:@"GoLogoIcon"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal ];
    tabBarItem4.image = [[UIImage imageNamed:@"GoLogoIcon"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal ];
    tabBarItem4.title = @"My Favorite";
    
    
    //register for push notification
    [[UIApplication sharedApplication] registerUserNotificationSettings:[UIUserNotificationSettings settingsForTypes:(UIUserNotificationTypeSound | UIUserNotificationTypeAlert | UIUserNotificationTypeBadge) categories:nil]];
    [[UIApplication sharedApplication] registerForRemoteNotifications];
    
    return YES;
}
- (void)application:(UIApplication*)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData*)deviceToken {
    NSLog(@"My token is: %@", deviceToken);
    NSString *tokenAsString = [[[[deviceToken description]
                                 stringByReplacingOccurrencesOfString: @"<" withString: @""]
                                stringByReplacingOccurrencesOfString: @">" withString: @""]
                               stringByReplacingOccurrencesOfString: @" " withString: @""];
    self.deviceTokenString = tokenAsString;
}


-(NSString*)deviceToken {
    return self.deviceTokenString;
}


- (void)application:(UIApplication*)application didFailToRegisterForRemoteNotificationsWithError:(NSError*)error {
    NSLog(@"Failed to get token, error: %@", error);
}


-(void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo {
    
    if (application.applicationState == UIApplicationStateActive) {
        NSString *alertString;
        
        @try {
            NSDictionary *notificationDict = [userInfo objectForKey:@"aps"];
            alertString = [[notificationDict objectForKey:@"alert"] objectForKey:@"body"];
        }
        @catch (NSException * e) {
            NSLog(@"Exception: %@", e);
            alertString = @"New notification received.";
        }
        
        [[NSNotificationCenter defaultCenter] postNotificationName:@"CatalogNotification"
                                                            object:self];
        
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Notification"
                                                                                 message:alertString
                                                                          preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction *actionOk = [UIAlertAction actionWithTitle:@"Ok"
                                                           style:UIAlertActionStyleDefault
                                                         handler:nil];
        
        [alertController addAction:actionOk];
        [self.window.rootViewController presentViewController:alertController
                                                     animated:YES
                                                   completion:nil];
        
        //        [self resetUnreadMessageCount];
    }
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
