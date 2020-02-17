//
//  ArticleViewCell.swift
//  Tokoin
//
//  Created by Anh Hai on 2/17/20.
//  Copyright © 2020 Anh Hai. All rights reserved.
//

import Foundation
import UIKit

class ArticleViewCell: UITableViewCell {
    
    var thumbnail: UIImageView!
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.forAutoLayout()
        return label
    }()
    
    private lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.forAutoLayout()
        label.numberOfLines = 0
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupViews() {
        contentView.backgroundColor = .red
        thumbnail = UIImageView()
        thumbnail.forAutoLayout()
        addSubview(thumbnail)
        NSLayoutConstraint.activate([
            thumbnail.trailingAnchor.constraint(equalTo: trailingAnchor),
            thumbnail.centerYAnchor.constraint(equalTo: centerYAnchor),
            thumbnail.topAnchor.constraint(equalTo: topAnchor, constant: 5),
            thumbnail.widthAnchor.constraint(equalToConstant: 100)
        ])
        
        addSubview(titleLabel)
        NSLayoutConstraint.activate([
            titleLabel.trailingAnchor.constraint(equalTo: thumbnail.leadingAnchor, constant: 8),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
            titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 8),
        ])
        
        addSubview(descriptionLabel)
        NSLayoutConstraint.activate([
            descriptionLabel.rightAnchor.constraint(equalTo: thumbnail.leftAnchor, constant: 8),
            descriptionLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
            descriptionLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 4),
            descriptionLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 4)
        ])
    }
    
    func updateContent(with article: Article) {
        thumbnail.loadImage(with: article.urlToImage)
        titleLabel.text = article.title
        descriptionLabel.text = article.description
    }
}
