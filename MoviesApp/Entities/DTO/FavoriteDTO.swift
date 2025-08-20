//
//  FavoriteDTO.swift
//  MoviesApp
//
//  Created by Cristhian Andres Castano Vallejo on 19/08/25.
//

struct FavoriteDTO {
    let id: Int?
    let title: String?
    let poster: String?
    let release_date: String?
}

extension FavoriteDTO{
    static var mock: FavoriteDTO{
        FavoriteDTO(id: 803796,
                    title: "KPop Demon Hunters",
                    poster: "/swQRKmW7RLhncPYHvM0RHz8b7bT.jpg",
                    release_date: "2025-06-20")
    }
}
