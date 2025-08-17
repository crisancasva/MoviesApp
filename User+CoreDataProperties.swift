//
//  User+CoreDataProperties.swift
//  MoviesApp
//
//  Created by Cristhian Andres Castano Vallejo on 15/08/25.
//
//

import Foundation
import CoreData


extension User {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<User> {
        return NSFetchRequest<User>(entityName: "User")
    }

    @NSManaged public var password: String?
    @NSManaged public var username: String?

}

extension User : Identifiable {

}
