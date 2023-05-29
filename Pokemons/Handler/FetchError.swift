//
//  FetchError.swift
//  Pokemons
//
//  Created by Rakhee Visakh on 27/05/23.
//

import Foundation

enum FetchError: Error {
    case badURL
    case badResponse
    case badData
}
