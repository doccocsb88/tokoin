//
//  ArticleInteractor.swift
//  Tokoin
//
//  Created by Anh Hai on 2/17/20.
//  Copyright © 2020 Anh Hai. All rights reserved.
//

import Foundation
import RxSwift
class ListArticleInteractor: ListArticleOutput {
    
    var view: ListArticleInput!
    var router: ListArticleRouter!
    
    private let disposeBag = DisposeBag()
    func viewDidLoad() {
        fetchListArticle()
    }
    
    func fetchListArticle() {
        APIClient.fetchListArtice(with: "bitcoin").observeOn(MainScheduler.instance).subscribe(onNext: { [weak self] response in
            print("aaaa")
            guard let this = self else { return }
            if response.status == "ok" {
                let articles = response.articles
                this.view.didFetchListArticle(with: articles)
            }
        }, onError: { error in
            switch error {
            case ApiError.conflict:
                print("Conflict error")
            case ApiError.forbidden:
                print("Forbidden error")
            case ApiError.notFound:
                print("Not found error")
            default:
                print("Unknown error:", error)
            }
            }).disposed(by: disposeBag)
    }
}
