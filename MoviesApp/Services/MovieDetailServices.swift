//
//  MovieDetailServices.swift
//  MoviesApp
//
//  Created by Cristhian Andres Castano Vallejo on 5/08/25.
//


import Foundation
import Combine
import Alamofire

protocol MovieDetailServicesProtocol {
    func execute(_ idMovie: Int) -> AnyPublisher<MovieDetailDTO, ServiceErrorDTO>
}

struct MovieDetailServices: MovieDetailServicesProtocol  {
    private var  url : String {
        "https://api.themoviedb.org/3/movie/803796?api_key=176de15e8c8523a92ff640f432966c9c&language=es"
    }
    func execute(_ idMovie: Int) -> AnyPublisher<MovieDetailDTO, ServiceErrorDTO>{
        
        AF.request(self.url,
                   method: .get,
                   encoding: JSONEncoding.default)
        .publishData()

        .tryMap { responseData in
            try serviceParse.decode(responseData)
        }
        .mapServicesErrorDTO()
        .eraseToAnyPublisher()
    }
}


struct MovieDetailServicesMock: MovieDetailServicesProtocol {
    func execute(_ idMovie: Int) -> AnyPublisher<MovieDetailDTO, ServiceErrorDTO>{
        Future { promise in
            promise(.success(.mock))
            
        }
        .delay(for: .seconds(2), scheduler: DispatchQueue.main)
        .eraseToAnyPublisher()
    }
}
struct MovieDetailServiceMockFailure: MovieDetailServicesProtocol {
    func execute(_ idMovie: Int) -> AnyPublisher<MovieDetailDTO, ServiceErrorDTO>{
        Future { promise in
            promise(.failure(.init(statusCode: 401)))
            
        }
        .delay(for: .seconds(2), scheduler: DispatchQueue.main)
        .eraseToAnyPublisher()
    }
}

