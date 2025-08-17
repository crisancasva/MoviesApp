//
//  CoredataManager.swift
//  MoviesApp
//
//  Created by Cristhian Andres Castano Vallejo on 15/08/25.
//

import Foundation
import CoreData

final class CoreDataManager {
    
    static let shared = CoreDataManager()
    
    private init() {}
    
    private let modelName: String = "MoviesApp"
   
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: modelName)
        container.loadPersistentStores { _, error in
            if let error = error as NSError? {
                fatalError("Error al cargar Core Data: \(error), \(error.userInfo)")
            }
        }
        return container
    }()
    
    var context: NSManagedObjectContext {
        return persistentContainer.viewContext
    }

    func saveContext() {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Error guardando en Core Data: \(nserror), \(nserror.userInfo)")
            }
        }
    }
    func saveMovie(id: Int64, uuid: UUID, title: String, release_date: String, poster: String) {
            let movie = Movie(context: context) // Crea una instancia de tu entidad 'Movie'
            movie.id = id
            movie.uuid = uuid
            movie.title = title
            movie.release_date = release_date
            movie.poster = poster
        

           // Llama a saveContext para guardar los cambios
           saveContext()
       }
}
