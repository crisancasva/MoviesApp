//
//  CompaniesDTO.swift
//  MoviesApp
//
//  Created by Cristhian Andres Castano Vallejo on 6/08/25.
//

import Foundation

struct CompaniesDTO: Decodable {
    let id: Int?
    let logo_path: String?
    let name: String?
    let origin_country: String?
}

extension CompaniesDTO {
    static var mock: CompaniesDTO {
        CompaniesDTO(id: 2251,
                     logo_path: "/5ilV5mH3gxTEU7p5wjxptHvXkyr.png",
                     name: "Sony Pictures Animation",
                     origin_country: "US")
    }
}
