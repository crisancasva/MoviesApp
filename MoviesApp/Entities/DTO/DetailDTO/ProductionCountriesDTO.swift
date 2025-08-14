//
//  ProductionCountriesDTO.swift
//  MoviesApp
//
//  Created by Cristhian Andres Castano Vallejo on 6/08/25.
//

import Foundation

struct ProductionCountriesDTO: Decodable {
    let iso_3166_1: String?
    let name: String?
}

extension ProductionCountriesDTO {
    static var mock: ProductionCountriesDTO {
        ProductionCountriesDTO(iso_3166_1: "US",
                               name: "United States of America")
    }
}
