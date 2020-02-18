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
    func tappedRegisterButton()
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
    
    private lazy var usernameLabel: UILabel = {
        let label = UILabel()
        label.forAutoLayout()
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var registerButton: UIButton = {
        let button = UIButton()
        button.forAutoLayout()
        button.setTitle("Register", for: .normal)
        button.addTarget(self, action: #selector(tappedRegisterButton(_:)), for: .touchUpInside)
        button.setTitleColor(.red, for: .normal)
        button.backgroundColor = .lightGray
        return button
    }()
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.forAutoLayout()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "sectionCell")
        return tableView
    }()
    
    var sections:[Preference] = []
    
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
        view.addSubview(usernameLabel)
        view.addSubview(tableView)
        view.addSubview(registerButton)
        var avatarConstraint:[NSLayoutConstraint] = [
            avatarImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            avatarImageView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.5),
            avatarImageView.heightAnchor.constraint(equalTo: avatarImageView.widthAnchor),
            
            usernameLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            usernameLabel.topAnchor.constraint(equalTo: avatarImageView.bottomAnchor, constant: 8),
            
            tableView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            tableView.leftAnchor.constraint(equalTo: view.leftAnchor),
            tableView.topAnchor.constraint(equalTo: usernameLabel.bottomAnchor, constant: 8),
            tableView.bottomAnchor.constraint(equalTo: registerButton.topAnchor),
            
            registerButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            registerButton.widthAnchor.constraint(equalToConstant: 200),
            registerButton.heightAnchor.constraint(equalToConstant: 40),
            view.bottomAnchor.constraint(equalTo: registerButton.bottomAnchor, constant: 100)
        ]
        
        if #available(iOS 11, *) {
            let guide = view.safeAreaLayoutGuide
            avatarConstraint.append(avatarImageView.topAnchor.constraint(equalTo: guide.topAnchor, constant: 50))

        } else {
            avatarConstraint.append(avatarImageView.topAnchor.constraint(equalTo: view.topAnchor, constant: 50))
        }
        
        NSLayoutConstraint.activate(avatarConstraint)
    }
    
    @objc func tappedRegisterButton(_ button: UIButton) {
        output?.tappedRegisterButton()
    }
}

extension ProfileViewController: ProfileViewInput {
    func didLoadContent(with user: User?) {
        sections = user?.preferences?.allObjects.compactMap({$0 as? Preference }) ?? []
        registerButton.isHidden = sections.count > 0
        usernameLabel.text = user?.username
        DispatchQueue.main.async { [weak self] in
            self?.tableView.reloadData()
        }
    }
}

extension ProfileViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sections.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let preference = sections[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "sectionCell", for: indexPath)
        cell.textLabel?.text = preference.section
        return cell
    }
}
