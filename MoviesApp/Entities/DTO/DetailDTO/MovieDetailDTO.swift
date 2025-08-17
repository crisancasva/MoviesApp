//
//  MovieDetailDTO.swift
//  MoviesApp
//
//  Created by Cristhian Andres Castano Vallejo on 6/08/25.
//

import Foundation

struct MovieDetailDTO: Decodable {
    
    let adult : Bool?
    let backdrop_path : String?
    let budget : Int?
    let genres : [GenresDTO]?
    let homepage : String?
    let id: Int?
    let imdb_id : String?
    let origin_country : [String]?
    let original_language: String?
    let original_title: String?
    let overview: String?
    let popularity: Double?
    let poster_path: String?
    let production_companies: [CompaniesDTO]?
    let production_countries: [ProductionCountriesDTO]?
    let release_date: String?
    let revenue: Int?
    let runtime: Int?
    let spoken_languages: [LanguagesDTO]?
    let status: String?
    let tagline: String?
    let title: String?
    let video: Bool?
    let vote_average: Double?
    let vote_count : Int?
    
}

extension MovieDetailDTO {
    static var mock: MovieDetailDTO {
        MovieDetailDTO(adult: false,
                       backdrop_path: "/l3ycQYwWmbz7p8otwbomFDXIEhn.jpg",
                       budget: 0,
                       genres: [GenresDTO.mock],
                       homepage: "https://www.netflix.com/es/title/81498621",
                       id: 803796,
                       imdb_id: "tt14205554",
                       origin_country: ["US"],
                       original_language: "en",
                       original_title: "KPop Demon Hunters",
                       overview: "Cuando no están llenando estadios, las superestrellas del K-pop Rumi, Mira y Zoey usan sus poderes secretos para proteger a sus fans de una amenaza sobrenatural.",
                       popularity: 1681142,
                       poster_path: "/swQRKmW7RLhncPYHvM0RHz8b7bT.jpg",
                       production_companies: [CompaniesDTO.mock],
                       production_countries: [ProductionCountriesDTO.mock],
                       release_date: "2025-06-20",
                       revenue: 0,
                       runtime: 96,
                       spoken_languages: [LanguagesDTO.mock],
                       status: "Released",
                       tagline: "",
                       title: "Las guerreras k-pop",
                       video: false,
                       vote_average: 8.452,
                       vote_count: 909)
    }
}
