//
//  ServiceError.swift
//  MoviesApp
//
//  Created by Cristhian Andres Castano Vallejo on 15/07/25.
//
import Combine

struct ServiceError: Error {
    
    let reason: Reason
    
    var errorMessage: String {
        self.messages[self.reason] ?? "Ocurrio un error en la peticion"
    }
    
    private let messages: [Reason: String] = [
        .badRequest: "Ocurrio un error en la peticion",
        .unauthorized: "La sesion no esta autorizzada",
        .forbidden: "no se puede trabajar",
        .notFound:  "no se encontro",
        .internalServiceError: "Error interno el sistema",
        .generic: "Ocurrio un error"
    ]
    
    init(dto: ServiceErrorDTO){
        
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

extension Publisher where Failure == ServiceErrorDTO {
    func mapServicesError() -> Publishers.MapError<Self, ServiceError>{
        self.mapError { error in
           ServiceError(dto: error)
        }
    }
}

