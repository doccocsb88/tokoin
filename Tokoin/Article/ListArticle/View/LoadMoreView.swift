//
//  LoadMoreView.swift
//  Tokoin
//
//  Created by Anh Hai on 2/18/20.
//  Copyright © 2020 Anh Hai. All rights reserved.
//

import Foundation
import UIKit

class LoadMoreView: UIView {
    private lazy var contentLabel: UILabel = {
        let label = UILabel()
        label.forAutoLayout()
        label.textAlignment = .center
        label.text = "Loading..."
        return label
    }()
    
    init() {
        super.init(frame: .zero)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupViews() {
        backgroundColor = .white
        addSubview(contentLabel)
        NSLayoutConstraint.activate([
            contentLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            contentLabel.centerXAnchor.constraint(equalTo: centerXAnchor)
        ])
    }
    
}
