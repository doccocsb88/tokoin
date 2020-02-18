//
//  InfoItemView.swift
//  Tokoin
//
//  Created by Anh Hai on 2/18/20.
//  Copyright © 2020 Anh Hai. All rights reserved.
//

import Foundation
import UIKit

class InfoItemView: UIView {
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.forAutoLayout()
        stackView.spacing = 16
        return stackView
    }()
    
    private lazy var prefixLabel: UILabel = {
        let label = UILabel()
        label.forAutoLayout()
        label.backgroundColor = .lightGray
        label.textAlignment = .center
        return label
    }()
    
    private lazy var contentLabel: UILabel = {
        let label = UILabel()
        label.forAutoLayout()
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
        addSubview(stackView)
        stackView.addArrangedSubview(prefixLabel)
        stackView.addArrangedSubview(contentLabel)
        
        NSLayoutConstraint.activate([
            heightAnchor.constraint(equalToConstant: 50),
            
            stackView.leftAnchor.constraint(equalTo: leftAnchor),
            stackView.rightAnchor.constraint(equalTo: rightAnchor),
            stackView.topAnchor.constraint(equalTo: topAnchor),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor),

            prefixLabel.widthAnchor.constraint(equalToConstant: 100),
            contentLabel.rightAnchor.constraint(equalTo: stackView.rightAnchor)
        ])
    }
    
    func updateView(prefix: String, content: String) {
        prefixLabel.text = prefix
        contentLabel.text = content
    }
}
