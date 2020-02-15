//
//  AppDelegate.swift
//  CodeCaseBN
//
//  Created by AppLogist on 14.02.2020.
//  Copyright © 2020 AhmetSina. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        setInitialVC()
        setupNavigationBar()
        
        return true
    }

    /// Set Initial View Controller
    func setInitialVC() {
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.makeKeyAndVisible()
        
        let rootVC = ProductsViewController()
        //rootVC.viewModel = ProductViewModel()
        let navVC = UINavigationController(rootViewController: rootVC)
        window?.rootViewController = navVC
    }
    
    func setupNavigationBar() {
        let navAppearance = UINavigationBar.appearance()
        navAppearance.barTintColor = UIColor(red: 247, green: 247, blue: 247, alpha: 1.0)
        navAppearance.tintColor = .darkText
        navAppearance.isTranslucent = false
    }
}

