//
//  ViewErrorHandler.swift
//  MoviesApp
//
//  Created by Cristhian Andres Castano Vallejo on 15/07/25.
//


protocol ViewErrorHandler {
    func execute(_ error: ServiceError)
}

struct LoginErrorHandler: ViewErrorHandler {
    func execute(_ error: ServiceError) {
        switch error.reason {
        case .badRequest:
            print("badRequest")
        case .unauthorized:
            print("unauthorized")
        case .forbidden:
            print("forbidden")
        case .notFound:
            print("notFound")
        case .internalServiceError:
            print("internalServiceError")
        case .generic:
            print("generic")
        }
    }
}

struct GenericErrorHandler: ViewErrorHandler {
    func execute(_ error: ServiceError) {
        switch error.reason {
        case .badRequest:
            print("badRequest")
        case .unauthorized:
            print("unauthorized")
        case .forbidden:
            print("forbidden")
        case .notFound:
            print("notFound")
        case .internalServiceError:
            print("internalServiceError")
        case .generic:
            print("generic")
        }
    }
}

struct CarDetailErrorHandler: ViewErrorHandler {
    func execute(_ error: ServiceError) {
        switch error.reason {
        case .badRequest:
            print("badRequest")
        case .unauthorized:
            print("unauthorized")
        case .forbidden:
            print("forbidden")
        case .notFound:
            print("notFound")
        case .internalServiceError:
            print("internalServiceError")
        case .generic:
            print("generic")
        }
    }
}
