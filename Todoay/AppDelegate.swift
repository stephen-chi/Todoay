//
//  AppDelegate.swift
//  Todoay
//
//  Created by Linus Zheng on 7/2/18.
//  Copyright © 2018 Linus Zheng. All rights reserved.
//

import UIKit
import CoreData
import RealmSwift

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // First thing to get called when app is opened
        
        print(Realm.Configuration.defaultConfiguration.fileURL!)

        // Catch errors, if any
        do {
            _ = try Realm()
        } catch {
            print("Error initializing new Realm \(error)")
        }
        
        return true
    }

}

