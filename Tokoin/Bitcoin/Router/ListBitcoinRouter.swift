//
//  ArticleRouter.swift
//  Tokoin
//
//  Created by Anh Hai on 2/17/20.
//  Copyright © 2020 Anh Hai. All rights reserved.
//

import Foundation
import UIKit
protocol ListArticleRouterInput: class {
    func showArticleDetailView()
}
class ListArticleRouter: ListArticleRouterInput {
    weak var viewController: ListArticleViewController!
    var interactor: ListArticleInteractor!
    
    func showArticleDetailView() {
        
    }
}
