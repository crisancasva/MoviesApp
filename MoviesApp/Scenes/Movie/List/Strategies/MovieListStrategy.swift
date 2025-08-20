import Combine

protocol MovieListStrategy {
    associatedtype Movie: MovieEntity
    
    var columns: Int { get }
    var allowPullToRefresh: Bool { get }
    func getMovies() -> AnyPublisher<[Movie], ServiceError>
    func searchMovies(query: String) -> AnyPublisher<[Movie], ServiceError>
    
}

struct MovieListFromServiceStrategy: MovieListStrategy {
    typealias Movie = Results
    
    var columns: Int { 1 }
    private let interactor: MovieInteractorProtocol
    private let searchInteractor: SearchInteractorProtocol

    var allowPullToRefresh: Bool { true }
    
    init(interactor: MovieInteractorProtocol, searchInteractor: SearchInteractorProtocol) {
        self.interactor = interactor
        self.searchInteractor = searchInteractor
    }
    
    func getMovies() -> AnyPublisher<[Results], ServiceError> {
        self.interactor.list().eraseToAnyPublisher()
    }
    func searchMovies(query: String) -> AnyPublisher<[Results], ServiceError> {
        self.searchInteractor.search(query)
    }
  
}


struct MovieListFromDataBaseStrategy: MovieListStrategy {
    typealias Movie = Favorite
    
    var columns: Int { 2 }
    
    private let favoriteInteractor: FavoriteInteractorProtocol
    
    var allowPullToRefresh: Bool { false }
    
    init(favoriteInteractor: FavoriteInteractorProtocol) {
        self.favoriteInteractor = favoriteInteractor
    }
    
    func getMovies() -> AnyPublisher<[Movie], ServiceError> {
         self.favoriteInteractor.getFavorites()
       
    }
    func searchMovies(query: String) -> AnyPublisher<[Movie], ServiceError> {
        self.favoriteInteractor.searchMovies(query: query)
    }
    

}
