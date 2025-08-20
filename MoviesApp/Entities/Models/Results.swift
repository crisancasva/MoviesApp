//
//  Results.swift
//  MoviesApp
//
//  Created by Cristhian Andres Castano Vallejo on 19/07/25.
//

import Foundation

struct Results: Identifiable, Equatable {
    
    let idi = UUID()
    let adult: Bool
    let backdrop_path: String
    let genre_ids: [Int]
    let id : Int
    let original_language : String
    let original_title : String
    let overview : String
    let popularity : Double
    private let poster_path : String
    private let release_date : Date?
    let title : String
    let video: Bool
    let vote_average: Double
    let vote_count : Int
    
    let urlImg = "https://image.tmdb.org/t/p/w500"
    
    var urlBackdrop_path : URL? {
        if !backdrop_path.isEmpty {
            return URL(string : "\(self.urlImg)\(self.backdrop_path)")
        }
        return nil
    }
    
    var urlPoster_path : URL? {
        if !poster_path.isEmpty {
            return URL(string: "\(self.urlImg)\(self.poster_path)")
        }
        return nil
    }
    
    
    
    var popularityFormat : String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.minimumFractionDigits = 1
        formatter.maximumFractionDigits = 2
        return formatter.string(from: NSNumber(value: self.popularity)) ?? "Sin especificar"
    }
    var urlPoster: URL? {
        URL(string: self.poster_path)
    }
    var releaseDateShortFormat: String {
        self.release_date?.toStringWith("dd MMM 'del' yyyy") ?? "Proximamente"
    }
    
    var releaseDateFullFormat: String {
        self.release_date?.toStringWith("EEEE 'de' MMMM 'del' yyyy") ?? "Proximamente"
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
        self.release_date = dto.release_date?.toDateWith("yyyy-mm-dd")
        self.title = dto.title ?? ""
        self.video = dto.video ?? false
        self.vote_average = dto.vote_average ?? 0.0
        self.vote_count = dto.vote_count ?? 0
        
        
        
    }
    static func == (lhs: Results, rhs: Results) -> Bool {
        return lhs.id == rhs.id
        
    }
}

extension Results: MovieEntity {
    var posterPath: String? {
        poster_path    }
    
    var releaseDate: String? {
        releaseDateShortFormat    }
    
    
}
