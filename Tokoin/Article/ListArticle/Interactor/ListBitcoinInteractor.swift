//
//  ArticleInteractor.swift
//  Tokoin
//
//  Created by Anh Hai on 2/17/20.
//  Copyright © 2020 Anh Hai. All rights reserved.
//

import Foundation
import RxSwift

enum ViewType {
    case headLine
    case news
}

class ListArticleInteractor: ListArticleOutput {
    enum Constants {
        static let pageSize: Int = 10
    }
    var view: ListArticleInput!
    var router: ListArticleRouter!
    
    private let disposeBag = DisposeBag()
    private var viewType: ViewType
    private var section: String?
    private var response: ArticleResponse?
    private var currentPage: Int = 1
    private var isLoading: Bool = false
    
    init(viewType: ViewType = .headLine) {
        self.viewType = viewType
    }
    
    func viewDidLoad() {
        fetchArticles()
    }
    
    func didSelectArticle(_ article: Article) {
        router.showArticleDetailView(with: article)
    }
    
    func didSelectSection(with key: String) {
        resetParameters()
        section = key
        fetchListArticle(with: key, page: currentPage)
    }
    
    func loadMore() {
        let totalResults = response?.totalResults ?? 0
        let nextPage = currentPage + 1
        let canLoadMore = nextPage * Constants.pageSize < totalResults
        if canLoadMore {
            currentPage = nextPage
            fetchArticles()
        }
    }
    
    //MARK -
    private func resetParameters() {
        currentPage = 1
        response = nil
        isLoading = false
        view.clearData()
    }
    
    private func fetchArticles() {
        guard !isLoading else { return }
        switch viewType {
        case .headLine:
            fetchHeadLine()
        case .news:
            if let section = section {
                fetchListArticle(with: section, page: currentPage)
            }
        }
    }
    
    func fetchHeadLine() {
        isLoading = true
        view.toggleLoadMoreView(isLoading: isLoading)
        APIClient.fetchHeadLine(in: "us", page: currentPage, pageSize: Constants.pageSize)
            .observeOn(MainScheduler.instance).subscribe(onNext: {[weak self] response in
                guard let this = self else { return }
                this.handleResponse(response: response)
            }, onError: { [weak self] error in
                guard let this = self else { return }
                this.handleError(error: error)
            }).disposed(by: disposeBag)
    }
    
    func fetchListArticle(with key: String, page: Int? = nil, pageSize: Int = Constants.pageSize) {
        isLoading = true
        view.toggleLoadMoreView(isLoading: isLoading)
        APIClient.fetchListArtice(with: key, page: page, pageSize: pageSize)
            .observeOn(MainScheduler.instance)
            .subscribe(onNext: { [weak self] response in
            guard let this = self else { return }
            this.handleResponse(response: response)
        }, onError: { [weak self] error in
            self?.handleError(error: error)
        }).disposed(by: disposeBag)
    }
    
    private func handleResponse(response: ArticleResponse) {
        isLoading = false
        view.toggleLoadMoreView(isLoading: isLoading)
        self.response = response
        if let status = ResponseStatus(rawValue: response.status) {
            switch status {
            case .ok:
                if let articles = response.articles {
                    view.didFetchListArticle(with: articles)
                }
            case .error:
                //handle error
                break
            }
        }
    }
    
    private func handleError(error: Error) {
        isLoading = false
        view.toggleLoadMoreView(isLoading: isLoading)
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
    }
}
