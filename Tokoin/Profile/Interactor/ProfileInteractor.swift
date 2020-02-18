//
//  ProfileInteractor.swift
//  Tokoin
//
//  Created by Anh Hai on 2/17/20.
//  Copyright © 2020 Anh Hai. All rights reserved.
//

import Foundation
import RxSwift

protocol ProfileInteractorInput: class {
    func didRegisterUser()
}

class ProfileInteractor {
    
    var view: ProfileViewInput?
    var router: ProfileRouterInput?
    private let disposeBag = DisposeBag()
    
    private func getCurrentUser() {
      TokoinCoreData.shared.getCurrentUser()
        .observeOn(MainScheduler.instance)
        .subscribe(onNext: {[weak self] user in
          guard let this = self else { return }
            this.view?.didLoadContent(with: user)
        }).disposed(by: disposeBag)
    }
}

extension ProfileInteractor: ProfileInteractorInput {
    func didRegisterUser() {
        getCurrentUser()
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
