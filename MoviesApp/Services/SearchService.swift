//
//  SearchService.swift
//  MoviesApp
//
//  Created by Cristhian Andres Castano Vallejo on 14/08/25.
//

import Foundation
import Combine
import Alamofire

protocol SearchServiceProtocol {
    func execute(_ query: String) -> AnyPublisher<[ResultsDTO], ServiceErrorDTO>
}
struct SearchService: SearchServiceProtocol {
  
    func execute(_ query: String) -> AnyPublisher<[ResultsDTO], ServiceErrorDTO> {
        let urlString = "https://api.themoviedb.org/3/search/movie?api_key=176de15e8c8523a92ff640f432966c9c&language=es-ES&query=\(query)"
        
        return AF.request(urlString,
                          method: .get,
                          encoding: JSONEncoding.default)
            .publishData()
            .tryMap { responseData in
                let movieDTO: MovieDTO = try ServiceParse.decode(responseData)
                return movieDTO.results ?? []
            }
            .mapServicesErrorDTO()
            .eraseToAnyPublisher()
    }
    
}

struct SearchServiceMock: SearchServiceProtocol{
    func execute(_ query: String) -> AnyPublisher<[ResultsDTO], ServiceErrorDTO>{
        Future { promise in
            promise(.success([.mock,.mock,.mock,.mock]))
            
        }
        .delay(for: .seconds(2), scheduler: DispatchQueue.main)
        .eraseToAnyPublisher()
    }
}
struct SearchServicefailure: SearchServiceProtocol {
    func execute(_ query: String) -> AnyPublisher<[ResultsDTO], ServiceErrorDTO>{
        Future { promise in
            promise(.failure(.init(statusCode: 401)))
            
        }
        .delay(for: .seconds(2), scheduler: DispatchQueue.main)
        .eraseToAnyPublisher()
    }
}

