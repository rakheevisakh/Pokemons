//
//  ListResponseModel.swift
//  Pokemons
//
//  Created by Rakhee Visakh on 27/05/23.
//

struct ListResponseModel: Codable {
    let count: Int
    let results: [Pokemon]
    
    enum CodingKeys: String, CodingKey {
        case count
        case results
    }
}
