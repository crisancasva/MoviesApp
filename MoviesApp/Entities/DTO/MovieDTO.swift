//
//  MovieDTO.swift
//  MoviesApp
//
//  Created by Cristhian Andres Castano Vallejo on 19/07/25.
//
import Foundation


struct MovieDTO: Decodable{
    
    let page: Int?
    let results: [ResultsDTO]?
    let total_pages: Int?
    let total_results: Int?
    
    
    
}

extension MovieDTO {
    
    static var mock: MovieDTO{
        MovieDTO(page: 1,
                 results: [ResultsDTO.mock],
                 total_pages: 51482,
                 total_results: 1029638)
    }
}
