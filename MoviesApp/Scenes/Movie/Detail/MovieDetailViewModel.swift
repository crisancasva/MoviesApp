//
//  MovieDetailViewModel.swift
//  MoviesApp
//
//  Created by Cristhian Andres Castano Vallejo on 7/08/25.
//
//
import Foundation
import Combine
import CoreData

class MovieDetailViewModel: ObservableObject {
    @Published private(set) var status: GenericScrollStatus<DetailMovie> = .loading
    @Published var isFavorite: Bool = false
    
    private let movieId : Int
    private let interactor: MovieInteractorProtocol
    private var task: AnyCancellable?
    private let coreDataManager = FavoriteService()
    
    init(movieId: Int, interactor: MovieInteractorProtocol) {
        self.movieId = movieId
        self.interactor = interactor
    }
    
    deinit{
        self.task?.cancel()
    }
}
extension MovieDetailViewModel {
    func onPullToRefresh() {
        self.status = .loading
        self.getDetail()
    }
    func onAppear() {
        self.getDetail()
    }
    func toggleFavorite() {
        if isFavorite {
            if case let .data(movie) = status {
                let dto = movie
                coreDataManager.saveFavorite(movie: dto)
            } else {

                print("No se puede guardar la película, el estado no es .data")
            }
            
        } else {
            coreDataManager.deleteFavorite(by: movieId)
        }
    }
}
extension MovieDetailViewModel {
    private func getDetail() {
        self.task?.cancel()
        self.status = .loading
        self.task = self.interactor
            .getDetailTo(self.movieId)
            .receive(on: DispatchQueue.main)
            .sink {[weak self] completion in
                defer { self?.task = nil }
                if case .failure(let error) = completion {
                    self?.status = .error(message: error.errorMessage)
                    print(error.errorMessage)
                }
            } receiveValue: { [weak self] movie in
                self?.status = .data(item: movie)
                self?.isFavorite = self?.coreDataManager.isFavorite(by: movie.id) ?? false
                
            }
    }
}
