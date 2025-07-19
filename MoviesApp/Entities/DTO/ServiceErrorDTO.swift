//
//  ServiceErrorDTO.swift
//  MoviesApp
//
//  Created by Cristhian Andres Castano Vallejo on 15/07/25.
//

struct ServiceErrorDTO: Error {
    let errorMessage: String
    let statusCode: Int
    static var defaultError: ServiceErrorDTO {
        ServiceErrorDTO(errorMessage: "Servicio no disponible", statusCode: 0)
    }
}
