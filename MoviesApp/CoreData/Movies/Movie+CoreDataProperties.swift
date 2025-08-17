//
//  Movie+CoreDataProperties.swift
//  MoviesApp
//
//  Created by Cristhian Andres Castano Vallejo on 16/08/25.
//
//

import Foundation
import CoreData


extension Movie {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Movie> {
        return NSFetchRequest<Movie>(entityName: "Movie")
    }

    @NSManaged public var title: String?
    @NSManaged public var release_date: String?
    @NSManaged public var poster: String?
    @NSManaged public var id: Int64
    @NSManaged public var uuid: UUID?

}
