//
//  MovieEntity.swift
//  MoviesApp
//
//  Created by Cristhian Andres Castano Vallejo on 19/08/25.
//

import Combine

protocol MovieEntity: Identifiable {
    var id: Int { get }
    var title: String { get }
    var posterPath: String? { get }
    var releaseDate: String? { get }
}
