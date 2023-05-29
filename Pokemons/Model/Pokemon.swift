//
//  Pokemon.swift
//  Pokemons
//
//  Created by Rakhee Visakh on 27/05/23.
//

struct Pokemon: Codable {
        let name: String
        let url: String
    
    enum CodingKeys: String, CodingKey {
        case name
        case url
    }
}
