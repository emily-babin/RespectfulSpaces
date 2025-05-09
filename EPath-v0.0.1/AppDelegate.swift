//
//  AppDelegate.swift
//  EPath-v0.0.1
//
//  Created by Emily Babin on 2025-02-19.
//

import UIKit
import FirebaseCore

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        //To initialize firebase
        FirebaseApp.configure()
     
        // Change the tab bar item appearance globally
        UITabBar.appearance().tintColor = .white // For selected items (filled icons)
        UITabBar.appearance().unselectedItemTintColor = .white
        
        let navBarAppearance = UINavigationBarAppearance()
        
        //Custom RGB color for BUILD NS
        navBarAppearance.backgroundColor = UIColor(red: 222/255, green: 61/255, blue: 38/255, alpha: 1.0)
  
        navBarAppearance.titleTextAttributes = [.foregroundColor: UIColor.white]
        
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }


}

