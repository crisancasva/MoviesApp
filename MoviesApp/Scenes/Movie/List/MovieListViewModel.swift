//
//  MovieListViewModel.swift
//  MoviesApp
//
//  Created by Cristhian Andres Castano Vallejo on 24/07/25.
//
//import Foundation
//import Combine
//
//
//class MovieListViewModel: ObservableObject {
//    
//    @Published private(set) var status: GenericListStatus<Results> = .loading
//    @Published private(set) var isRefreshable = false
//    @Published var searchText: String = ""
//    @Published private var movies: [Results] = []
//    
//    private let interactor: MovieInteractorProtocol
//    private let searchInteractor: SearchInteractorProtocol
//    
//    private var task: AnyCancellable?
//    private var taskFiltered = Set<AnyCancellable>()
//    
//    
//    init(interactor: MovieInteractorProtocol, searchInteractor: SearchInteractorProtocol) {
//        self.interactor = interactor
//        self.searchInteractor = searchInteractor
//        self.filtered()
//    }
//    
//    deinit {
//        self.task?.cancel()
//        self.taskFiltered.removeAll()
//    }
//    
//}
//extension MovieListViewModel {
//    func onPullToRefresh(){
//        self.status = .loading
//    }
//    func onAppear() {
//        self.getAll()
//    }
//    func onSelectMovie(_ movie: Results) {
//        NavigatorViewManager.shared.push(DetailView.build(movie.id))
//    }
// 
//}
//
//extension MovieListViewModel{
//    private func getAll() {
//        self.task?.cancel()
//        self.status = .loading
//        self.task = self.interactor
//            .list()
//            .receive(on: DispatchQueue.main)
//            .sink {[weak self] completion in
//                defer {self?.task = nil }
//                if case .failure(let error) = completion {
//                    self?.status = .error(message: error.errorMessage)
//                }
//            } receiveValue: { [weak self] movies in
//                self?.movies = movies
//                self?.status = movies.isEmpty ? .empty(message: "Informacion no disponible") : .data(items: movies)
//            }
//    }
//    
//    private func filtered() {
//        $searchText
//                .debounce(for: .milliseconds(300), scheduler: DispatchQueue.main)
//                .removeDuplicates()
//                .flatMap { [weak self] query -> AnyPublisher<[Results], Never> in
//                    guard let self = self else { return Just([]).eraseToAnyPublisher() }
//                    if query.isEmpty {
//                        return self.interactor.list()
//                            .catch { _ in Just([]) }
//                            .eraseToAnyPublisher()
//                    } else {
//                        return self.searchInteractor.search(query)
//                            .catch { _ in Just([]) }
//                            .eraseToAnyPublisher()
//                    }
//                }
//                .sink { [weak self] movies in
//                    self?.status = movies.isEmpty
//                        ? .empty(message: "No se encontró la película: \(self?.searchText ?? "")")
//                        : .data(items: movies)
//                }
//                .store(in: &taskFiltered)
//    }
//}
//

