//
//  CoredataManager.swift
//  MoviesApp
//
//  Created by Cristhian Andres Castano Vallejo on 15/08/25.
//
// CoreDataManager.swift

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
    
  
    func fetchAllMovies() -> [Movie] {
        let fetchRequest: NSFetchRequest<Movie> = Movie.fetchRequest()
        do {
            return try context.fetch(fetchRequest)
        } catch {
            print("❌ Error fetching movies: \(error)")
            return []
        }
    }

    func saveMovie(_ movie: DetailMovie) {
        let newMovie = Movie(context: context)
        newMovie.id = Int64(movie.id)
        newMovie.title = movie.title
        newMovie.release_date = movie.releaseDateShortFormat
        newMovie.poster = movie.poster_path
        saveContext()
    }

    func deleteMovie(by id: Int) {
        let fetchRequest: NSFetchRequest<Movie> = Movie.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "id == %d", id)
        do {
            let moviesToDelete = try context.fetch(fetchRequest)
            if let movie = moviesToDelete.first {
                context.delete(movie)
                saveContext()
            }
        } catch {
            print("Error deleting movie: \(error)")
        }
    }

    func isMovieSaved(by id: Int) -> Bool {
        let fetchRequest: NSFetchRequest<Movie> = Movie.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "id == %d", id)
        do {
            let count = try context.count(for: fetchRequest)
            return count > 0
        } catch {
            print("Error checking if movie is saved: \(error)")
            return false
        }
    }
    func searchMovies(by title: String) -> [Movie] {
        let fetchRequest: NSFetchRequest<Movie> = Movie.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "title CONTAINS[c] %@", title)
        let sortDescriptor = NSSortDescriptor(key: "title", ascending: true)
        fetchRequest.sortDescriptors = [sortDescriptor]
        do {
             return try context.fetch(fetchRequest)
        } catch {
            print("❌ Error al buscar películas: \(error)")
            return []
        }
    }
}
