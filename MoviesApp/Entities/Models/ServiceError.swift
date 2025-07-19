//
//  ServiceError.swift
//  MoviesApp
//
//  Created by Cristhian Andres Castano Vallejo on 15/07/25.
//

struct ServiceError: Error {
    let errorMessage: String
    let reason: Reason
    init(dto: ServiceErrorDTO){
        self.errorMessage = dto.errorMessage
        self.reason = Reason(rawValue: dto.statusCode) ?? .generic
    }
    
}
extension ServiceError {
    enum Reason: Int {
        case badRequest = 400
        case unauthorized = 401
        case forbidden = 402
        case notFound = 404
        case internalServiceError = 500
        case generic = 0
    }
}
