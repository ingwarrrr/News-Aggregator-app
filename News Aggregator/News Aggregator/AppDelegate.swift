//
//  AppDelegate.swift
//  News Aggregator
//
//  Created by Igor on 27.06.2023.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

        window = UIWindow(frame: UIScreen.main.bounds)

        let newsTabBarController = NewsTabBarController()
        let rootNC = UINavigationController(rootViewController: newsTabBarController)
        rootNC.isNavigationBarHidden = true
        newsTabBarController.setupTabBarItems()
        
        window?.rootViewController = rootNC
        window?.makeKeyAndVisible()
        return true
    }
}

