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
    
    private lazy var tabbarControllers: [UIViewController] = {
        let router = ListArticleBuilder().build()
        
        let navigationController = UINavigationController()
        navigationController.viewControllers = [router.viewController, UIViewController()]
        
        return [router.viewController]
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setViewControllers(tabbarControllers, animated: true)
    }
}
