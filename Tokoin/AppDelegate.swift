//
//  AppDelegate.swift
//  Tokoin
//
//  Created by Anh Hai on 2/17/20.
//  Copyright © 2020 Anh Hai. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var router: ListArticleRouter?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        let router = ListArticleBuilder().build()
        
        let navigationController = UINavigationController()
        navigationController.viewControllers = [router.viewController]
        self.router = router
        
        let tabbarController = TokoinTabbarController()
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = tabbarController
        window?.makeKeyAndVisible()

        return true
    }

}

