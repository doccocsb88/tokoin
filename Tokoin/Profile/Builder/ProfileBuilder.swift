//
//  ProfileBuilder.swift
//  Tokoin
//
//  Created by Anh Hai on 2/17/20.
//  Copyright © 2020 Anh Hai. All rights reserved.
//

import Foundation

class ProfileBuilder {
    func build() -> ProfileRouter {
        let router = ProfileRouter()
        let viewController = ProfileViewController()
        let interactor = ProfileInteractor()
        interactor.view = viewController
        interactor.router = router
        viewController.output = interactor
        router.viewController = viewController
        router.interactor = interactor
        return router
    }
}
