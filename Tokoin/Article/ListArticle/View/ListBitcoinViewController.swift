//
//  ArticleViewController.swift
//  Tokoin
//
//  Created by Anh Hai on 2/17/20.
//  Copyright © 2020 Anh Hai. All rights reserved.
//

import Foundation
import UIKit

protocol ListArticleInput: class {
    func didFetchListArticle(with article: [Article])
}

protocol ListArticleOutput: class {
    func viewDidLoad()
    func didSelectArticle(_ article: Article)
}

class ListArticleViewController: UIViewController {
    weak var output: ListArticleOutput?
    
    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.forAutoLayout()
        
        return scrollView
    }()
    private lazy var contentView: UIView = {
        let view = UIView()
        view.forAutoLayout()
        return view
    }()
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        
        return stackView
    }()
    var tableView: UITableView!
    var data:[Article] = []
    
    init() {
        super.init(nibName: nil, bundle: Bundle.main)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        output?.viewDidLoad()
        setupViews()
    }
    
    func setupViews() {
        view.backgroundColor = .white
        initTableView()
    }
    
    func setupFilterView() {
//        view.addSubview
    }
    
    func initTableView() {
        tableView  = UITableView()
        tableView.forAutoLayout()
        view.addSubview(tableView)
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(ArticleViewCell.self, forCellReuseIdentifier: "articleCell")
        NSLayoutConstraint.activate([
            tableView.leftAnchor.constraint(equalTo: view.leftAnchor),
            tableView.rightAnchor.constraint(equalTo: view.rightAnchor),
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])

    }
    
}

extension ListArticleViewController: ListArticleInput {
    func didFetchListArticle(with article: [Article]) {
        print("abcdef")
        data = article
        DispatchQueue.main.async { [weak self] in 
            self?.tableView.reloadData()
        }
    }
}

extension ListArticleViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let article = data[indexPath.row]
        if let cell = tableView.dequeueReusableCell(withIdentifier: "articleCell", for: indexPath) as? ArticleViewCell {
            cell.updateContent(with: article)
            return cell
        }
        
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let article = data[indexPath.row]
        output?.didSelectArticle(article)
    }
}
