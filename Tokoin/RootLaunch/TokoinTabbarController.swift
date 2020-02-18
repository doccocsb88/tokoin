//
//  TokoinTabbarController.swift
//  Tokoin
//
//  Created by Anh Hai on 2/17/20.
//  Copyright © 2020 Anh Hai. All rights reserved.
//

import Foundation
import UIKit

class TokoinTabbarController: UITabBarController {
    
    let sections:[String] = ["bitcoin", "apple", "earthquake", "animal"]

    private lazy var tabbarControllers: [UIViewController] = {
        let router = ListArticleBuilder().build()
        
        let headLineItem = UITabBarItem()
        headLineItem.title = "News"
        headLineItem.image = UIImage(named: "home_icon")
        let navigationController = UINavigationController()
        navigationController.viewControllers = [router.viewController]
        router.viewController.tabBarItem = headLineItem
        
        let sectionRouter = ListArticleBuilder().build(viewType: .news, with: sections)
        let sectionNavigationController = UINavigationController()
        sectionNavigationController.viewControllers = [sectionRouter.viewController]
        
        let profileItem = UITabBarItem()
        profileItem.title = "Profile"
        profileItem.image = UIImage(named: "profile_icon")
        let profileNavigation = UINavigationController()
        let profileRouter = ProfileBuilder().build()
        profileNavigation.viewControllers = [profileRouter.viewController]
        profileRouter.viewController.tabBarItem = profileItem
        return [navigationController, sectionNavigationController, profileNavigation]
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setViewControllers(tabbarControllers, animated: true)
    }
}
