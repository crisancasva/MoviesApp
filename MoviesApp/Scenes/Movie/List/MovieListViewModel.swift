//
//  CarListViewModel.swift
//  MoviesApp
//
//  Created by Cristhian Andres Castano Vallejo on 24/07/25.
//
import Foundation
import Combine


class MovieListViewModel: ObservableObject {
    
    @Published private(set) var status: GenericListStatus<Results> = .loading
    @Published private(set) var isRefreshable = false
    @Published var searchText: String = ""
    @Published private var movies: [Results] = []
    
    private let interactor: MovieInteractorProtocol
    private var task: AnyCancellable?
    private var taskFiltered = Set<AnyCancellable>()
    
    
    init(interactor: MovieInteractorProtocol) {
        self.interactor = interactor
        self.filtered()
    }
    
    deinit {
        self.task?.cancel()
        self.taskFiltered.removeAll()
    }
    
}
extension MovieListViewModel {
    func onPullToRefresh(){
        self.status = .loading
    }
    func onAppear() {
        self.getAll()
    }
    func onSelectMovie(_ movie: Results) {
        NavigatorViewManager.shared.push(DetailView.build(movie.id))
    }
 
}

extension MovieListViewModel{
    private func getAll() {
        self.task?.cancel()
        self.status = .loading
        self.task = self.interactor
            .list()
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
        Publishers.CombineLatest($movies, $searchText)
         
            .drop(while: { [weak self] _ in
                self?.status == .loading
            })
            .map { list, query -> [Results] in
                guard !query.isEmpty else {return list}
                return list.filter { $0.original_title.replacingOccurrences(of: " ", with: "")
                    .localizedCaseInsensitiveContains(query) }
            }

            .sink { [weak self] moviesFiltered in
                self?.status = moviesFiltered.isEmpty ? .empty(message: "No se encontro la pelicula: \n\(self?.searchText ?? "")") : .data(items: moviesFiltered)
            }
            .store(in: &taskFiltered)
    }
}


