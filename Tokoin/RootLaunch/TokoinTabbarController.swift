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
    let profileRouter = ProfileBuilder().build()

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
        profileRouter.viewController.tabBarItem = profileItem
        return [navigationController, sectionNavigationController, profileRouter.viewController]
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setViewControllers(tabbarControllers, animated: true)
    }
}
