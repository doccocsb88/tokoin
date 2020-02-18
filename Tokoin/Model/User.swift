//
//  User.swift
//  Tokoin
//
//  Created by Anh Hai on 2/18/20.
//  Copyright © 2020 Anh Hai. All rights reserved.
//

import Foundation
import CoreData

@objc(User)
class User: NSManagedObject {
    @NSManaged var username: String
    @NSManaged var preferences: NSSet?
}
