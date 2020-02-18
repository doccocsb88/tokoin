//
//  ArticleViewCell.swift
//  Tokoin
//
//  Created by Anh Hai on 2/17/20.
//  Copyright © 2020 Anh Hai. All rights reserved.
//

import Foundation
import UIKit
import SDWebImage

class ArticleViewCell: UITableViewCell {
    enum Constants {
        static let defaultMargin: CGFloat = 8
        static let smallMargin: CGFloat = 4
    }
    
    var thumbnail: UIImageView!
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.forAutoLayout()
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 20)
        return label
    }()
    
    private lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.forAutoLayout()
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 16)
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
        contentView.backgroundColor = .white
        thumbnail = UIImageView()
        thumbnail.forAutoLayout()
        addSubview(thumbnail)
        NSLayoutConstraint.activate([
            rightAnchor.constraint(equalTo: thumbnail.rightAnchor, constant: 8),
            thumbnail.centerYAnchor.constraint(equalTo: centerYAnchor),
            thumbnail.topAnchor.constraint(equalTo: topAnchor, constant: Constants.smallMargin),
            thumbnail.widthAnchor.constraint(equalTo: thumbnail.heightAnchor, multiplier: 1)
        ])
        
        addSubview(titleLabel)
        NSLayoutConstraint.activate([
            thumbnail.leftAnchor.constraint(equalTo: titleLabel.rightAnchor, constant: Constants.defaultMargin),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Constants.defaultMargin),
            titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: Constants.defaultMargin),
            titleLabel.heightAnchor.constraint(lessThanOrEqualToConstant: 50)
        ])
        
        addSubview(descriptionLabel)
        NSLayoutConstraint.activate([
            thumbnail.leftAnchor.constraint(equalTo: descriptionLabel.rightAnchor, constant: 8),
            descriptionLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
            descriptionLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 4),
            bottomAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 4)
        ])
    }
    
    func updateContent(with article: Article) {
        if let urlToImage = article.urlToImage, let imageURL = URL(string: urlToImage) {
            thumbnail.sd_setImage(with: imageURL)
        }
        titleLabel.text = article.title
        descriptionLabel.text = article.description
    }
}
