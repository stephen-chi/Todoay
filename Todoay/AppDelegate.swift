//
//  AppDelegate.swift
//  Todoay
//
//  Created by Linus Zheng on 7/2/18.
//  Copyright © 2018 Linus Zheng. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // First thing to get called when app is opened
        
        print(NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).last! as String)
        
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Receiving a call or some other interruption
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Other app is opened, exit to home screen
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Triggered by operating system, user force quits, etc.
    }


}

