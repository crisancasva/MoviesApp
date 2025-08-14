//
//  MovieDetailViewModel.swift
//  MoviesApp
//
//  Created by Cristhian Andres Castano Vallejo on 7/08/25.
//
//
import Foundation
import Combine

class MovieDetailViewModel: ObservableObject {
    @Published private(set) var status: GenericScrollStatus<DetailMovie> = .loading

    private let movieId : Int
    private let interactor: MovieInteractorProtocol
    private var task: AnyCancellable?
    
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
}
extension MovieDetailViewModel {
    private func getDetail() {
        self.task?.cancel()
        self.status = .loading
        self.task = self.interactor
            .getDetailTo(self.movieId)
            .receive(on: DispatchQueue.main)
            .sink {[weak self] completion in
                defer {self?.task = nil }
                if case .failure(let error) = completion {
                    self?.status = .error(message: error.errorMessage)
                }
            } receiveValue: { [weak self] movie in
                self?.status = .data(item: movie)
            }
    }
    
}
