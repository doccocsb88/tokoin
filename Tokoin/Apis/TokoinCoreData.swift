//
//  TokoinCoreData.swift
//  Tokoin
//
//  Created by Anh Hai on 2/18/20.
//  Copyright © 2020 Anh Hai. All rights reserved.
//

import Foundation
import CoreData
import UIKit
import RxSwift

class TokoinCoreData {
    enum Keys {
        static let currentUserName: String = "current_username"
    }
    
    static let shared = TokoinCoreData()
    let behaviorSubject = BehaviorSubject<[String]>(value: ["bitcoin", "apple", "earthquake", "animal"])
    func saveUser(username: String, sections: [String]) {
       guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let managedContext = appDelegate.persistentContainer.viewContext
        
       let user = User(context: managedContext)
        user.username = username
        
        var preferences:[Preference] = []
        for section in sections {
            let preference = Preference(context: managedContext)
            preference.section = section
            preferences.append(preference)
        }
        user.preferences = NSSet(array: preferences)
        let userDefault = UserDefaults.standard
        userDefault.set(username, forKey: Keys.currentUserName)
        do {
            try managedContext.save()
            
        } catch let error as NSError {
            userDefault.removeObject(forKey: Keys.currentUserName)
            print("Error \(error)")
        }
    }
    
    
    func getUser(by username: String) -> User? {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return nil}
        let managedContext = appDelegate.persistentContainer.viewContext
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "User")
        let predicate = NSPredicate(format: "username = %@", username)
        fetchRequest.predicate = predicate
        
        do {
            let result = try managedContext.fetch(fetchRequest) as! [User]
            
            for data in result {
                if let preferences = data.preferences?.compactMap({$0 as? Preference}) {
                    for preference in preferences {
                        print(preference.section)
                    }
                }
            }
            return result.first
        } catch {
            print("Error")
        }
        return nil
    }
    
    func getCurrentUser() -> Observable<User?> {
        return Observable<User?>.create { [weak self] observer in
            guard let this = self else { return Disposables.create()}
            let userDefault = UserDefaults.standard
            var user: User? = nil
            if let username = userDefault.string(forKey: Keys.currentUserName) {
                user =  this.getUser(by: username)
                if let user = user {
                    let sections = user.preferences?.allObjects.compactMap({$0 as? Preference}).map({return $0.section})
                    this.behaviorSubject.onNext(sections ?? [])
                }
            }
            observer.onNext(user)
            observer.onCompleted()
            return Disposables.create()
        }
    }
    
}
