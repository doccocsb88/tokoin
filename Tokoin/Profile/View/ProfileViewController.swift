//
//  ProfileViewController.swift
//  Tokoin
//
//  Created by Anh Hai on 2/17/20.
//  Copyright © 2020 Anh Hai. All rights reserved.
//

import Foundation
import UIKit

protocol ProfileViewInput: class {
    func didLoadContent(with user: User?)
}

protocol ProfileViewOutput: class {
    func viewDidLoad()
}

class ProfileViewController: UIViewController {
    weak var output: ProfileViewOutput?
    
    private lazy var avatarImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.forAutoLayout()
        imageView.image = UIImage(named: "avatar")
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.forAutoLayout()
        stackView.axis = .vertical
        return stackView
    }()
    
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        output?.viewDidLoad()
        setupViews()
    }
    
    func setupViews() {
        view.addSubview(avatarImageView)
        var avatarConstraint:[NSLayoutConstraint] = [
            avatarImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            avatarImageView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.5),
            avatarImageView.heightAnchor.constraint(equalTo: avatarImageView.widthAnchor),
        ]
        if #available(iOS 11, *) {
            let guide = view.safeAreaLayoutGuide
            avatarConstraint.append(avatarImageView.topAnchor.constraint(equalTo: guide.topAnchor, constant: 50))

        } else {
            avatarConstraint.append(avatarImageView.topAnchor.constraint(equalTo: view.topAnchor, constant: 50))
        }
        NSLayoutConstraint.activate(avatarConstraint)
        
        view.addSubview(stackView)
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: avatarImageView.bottomAnchor, constant: 16),
            stackView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16),
            stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
        ])
        
    }
}

extension ProfileViewController: ProfileViewInput {
    func didLoadContent(with user: User?) {
        if let user = user {
            let itemView = InfoItemView()
            itemView.updateView(prefix: "Username", content: user.username)
            itemView.forAutoLayout()
            stackView.addArrangedSubview(itemView)
        } else {
            stackView.arrangedSubviews
            .filter({ $0 is InfoItemView })
            .forEach({ $0.removeFromSuperview() })
        }
    }
}
