//
//  ProfileInteractor.swift
//  Tokoin
//
//  Created by Anh Hai on 2/17/20.
//  Copyright © 2020 Anh Hai. All rights reserved.
//

import Foundation

protocol ProfileInteractorInput: class {
    func didRegisterUser()
}

class ProfileInteractor {
    
    var view: ProfileViewInput?
    var router: ProfileRouterInput?
    
    private func getCurrentUser() {
        let user = TokoinCoreData.shared.getCurrentUser()
        view?.didLoadContent(with: user)
    }
}

extension ProfileInteractor: ProfileInteractorInput {
    func didRegisterUser() {
        let user = TokoinCoreData.shared.getCurrentUser()
        view?.didLoadContent(with: user)
    }
}

extension ProfileInteractor: ProfileViewOutput {

    
    func viewDidLoad() {
       getCurrentUser()
    }
    
    func tappedRegisterButton() {
        router?.showRegisterViewController()
    }
}
