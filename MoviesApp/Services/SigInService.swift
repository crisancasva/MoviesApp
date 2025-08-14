//
//  SigInService.swift
//  MoviesApp
//
//  Created by Cristhian Andres Castano Vallejo on 9/08/25.
//


import Foundation
import Combine

protocol SignInServiceProtocol {
    func executeWith(_ params: LoginServiceInput) -> AnyPublisher<SessionDTO, ServiceErrorDTO>
}

struct SignInService: SignInServiceProtocol {
    func executeWith(_ params: LoginServiceInput) -> AnyPublisher<SessionDTO, ServiceErrorDTO> {
        Future { promise in
            promise(.success(.mock))
        }
        .delay(for: .seconds(2), scheduler: DispatchQueue.main)
        .eraseToAnyPublisher()
    }
}

struct SignInServiceMock: SignInServiceProtocol {
    func executeWith(_ params: LoginServiceInput) -> AnyPublisher<SessionDTO, ServiceErrorDTO> {
        Future { promise in
            promise(.success(.mock))
        }
        .delay(for: .seconds(2), scheduler: DispatchQueue.main)
        .eraseToAnyPublisher()
    }
}

struct SignInServiceErrorMock: SignInServiceProtocol {
    func executeWith(_ params: LoginServiceInput) -> AnyPublisher<SessionDTO, ServiceErrorDTO> {
        Future { promise in
            promise(.failure(.defaultError))
        }
        .delay(for: .seconds(2), scheduler: DispatchQueue.main)
        .eraseToAnyPublisher()
    }
}
