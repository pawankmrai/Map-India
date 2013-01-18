//
//  MIAppDelegate.m
//  Map-India
//
//  Created by Avneesh minocha on 9/12/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MIAppDelegate.h"
#import <Parse/Parse.h>
@implementation MIAppDelegate

@synthesize window = _window;
@synthesize filteredArray=_filteredArray;
@synthesize refKeyGB=_refKeyGB;
@synthesize rowTitle=_rowTitle;
@synthesize locationTitle=_locationTitle;
@synthesize globalLattitude,globalLongitude;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Override point for customization after application launch.
    
    
    [Parse setApplicationId:@"wPdcYRS7SzSUiG8mjlNlp0Hpo4qSE2pmspIVkPbo"
                  clientKey:@"cnqrFS9oFHBj4A1uRMz82Bj3jubGYoMwWB7jO96T"];
    
    //////////send info for installation to parse.com  dashboard////////////
    
    PFInstallation *currentInstallation=[PFInstallation currentInstallation];
    if (currentInstallation.badge!=0) {
        
        currentInstallation.badge=0;
        [currentInstallation saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error){
        
            if (succeeded) {
                
                NSLog(@"device registered to dashboard");
            }
            if (error) {
                [currentInstallation saveEventually];
            }
        }];
    }
    /////////////////////////////////////////
    
    //////////////checking for user in cached memory////////////////
    PFUser *user=[PFUser currentUser];
    if (user) {
        NSLog(@"user log in!!!!");
    }
    else{
    
        NSLog(@"go for login");
    }
    

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
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
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
