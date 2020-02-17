//
//  DetailArticleRouter.swift
//  Tokoin
//
//  Created by Anh Hai on 2/17/20.
//  Copyright © 2020 Anh Hai. All rights reserved.
//

import Foundation

protocol DetailArticleRouterInput: class {
    func showWebView(with urlToArticle: String)
}

class DetailArticleRouter: DetailArticleRouterInput {
    weak var viewController: DetailArticleViewController!
    var interactor: DetailArticleInteractor!
    
    func showWebView(with urlToArticle: String) {
        let webView = TokoinWebview(with: urlToArticle)
        
        viewController.present(webView, animated: true, completion: nil)
    }
}
