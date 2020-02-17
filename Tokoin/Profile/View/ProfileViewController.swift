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
    
}

protocol ProfileViewOutput: class {
    
}

class ProfileViewController: UIViewController {
    weak var output: ProfileViewOutput?
    
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
    }
}

extension ProfileViewController: ProfileViewInput {
    
}
