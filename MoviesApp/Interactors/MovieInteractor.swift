//
//  MovieInteractor.swift
//  MoviesApp
//
//  Created by Cristhian Andres Castano Vallejo on 19/07/25.
//
import Combine


protocol MovieInteractorProtocol {
    func list() -> AnyPublisher<[Results], ServiceError>
    func getDetailTo(_ movieId: Int) -> AnyPublisher<DetailMovie,ServiceError>
}

struct MovieInteractor: MovieInteractorProtocol {
    
    private let moviesService : MoviesServiceProtocol
    private let movieDetailServices : MovieDetailServicesProtocol
    
    
    init (moviesService: MoviesServiceProtocol, movieDetailServices: MovieDetailServicesProtocol) {
        self.moviesService = moviesService
        self.movieDetailServices = movieDetailServices
    }
    func list() -> AnyPublisher<[Results], ServiceError>{
        self.moviesService
            .execute()
            .map({ arrayResultsDTO in
                    arrayResultsDTO.map({ resultDTO in
                    Results(dto: resultDTO)
                })
            })
            .mapServicesError()
            .eraseToAnyPublisher()
    }
    
    func getDetailTo(_ movieId: Int) -> AnyPublisher<DetailMovie, ServiceError> {
        print("🎯 [getDetailTo] Solicitando detalle para movieId: \(movieId)")
        
        return self.movieDetailServices
            .execute(movieId)
            .map { dto in
                print("✅ [getDetailTo] DTO recibido: \(dto)")
                return DetailMovie(dto: dto)
            }
            .mapServicesError()
            .eraseToAnyPublisher()
    }
}


extension MovieInteractor {
    static func build(_ typeData: TypeData) -> MovieInteractor {
        switch typeData {
        case .real:
            MovieInteractor(moviesService: MoviesService(), movieDetailServices: MovieDetailServices())
        case .mock:
            MovieInteractor(moviesService: MoviesServiceMock(), movieDetailServices: MovieDetailServicesMock())
        }
    }
}

