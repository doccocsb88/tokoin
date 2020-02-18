//
//  ProfileRouter.swift
//  Tokoin
//
//  Created by Anh Hai on 2/17/20.
//  Copyright © 2020 Anh Hai. All rights reserved.
//

import Foundation
import UIKit

protocol ProfileRouterInput: class {
    func showRegisterViewController()
}

class ProfileRouter {
    
    weak var viewController: ProfileViewController!
    var interactor: ProfileInteractor!

}

extension ProfileRouter: ProfileRouterInput {
    func showRegisterViewController() {
        let registerViewController = RegisterViewController(with: interactor)
        viewController.navigationController?.pushViewController(registerViewController, animated: true)
    }
}
