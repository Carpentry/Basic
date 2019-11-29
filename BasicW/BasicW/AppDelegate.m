//
//  AppDelegate.m
//  BasicW
//
//  Created by 小李 on 2019/11/7.
//  Copyright © 2019 lyl. All rights reserved.
//

#import "AppDelegate.h"
#import "BWNavigationViewController.h"
#import "ViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {

    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.window.rootViewController = [[BWNavigationViewController alloc] initWithRootViewController:[[ViewController alloc] init]];
    [self.window makeKeyAndVisible];

    return YES;
}


@end
