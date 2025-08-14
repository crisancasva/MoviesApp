//
//  SessionDTO.swift
//  MoviesApp
//
//  Created by Cristhian Andres Castano Vallejo on 25/07/25.
//

struct SessionDTO: Decodable {
    let token: String
    let name: String
    let lastName: String
}

extension SessionDTO {
    static var mock: SessionDTO {
        SessionDTO(token: "myToken",
                   name: "Mike",
                   lastName: "Castaño")
    }
}
