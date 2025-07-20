//
//  Results.swift
//  MoviesApp
//
//  Created by Cristhian Andres Castano Vallejo on 19/07/25.
//

import Foundation

struct Results: Identifiable {
    
    let idi = UUID()
    let adult: Bool
    let backdrop_path: String
    let genre_ids: [Int]
    let id : Int
    let original_language : String
    let original_title : String
    let overview : String
    let popularity : Double
    let poster_path : String
    let release_date : String
    let title : String
    let video: Bool
    let vote_average: Double
    let vote_count : Int
    
    var popularityFormat : String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.minimumFractionDigits = 1
        formatter.maximumFractionDigits = 2
        return formatter.string(from: NSNumber(value: self.popularity)) ?? "Sin especificar"
    }
    
    var voteAverageFormat : String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.minimumFractionDigits = 1
        formatter.maximumFractionDigits = 2
        return formatter.string(from: NSNumber(value: self.vote_average)) ?? "Sin especificar"
    }
    
    
    init(dto: ResultsDTO){
        
        self.adult = dto.adult ?? false
        self.backdrop_path = dto.backdrop_path ?? ""
        self.genre_ids = dto.genre_ids ?? []
        self.id = dto.id ?? 0
        self.original_language = dto.original_language ?? ""
        self.original_title = dto.original_title ?? ""
        self.overview = dto.overview ?? ""
        self.popularity = dto.popularity ?? 0.0
        self.poster_path = dto.poster_path ?? ""
        self.release_date = dto.release_date ?? ""
        self.title = dto.title ?? ""
        self.video = dto.video ?? false
        self.vote_average = dto.vote_average ?? 0.0
        self.vote_count = dto.vote_count ?? 0
        
        
        
    }
    
}
