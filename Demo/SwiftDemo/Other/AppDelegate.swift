//
//  AppDelegate.swift
//  SwiftDemo
//
//  Created by kelin on 2020/11/10.
//

import UIKit
@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        self.window = UIWindow(frame: UIScreen.main.bounds)
        self.window?.backgroundColor = UIColor.white
        let nav = UINavigationController(rootViewController: KKMainViewCongtroller())
        self.window?.rootViewController = nav
        self.window?.makeKeyAndVisible()
        return true
    }

}

