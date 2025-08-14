//
//  GenresDTO.swift
//  MoviesApp
//
//  Created by Cristhian Andres Castano Vallejo on 6/08/25.
//

import Foundation

struct GenresDTO: Decodable {
    let id: Int?
    let name: String?
}

extension GenresDTO {
    static var mock: GenresDTO {
        GenresDTO(id: 16,
                  name: "Animacion")
    }
}
