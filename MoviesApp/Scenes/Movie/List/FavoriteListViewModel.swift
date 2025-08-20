//
//  FavoriteListViewModel.swift
//  MoviesApp
//
//  Created by Cristhian Andres Castano Vallejo on 16/08/25.
//
//
//import Foundation
//import Combine
//import CoreData
//
//class FavoriteListViewModel: ObservableObject {
//    
//    @Published private(set) var status: GenericListStatus<Movie> = .loading
//    @Published var searchText: String = ""
//    
//    private let favoriteInteractor: FavoriteInteractorProtocol
//    
//    init(favoriteInteractor: FavoriteInteractorProtocol) {
//        self.favoriteInteractor = favoriteInteractor
//    }
//}
//
//extension FavoriteListViewModel {
//    
//    func onAppear() {
//        self.fetchMovies()
//    }
//    func onSelectMovie(_ movie: Movie) {
//        NavigatorViewManager.shared.push(DetailView.build(Int(movie.id)))
//    }
//
//}
//
//
//extension FavoriteListViewModel {
//    
//    private func fetchMovies() {
//        let movies = self.favoriteInteractor.fetchLocalMovies()
//        let sortedMovies = movies.sorted { ($0.title ?? "") < ($1.title ?? "") }
//        
//        if sortedMovies.isEmpty {
//            self.status = .empty(message: "Aún no tienes películas favoritas.")
//        } else {
//            self.status = .data(items: sortedMovies)
//        }
//    }
//}
