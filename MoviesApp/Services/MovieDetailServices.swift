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

struct MovieDetailServices: MovieDetailServicesProtocol {
    
    func execute(_ idMovie: Int) -> AnyPublisher<MovieDetailDTO, ServiceErrorDTO> {
        let url = "https://api.themoviedb.org/3/movie/\(idMovie)?api_key=176de15e8c8523a92ff640f432966c9c&language=es"

        return AF.request(url, method: .get)
            .validate()
            .publishData()
            .tryMap { response in
                
                if let data = response.data {
                    _ = String(data: data, encoding: .utf8) 
                      
                    
                } else {
                    throw ServiceErrorDTO(statusCode: response.response?.statusCode ?? -1)
                }
                
                return try ServiceParse.decode(response) as MovieDetailDTO
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

