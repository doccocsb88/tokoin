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
    
    func build(viewType: ViewType = .headLine, with sections: [String] = []) -> ListArticleRouter {
        let router: ListArticleRouter = ListArticleRouter()

        let interactor = ListArticleInteractor(viewType: viewType)
        let viewController = ListArticleViewController(sections: sections)
        interactor.view  = viewController
        interactor.router = router
        
        viewController.output = interactor
        
        router.viewController = viewController
        router.interactor = interactor
        
        
        return router
    }
}
