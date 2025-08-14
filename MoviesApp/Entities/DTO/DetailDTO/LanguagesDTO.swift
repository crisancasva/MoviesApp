//
//  LanguagesDTO.swift
//  MoviesApp
//
//  Created by Cristhian Andres Castano Vallejo on 6/08/25.
//

import Foundation

struct LanguagesDTO: Decodable {
    let english_name: String?
    let iso_639_1: String?
    let name: String?
}

extension LanguagesDTO {
    static var mock: LanguagesDTO {
        LanguagesDTO(english_name: "English",
                     iso_639_1: "en",
                     name: "English")
    }
}
