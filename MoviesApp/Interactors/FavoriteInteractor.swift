//
//  FavoriteInteractor.swift
//  MoviesApp
//
//  Created by Cristhian Andres Castano Vallejo on 16/08/25.
//

import Foundation
import Combine
import CoreData


protocol FavoriteInteractorProtocol {
    func isFavorite(id: Int) -> Bool
    func saveFavorite(movies: DetailMovie)
    func deleteFavorite(by id: Int)
    func getFavorites() -> AnyPublisher<[Favorite], ServiceError>
    func searchMovies(query: String) -> AnyPublisher<[Favorite], ServiceError>
}

struct FavoriteInteractor: FavoriteInteractorProtocol {
          
    private let coreDataManager: FavoriteService
    
    init(coreDataManager: FavoriteService) {
        self.coreDataManager = coreDataManager
    }
    
    func isFavorite(id: Int) -> Bool {
        return self.coreDataManager.isFavorite(by: id)
    }
    
    func saveFavorite(movies: DetailMovie) {
        self.coreDataManager.saveFavorite(movie: movies)
    }
    
    func deleteFavorite(by id: Int) {
        self.coreDataManager.deleteFavorite(by: id)
    }
    
    func getFavorites() -> AnyPublisher<[Favorite], ServiceError> {
//        return self.coreDataManager.getFavorites()
        self.coreDataManager
            .getFavorites()
            .map({ arrayFavoriteDTO in
                arrayFavoriteDTO.map({ favoritetDTO in
                    Favorite(dto: favoritetDTO)
                })
            })
            .map({ favorites in
                 return favorites.sorted { ($0.title) < ($1.title) }
                })
            .mapServicesError()
            .eraseToAnyPublisher()
  
    }
    func searchMovies(query: String) -> AnyPublisher<[Favorite], ServiceError> {
        self.coreDataManager
            .searchMovies(by: query)
            .map({ arrayFavoriteDTO in
                arrayFavoriteDTO.map({ favoriteDTO in
                    Favorite(dto: favoriteDTO)
                })
            })
            .map({favorites in
                return favorites.sorted { ($0.title) < ($1.title)}
                })
            .mapServicesError()
            .eraseToAnyPublisher()
    }
   
}

extension FavoriteInteractor {
    static func build(_ typeData: TypeData) -> FavoriteInteractor {
        switch typeData {
        case .real:
            FavoriteInteractor(coreDataManager: FavoriteService())
        case .mock:
            FavoriteInteractor(coreDataManager: FavoriteService())
        }
    }
}

