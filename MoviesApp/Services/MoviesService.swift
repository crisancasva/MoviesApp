//
//  MoviesService.swift
//  MoviesApp
//
//  Created by Cristhian Andres Castano Vallejo on 19/07/25.
//

import Foundation
import Combine

protocol MoviesServiceProtocol {
    func execute() -> AnyPublisher<[ResultsDTO], ServiceErrorDTO>
}

struct MoviesService: MoviesServiceProtocol {
    func execute() -> AnyPublisher<[ResultsDTO], ServiceErrorDTO>{
        Future { promise in
            promise(.success(()))
            
        }
        .delay(for: .seconds(2), scheduler: DispatchQueue.main)
        .eraseToAnyPublisher()
    }
}


struct MoviesServiceMock: MoviesServiceProtocol {
    func execute() -> AnyPublisher<[ResultsDTO], ServiceErrorDTO>{
        Future { promise in
            promise(.success([.mock,.mock,.mock,.mock]))
            
        }
        .delay(for: .seconds(2), scheduler: DispatchQueue.main)
        .eraseToAnyPublisher()
    }
}
