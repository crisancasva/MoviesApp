//
//  Favorite.swift
//  MoviesApp
//
//  Created by Cristhian Andres Castano Vallejo on 19/08/25.
//

import Foundation

struct Favorite: Identifiable, Equatable {
    let idi = UUID()
    let id: Int
    let title: String
    let poster: String
    let release_date: String
    
    init(dto: FavoriteDTO){
        self.id = dto.id ?? 0
        self.title = dto.title ?? ""
        self.poster = dto.poster ?? ""
        self.release_date = dto.release_date ?? "yyyy-mm-dd"
    }
    static func == (lhs: Favorite, rhs: Favorite) -> Bool {
        return lhs.id == rhs.id
        
    }
}
extension Favorite: MovieEntity {
 
    var posterPath: String? { poster }
    var releaseDate: String? { release_date}
    
    
}
