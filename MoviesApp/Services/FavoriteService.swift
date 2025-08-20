//
//  FavoriteService.swift
//  MoviesApp
//
//  Created by Cristhian Andres Castano Vallejo on 19/08/25.
//
// FavoriteService.swift

import Foundation
import Combine


protocol FavoriteServiceProtocol {
    func getFavorites() -> AnyPublisher<[FavoriteDTO], ServiceErrorDTO>
    func saveFavorite(movie: DetailMovie)
    func deleteFavorite(by id: Int)
    func isFavorite(by id: Int) -> Bool
    func searchMovies(by query: String) -> AnyPublisher<[FavoriteDTO], ServiceErrorDTO>
}

struct FavoriteService: FavoriteServiceProtocol {
      
    private let persistenceManager: CoreDataManager

    init(persistenceManager: CoreDataManager = .shared) {
        self.persistenceManager = persistenceManager
    }

    func getFavorites() -> AnyPublisher<[FavoriteDTO], ServiceErrorDTO> {
        return Future<[FavoriteDTO], ServiceErrorDTO> { promise in
            let movies = self.persistenceManager.fetchAllMovies()
            let favoriteDTOs = movies.map { movie in
                FavoriteDTO(id: Int(movie.id), title: movie.title ?? "", poster: movie.poster ?? "", release_date: movie.release_date ?? "")
            }
            promise(.success(favoriteDTOs))
        }
        .eraseToAnyPublisher()
    }

    func saveFavorite(movie: DetailMovie) {
        self.persistenceManager.saveMovie(movie)
    }

    func deleteFavorite(by id: Int) {
        self.persistenceManager.deleteMovie(by: id)
    }

    func isFavorite(by id: Int) -> Bool {
        self.persistenceManager.isMovieSaved(by: id)
    }
    func searchMovies(by query: String) -> AnyPublisher<[FavoriteDTO], ServiceErrorDTO>{
        return Future<[FavoriteDTO], ServiceErrorDTO> { promise in
                let movies = self.persistenceManager.searchMovies(by: query)
                let favoriteDTOs = movies.map { movie in
                    FavoriteDTO(id: Int(movie.id), title: movie.title ?? "", poster: movie.poster ?? "", release_date: movie.release_date ?? "")
                }
                promise(.success(favoriteDTOs))
            }
            .eraseToAnyPublisher()    }
}
