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
        
        self.reason = Reason(rawValue: dto.statusCode) ?? .generic
        self.errorMessage = self.reason.message
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
        
        var message : String {
            switch self {
            case .badRequest:
                "Ocurrio un error en la peticion"
            case .unauthorized:
                "La sesion no esta autorizzada"
            case .forbidden:
                "nose puede trabajar"
            case .notFound:
                "no se encontro"
            case .internalServiceError:
                "Error interno el sistema"
            case .generic:
                "Ocurrio un error"
            }
        }
    }
    
}
