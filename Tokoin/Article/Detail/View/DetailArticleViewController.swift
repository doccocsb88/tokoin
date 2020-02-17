//
//  DetailArticleViewController.swift
//  Tokoin
//
//  Created by Anh Hai on 2/17/20.
//  Copyright © 2020 Anh Hai. All rights reserved.
//

import Foundation
import UIKit

protocol DetailArticleInput: class {
    
}

protocol DetailArticleOutput: class {
    func viewDidLoad()
    func readMore(with postURL: String)
}

class DetailArticleViewController: UIViewController {
    weak var output: DetailArticleOutput?
    let artitle: Article
    
    private lazy var categoryLabel: UILabel = {
        let label = UILabel()
        label.forAutoLayout()
        
        return label
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.forAutoLayout()
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 25)
        label.textColor = .black
        return label
    }()
    private lazy var artitleImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.forAutoLayout()
        
        return imageView
    }()
    
    private lazy var contentTextView: UITextView = {
        let textView = UITextView()
        textView.forAutoLayout()
        textView.isScrollEnabled = false
        textView.font = UIFont.systemFont(ofSize: 20)
        textView.textColor = .darkGray
        
        return textView
    }()
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.forAutoLayout()
        stackView.axis = .vertical
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.layoutMargins = UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20)
        
        return stackView
    }()
    
    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.forAutoLayout()
        
        return scrollView
    }()
    
    private lazy var contentView: UIView = {
        let contentView = UIView()
        contentView.forAutoLayout()
        
        return contentView
    }()
    
    private lazy var readPostButton: UIButton = {
        let button = UIButton()
        button.forAutoLayout()
        button.setTitle("Read full version on web", for: .normal)
        button.setTitleColor(.red, for: .normal)
        button.addTarget(self, action: #selector(tappedReadMore(_:)), for: .touchUpInside)
        return button
    }()
    
    init(with artitle: Article) {
        self.artitle = artitle
        super.init(nibName: nil, bundle: Bundle.main)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        output?.viewDidLoad()
        updateTitle()
        setupViews()
        bindDataToView()
    }
    
    func setupViews() {
        view.backgroundColor  = .white
        setupScrollView()
        setupStackView()
    }
    
    func setupScrollView() {
        let bottomMargin = self.tabBarController?.tabBar.frame.height ?? 0
        view.addSubview(scrollView)
        NSLayoutConstraint.activate([
            scrollView.leftAnchor.constraint(equalTo: view.leftAnchor),
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.rightAnchor.constraint(equalTo: view.rightAnchor),
            view.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: bottomMargin)
        ])
        
        scrollView.addSubview(contentView)
        NSLayoutConstraint.activate([
            contentView.leftAnchor.constraint(equalTo: scrollView.leftAnchor),
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.rightAnchor.constraint(equalTo: scrollView.rightAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
        ])
        
        contentView.addSubview(stackView)
        NSLayoutConstraint.activate([
            stackView.leftAnchor.constraint(equalTo: contentView.leftAnchor),
            stackView.topAnchor.constraint(equalTo: contentView.topAnchor),
            stackView.rightAnchor.constraint(equalTo: contentView.rightAnchor),
            stackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            contentView.heightAnchor.constraint(equalTo: stackView.heightAnchor)
        ])
        
        view.addSubview(readPostButton)
        NSLayoutConstraint.activate([
            readPostButton.heightAnchor.constraint(equalToConstant: 30),
            view.rightAnchor.constraint(equalTo: readPostButton.rightAnchor, constant: 16),
            view.bottomAnchor.constraint(equalTo: readPostButton.bottomAnchor, constant: bottomMargin )
        ])
    }
    
    func setupStackView() {
        stackView.addArrangedSubview(categoryLabel)
        stackView.addArrangedSubview(titleLabel)
        stackView.addArrangedSubview(artitleImageView)
        stackView.addArrangedSubview(contentTextView)
        
        NSLayoutConstraint.activate([
            artitleImageView.heightAnchor.constraint(equalTo: artitleImageView.widthAnchor, multiplier: 0.5),
            contentTextView.bottomAnchor.constraint(lessThanOrEqualTo: stackView.bottomAnchor)
        ])
    }
    
    func bindDataToView() {
        categoryLabel.text = artitle.author
        titleLabel.text = artitle.title
        contentTextView.text = artitle.content
        
        if let urlToImage = artitle.urlToImage, let imageURL = URL(string: urlToImage) {
            artitleImageView.sd_setImage(with: imageURL)
        }
        
    }
    
    func updateTitle() {
        title = artitle.source.name
    }
    
    @objc func tappedReadMore(_ button: UIButton) {
        output?.readMore(with: artitle.url)
    }
}

extension DetailArticleViewController: DetailArticleInput {
    
}
