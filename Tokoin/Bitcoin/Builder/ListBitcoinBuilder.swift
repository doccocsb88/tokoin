//
//  ArticleBuilder.swift
//  Tokoin
//
//  Created by Anh Hai on 2/17/20.
//  Copyright © 2020 Anh Hai. All rights reserved.
//

import Foundation
class ListArticleBuilder {
    
    init() {
    }
    
    func build() -> ListArticleRouter {
        let router: ListArticleRouter = ListArticleRouter()

        let interactor = ListArticleInteractor()
        let viewController = ListArticleViewController()
        interactor.view  = viewController
        interactor.router = router
        
        viewController.output = interactor
        
        router.viewController = viewController
        router.interactor = interactor
        
        
        return router
    }
}
