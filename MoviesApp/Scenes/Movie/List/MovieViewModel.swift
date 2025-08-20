//
//  MoviesViewModel.swift
//  MoviesApp
//
//  Created by Cristhian Andres Castano Vallejo on 17/08/25.
//


import Foundation
import Combine


class MovieViewModel<Strategy: MovieListStrategy>: ObservableObject {
    
    @Published private(set) var status: GenericListStatus<Strategy.Movie> = .loading
    @Published private(set) var columns: Int
    @Published private(set) var isRefreshable = false
    @Published var searchText: String = ""
    @Published private var movies: [Strategy.Movie] = []
    
    private let strategy: Strategy
       
    private var task: AnyCancellable?
    private var taskFiltered = Set<AnyCancellable>()
    
    
    init(strategy: Strategy) {
        self.strategy = strategy
        self.isRefreshable = strategy.allowPullToRefresh
        self.columns = strategy.columns
        self.filtered()
    }
    
    deinit {
        self.task?.cancel()
        self.taskFiltered.removeAll()
    }
    
}
extension MovieViewModel {
    func onPullToRefresh(){
        self.status = .loading
    }
    func onAppear() {
        self.getAll()
    }
    func onSelectMovie(_ movie: Strategy.Movie) {
        NavigatorViewManager.shared.push(DetailView.build(movie.id))
    }
 
}

extension MovieViewModel{
    private func getAll() {
        self.task?.cancel()
        self.status = .loading
        self.task = self.strategy
            .getMovies()
            .receive(on: DispatchQueue.main)
            .sink {[weak self] completion in
                defer {self?.task = nil }
                if case .failure(let error) = completion {
                    self?.status = .error(message: error.errorMessage)
                }
            } receiveValue: { [weak self] movies in
                self?.movies = movies
                self?.status = movies.isEmpty ? .empty(message: "Informacion no disponible") : .data(items: movies)
            }
    }
    
    private func filtered() {
        $searchText
            .debounce(for: .milliseconds(300), scheduler: DispatchQueue.main)
            .removeDuplicates()
            .flatMap { [weak self] query -> AnyPublisher<[Strategy.Movie], ServiceError> in
                guard let self = self else {
                    return Just<[Strategy.Movie]>([])
                        .setFailureType(to: ServiceError.self)
                        .eraseToAnyPublisher()
                }
                if query.isEmpty {
                                return self.strategy.getMovies()
                            } else {
                                return self.strategy.searchMovies(query: query)
                            }
            }
            .receive(on: DispatchQueue.main)
            .sink { [weak self] completion in
                if case .failure(let error) = completion {
                    self?.status = .error(message: error.errorMessage)
                }
            } receiveValue: { [weak self] movies in
                self?.movies = movies
                self?.status = (movies).isEmpty
                ? .empty(message: "No se encontró la película: \(self?.searchText ?? "")")
                : .data(items: movies)
            }
            .store(in: &taskFiltered)
    }
}

