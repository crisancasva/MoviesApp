//
//  MovieInteractor.swift
//  MoviesApp
//
//  Created by Cristhian Andres Castano Vallejo on 19/07/25.
//
import Combine

protocol MovieInteractorProtocol {
    func list() -> AnyPublisher<>
}
struct MovieInteractor:
