//
//  MoviesService.swift
//  MoviesApp
//
//  Created by Cristhian Andres Castano Vallejo on 19/07/25.
//

import Foundation
import Combine
import Alamofire

protocol MoviesServiceProtocol {
    func execute() -> AnyPublisher<[MovieDTO], ServiceErrorDTO>
}

struct MoviesService: MoviesServiceProtocol {
    private var  url : String {
        "https://api.themoviedb.org/3/movie/popular?api_key=176de15e8c8523a92ff640f432966c9c&language=es"
    }
    func execute() -> AnyPublisher<[MovieDTO], ServiceErrorDTO>{
        
        AF.request(self.url,
                   method: .get,
                   encoding: JSONEncoding.default)
        .publishData()

        .tryMap { responseData in
            try serviceParse.decode(responseData)
        }
        .mapServicesDTO()
        .eraseToAnyPublisher()
    }
}


struct MoviesServiceMock: MoviesServiceProtocol {
    func execute() -> AnyPublisher<[MovieDTO], ServiceErrorDTO>{
        Future { promise in
            promise(.success([.mock,.mock,.mock,.mock]))
            
        }
        .delay(for: .seconds(2), scheduler: DispatchQueue.main)
        .eraseToAnyPublisher()
    }
}
