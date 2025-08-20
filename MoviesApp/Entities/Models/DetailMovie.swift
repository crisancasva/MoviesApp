//
//  DetailMovie.swift
//  MoviesApp
//
//  Created by Cristhian Andres Castano Vallejo on 6/08/25.
//

import Foundation
import SwiftUICore

struct DetailMovie: Identifiable, Equatable {
    let idD = UUID()
    let adult : Bool
    let backdrop_path : String
    let budget : Int
    let genres : [GenresDTO]
    let homepage : String
    let id: Int
    let imdb_id : String
    let origin_country : [String]
    let original_language: String
    let original_title: String
    let overview: String
    let popularity: Double
    let poster_path: String
    let production_companies: [CompaniesDTO]
    let production_countries: [ProductionCountriesDTO]
    private let release_date: Date?
    let revenue: Int
    let runtime: Int
    let spoken_languages: [LanguagesDTO]
    let status: String
    let tagline: String
    let title: String
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
    
    func formattedGenresView() -> some View {
        TextCaption(text: self.genres.compactMap { $0.name }.joined(separator: " • "))
                .foregroundColor(.neutral1000)
                .padding(.top, 5)
                .padding(.horizontal, Spacing._lg)
    }
    var formattedOverview: some View {
        TextCaption(text: self.overview, color: .neutral1000)
            .lineLimit(nil)
            .lineSpacing(5)
            .padding(.horizontal, Spacing._lg)
            .padding(.top, 5) //
            .fixedSize(horizontal: false, vertical: true)
    }
    
    init(dto: MovieDetailDTO){
        
        self.adult = dto.adult ?? false
        self.backdrop_path = dto.backdrop_path ?? ""
        self.budget = dto.budget ?? 0
        self.genres = dto.genres ?? []
        self.homepage = dto.homepage ?? ""
        self.id = dto.id ?? 0
        self.imdb_id = dto.imdb_id ?? ""
        self.origin_country = dto.origin_country ?? []
        self.original_language = dto.original_language ?? ""
        self.original_title = dto.original_title ?? ""
        self.overview = dto.overview ?? ""
        self.popularity = dto.popularity ?? 0
        self.poster_path = dto.poster_path ?? ""
        self.production_companies = dto.production_companies ?? []
        self.production_countries = dto.production_countries ?? []
        self.release_date = dto.release_date?.toDateWith("yyyy-mm-dd")
        self.revenue = dto.revenue ?? 0
        self.runtime = dto.runtime ?? 0
        self.spoken_languages = dto.spoken_languages ?? []
        self.status = dto.status ?? ""
        self.tagline = dto.tagline ?? ""
        self.title = dto.title ?? ""
        self.video = dto.video ?? false
        self.vote_average = dto.vote_average ?? 0.0
        self.vote_count = dto.vote_count ?? 0
        
        
        
    }
    static func == (lhs: DetailMovie, rhs: DetailMovie) -> Bool {
        return lhs.id == rhs.id
        
    }
    
}
