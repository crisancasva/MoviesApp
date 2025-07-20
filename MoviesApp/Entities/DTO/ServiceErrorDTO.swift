//
//  ServiceErrorDTO.swift
//  MoviesApp
//
//  Created by Cristhian Andres Castano Vallejo on 15/07/25.
//
import Combine
import Alamofire
import Foundation

struct ServiceErrorDTO: Error {
   
    let statusCode: Int
    static var defaultError: ServiceErrorDTO {
        ServiceErrorDTO(statusCode: 0)
    }
}

extension Publisher where Failure == Error {
    func mapServicesDTO() -> Publishers.MapError<Self, ServiceErrorDTO>{
        self.mapError { error in
            guard let error = error as? ServiceErrorDTO else {
                return ServiceErrorDTO(statusCode: 0)
            }
            return error
        }
    }
}
