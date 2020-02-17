//
//  DetailArticleInteractor.swift
//  Tokoin
//
//  Created by Anh Hai on 2/17/20.
//  Copyright © 2020 Anh Hai. All rights reserved.
//

import Foundation

class DetailArticleInteractor: DetailArticleOutput {
    
    var view: DetailArticleInput?
    var router: DetailArticleRouterInput?
    
    func viewDidLoad() {
        
    }
    
    func readMore(with postURL: String) {
        router?.showWebView(with: postURL)
    }
}
