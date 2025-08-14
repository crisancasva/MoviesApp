//
//  ResultDTO.swift
//  MoviesApp
//
//  Created by Cristhian Andres Castano Vallejo on 19/07/25.
//

struct ResultsDTO: Decodable{
    
    let adult: Bool?
    let backdrop_path: String?
    let genre_ids: [Int]?
    let id : Int?
    let original_language : String?
    let original_title : String?
    let overview : String?
    let popularity : Double?
    let poster_path : String?
    let release_date : String?
    let title : String?
    let video: Bool?
    let vote_average: Double?
    let vote_count : Int?
    
}

extension ResultsDTO {
    static var mock: ResultsDTO{
        ResultsDTO(adult: false,
                   backdrop_path: "/rJjhOuRFldNF0OWSuSk4PiCLmeA.jpg",
                   genre_ids: [16,14,28,35,10402,10751],
                   id: 803796,
                   original_language: "en",
                   original_title: "KPop Demon Hunters",
                   overview: "Cuando no están llenando estadios, las superestrellas del K-pop Rumi, Mira y Zoey usan sus poderes secretos para proteger a sus fans de una amenaza sobrenatural.",
                   popularity: 213.0191,
                   poster_path: "/swQRKmW7RLhncPYHvM0RHz8b7bT.jpg",
                   release_date: "2025-06-20",
                   title: "Las guerreras k-pop",
                   video: false,
                   vote_average: 8.578,
                   vote_count: 663)
    }
}
