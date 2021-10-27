//
//  AppDelegate.swift
//  my-test-chat
//
//  Created by Shindarev Nikita on 20.10.2021.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        return true
    }
    
    func applicationDidFinishLaunching(_ application: UIApplication) {
        print(#function)
    }
    func applicationWillEnterForeground(_ application: UIApplication) {
        print(#function)
    }
    func applicationDidBecomeActive(_ application: UIApplication) {
        print(#function)
    }
    func applicationWillTerminate(_ application: UIApplication) {
        print(#function)
    }
    func applicationWillResignActive(_ application: UIApplication) {
        print(#function)
    }
    func applicationDidEnterBackground(_ application: UIApplication) {
        print(#function)
    }

}
