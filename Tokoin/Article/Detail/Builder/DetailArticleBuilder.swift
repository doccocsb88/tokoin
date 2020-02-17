//
//  DetailArticleBuilder.swift
//  Tokoin
//
//  Created by Anh Hai on 2/17/20.
//  Copyright © 2020 Anh Hai. All rights reserved.
//

import Foundation
class DetailArticleBuilder {
    func build(with artitle: Article) -> DetailArticleRouter {
        let router = DetailArticleRouter()
        
        let viewController = DetailArticleViewController(with: artitle)
        let interactor = DetailArticleInteractor()
        
        viewController.output = interactor
        interactor.view = viewController
        interactor.router = router
        
        router.viewController = viewController
        router.interactor = interactor
        
        return router
    }
}
