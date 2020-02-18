//
//  RegisterViewController.swift
//  Tokoin
//
//  Created by Anh Hai on 2/18/20.
//  Copyright © 2020 Anh Hai. All rights reserved.
//

import Foundation
import UIKit

class RegisterViewController: UIViewController {
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.forAutoLayout()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "sectionCell")
        tableView.isEditing = true
        return tableView
    }()
    
    private lazy var usernameTextfield: UITextField = {
        let textfield = UITextField()
        textfield.forAutoLayout()
        textfield.rounded()
        return textfield
    }()
    
    var sections:[String] = ["bitcoin", "apple", "earthquake", "animal"]
    weak var delegate: ProfileInteractorInput?
    
    init(with delegate: ProfileInteractorInput? = nil) {
        self.delegate = delegate
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationView()
        setupViews()
    }
    
    func setupNavigationView() {
        edgesForExtendedLayout = []
        title = "Register"
        let saveButton = UIBarButtonItem(title: "Save", style: .plain, target: self, action: #selector(tappedSaveButton(_:)))
        navigationItem.rightBarButtonItem = saveButton
    }
    
    func setupViews() {
        view.backgroundColor = .white
        view.addSubview(usernameTextfield)
        view.addSubview(tableView)
        
        NSLayoutConstraint.activate([
            usernameTextfield.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            usernameTextfield.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 32),
            usernameTextfield.topAnchor.constraint(equalTo: view.topAnchor, constant: 48),
            usernameTextfield.heightAnchor.constraint(equalToConstant: 40),
            
            tableView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16),
            tableView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            tableView.topAnchor.constraint(equalTo: usernameTextfield.bottomAnchor, constant: 32),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    @objc func tappedSaveButton(_ button: UIButton) {
        guard let username = usernameTextfield.text else {
            //TODO - implement validation or show message if needed
            return
        }
        
        TokoinCoreData.shared.saveUser(username: username, sections: sections)
        delegate?.didRegisterUser()
        navigationController?.popViewController(animated: true)
    }
}

extension RegisterViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sections.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let section = sections[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "sectionCell", for: indexPath)
        cell.textLabel?.text = section
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            sections.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
}
