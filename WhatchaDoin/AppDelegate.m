//
//  AppDelegate.m
//  WhatchaDoin
//
//  Created by CRYSTAL MCDONALD on 5/6/14.
//  Copyright (c) 2014 CRYSTAL MCDONALD. All rights reserved.
//

#import "AppDelegate.h"
#import "Reachability.h"
#import "ViewController.h"


@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Override point for customization after application launch.
    [Parse setApplicationId:@"2q96PVZvGkpnColKq749jq93xFdIACN8BxIw6OIF"
                  clientKey:@"UkrPDmszQ4Q7QgLV3L3BhOUKhqS4GfsYz2anzTop"];
    [PFAnalytics trackAppOpenedWithLaunchOptions:launchOptions];
    
    PFUser *user = [PFUser currentUser];
    [user refreshInBackgroundWithBlock:^(PFObject *object, NSError *error) {
        
    }];
    
    // Initialize Reachability
    Reachability *reachability = [Reachability reachabilityWithHostname:@"www.google.com"];
    
    reachability.reachableBlock = ^(Reachability *reachability) {
        NSLog(@"Network Connection.");
    };
    
    reachability.unreachableBlock = ^(Reachability *reachability) {
        NSLog(@"No Network Connection.");
    };
    
    // Start Monitoring
    [reachability startNotifier];
    
    
    
    return YES;
}




- (void)applicationWillTerminate:(UIApplication *)application
{
    /*
     Called when the application is about to terminate.
     Save data if appropriate.
     See also applicationDidEnterBackground:.
     */
}
@end
