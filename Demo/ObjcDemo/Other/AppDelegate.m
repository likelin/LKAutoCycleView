//
//  AppDelegate.m
//  ObjcDemo
//
//  Created by kelin on 2020/11/10.
//

#import "AppDelegate.h"
#import "KKMainViewController.h"
@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    _window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    _window.backgroundColor = [UIColor whiteColor];
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:[KKMainViewController new]];
    _window.rootViewController = nav;
    [_window makeKeyAndVisible];

    
    return YES;
}




@end
