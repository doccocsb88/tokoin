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
class TokoinCoreData {
    
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
        do {
            try managedContext.save()
            
        } catch let error as NSError {
            print("Error \(error)")
        }
    }
    
    
    func getUser(by username: String) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
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
        } catch {
            print("Error")
        }
    }
}
