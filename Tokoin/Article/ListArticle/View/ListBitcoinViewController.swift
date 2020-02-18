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
    func clearData()
    func toggleLoadMoreView(isLoading: Bool)
    func updateFilterView(with sections:[String])
}

protocol ListArticleOutput: class {
    func viewDidLoad()
    func didSelectArticle(_ article: Article)
    func didSelectSection(with key: String)
    func loadMore()
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
        view.backgroundColor = .yellow
        return view
    }()
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.forAutoLayout()
        return stackView
    }()
    
    var tableView: UITableView!
    var data:[Article] = []
    var topMargin: CGFloat = 0
    var sections:[String] = []
    var isLoading: Bool = false
    
    init(sections:[String]) {
        self.sections = sections
        super.init(nibName: nil, bundle: Bundle.main)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        output?.viewDidLoad()
        setupViews()
        if sections.count > 0 {
            output?.didSelectSection(with: sections[0])
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    func setupViews() {
        view.backgroundColor = .white
        setupFilterView()
        setupTableView()
        generateFilterView()
    }
    
    func setupFilterView() {
        guard sections.count > 0 else { return }
        topMargin = 50
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        contentView.addSubview(stackView)
        if #available(iOS 11, *) {
            let guide = view.safeAreaLayoutGuide
            NSLayoutConstraint.activate([scrollView.topAnchor.constraint(equalTo: guide.topAnchor)])
        } else {
            NSLayoutConstraint.activate([scrollView.topAnchor.constraint(equalTo: view.topAnchor)])
        }
        NSLayoutConstraint.activate([
            scrollView.leftAnchor.constraint(equalTo: view.leftAnchor),
            scrollView.rightAnchor.constraint(equalTo: view.rightAnchor),
            scrollView.heightAnchor.constraint(equalToConstant: topMargin),
            
            contentView.leftAnchor.constraint(equalTo: scrollView.leftAnchor),
            contentView.rightAnchor.constraint(equalTo: scrollView.rightAnchor),
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            
            stackView.leftAnchor.constraint(equalTo: contentView.leftAnchor),
            stackView.topAnchor.constraint(equalTo: contentView.topAnchor),
            stackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            
            contentView.widthAnchor.constraint(greaterThanOrEqualTo: stackView.widthAnchor),
            contentView.heightAnchor.constraint(equalTo: scrollView.heightAnchor)
        ])
    }
    
    func setupTableView() {
        tableView  = UITableView()
        tableView.forAutoLayout()
        view.addSubview(tableView)
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(ArticleViewCell.self, forCellReuseIdentifier: "articleCell")
        
        var tableConstraint:[NSLayoutConstraint] = [
            tableView.leftAnchor.constraint(equalTo: view.leftAnchor),
            tableView.rightAnchor.constraint(equalTo: view.rightAnchor)]
        
        if #available(iOS 11, *) {
            let guide = view.safeAreaLayoutGuide
            tableConstraint.append(tableView.topAnchor.constraint(equalTo: guide.topAnchor, constant: topMargin))
            tableConstraint.append(tableView.bottomAnchor.constraint(equalTo: guide.bottomAnchor))
        } else {
            tableConstraint.append(tableView.topAnchor.constraint(equalTo: view.topAnchor, constant: topMargin))
            tableConstraint.append(tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor))
        }
        NSLayoutConstraint.activate(tableConstraint)
    }
    
    func generateFilterView() {
        clearSectionView()
        for i in 0 ..< sections.count {
            let section = sections[i]
            let button = UIButton()
            button.forAutoLayout()
            button.setTitle(section, for: .normal)
            button.setTitleColor(.black, for: .normal)
            button.tag = i
            button.addTarget(self, action: #selector(didSelectSection(_:)), for: .touchUpInside)
            stackView.addArrangedSubview(button)
            NSLayoutConstraint.activate([
                button.widthAnchor.constraint(equalToConstant: 100),
                button.heightAnchor.constraint(equalToConstant: 50)
            ])
        }
    }
    
    func clearSectionView() {
        stackView.arrangedSubviews
        .filter({ $0 is UIButton })
        .forEach({ $0.removeFromSuperview() })
    }
    
    @objc func didSelectSection(_ button: UIButton) {
        let sectionIndex = button.tag
        let section = sections[sectionIndex]
        output?.didSelectSection(with: section)
    }
}

extension ListArticleViewController: ListArticleInput {
    func didFetchListArticle(with article: [Article]) {
        data.append(contentsOf: article)
        DispatchQueue.main.async { [weak self] in 
            self?.tableView.reloadData()
        }
    }
    
    func clearData() {
        data.removeAll()
        DispatchQueue.main.async { [weak self] in
            self?.tableView.reloadData()
        }
    }
    
    func toggleLoadMoreView(isLoading: Bool) {
        self.isLoading = isLoading
        DispatchQueue.main.async { [weak self] in
            self?.tableView.reloadData()
        }
    }
    
    func updateFilterView(with sections:[String]) {
        self.sections = sections
        generateFilterView()
    }
}

extension ListArticleViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return isLoading == true ? 50 : 0.1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let article = data[indexPath.row]
        if let cell = tableView.dequeueReusableCell(withIdentifier: "articleCell", for: indexPath) as? ArticleViewCell {
            cell.updateContent(with: article)
            let isLastCell = indexPath.row == data.count - 1
            if isLastCell {
                output?.loadMore()
            }
            return cell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let loadMoreView = isLoading == true ? LoadMoreView() : nil
        return loadMoreView
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let article = data[indexPath.row]
        output?.didSelectArticle(article)
    }
}
