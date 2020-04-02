//
//  AppDelegate.m
//  WKWebView HW OBJ-C
//
//  Created by Marentilo on 01.04.2020.
//  Copyright © 2020 Marentilo. All rights reserved.
//

#import "AppDelegate.h"
#import "ViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    ViewController * rootController = [[ViewController alloc] init];
    UINavigationController * controller = [[UINavigationController alloc] initWithRootViewController: rootController];
    _window.rootViewController = controller;
    return YES;
}


@end
