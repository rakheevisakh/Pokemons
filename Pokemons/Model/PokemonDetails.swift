//
//  PokemonDetails.swift
//  Pokemons
//
//  Created by Rakhee Visakh on 27/05/23.
//

import Foundation

struct PokemonDetails: Codable {
    let abilities: [Ability]
    let baseExperience: Int
    let height: Int
    let weight: Int
    let id: Int
    let locationAreaEncounters: String
    let name: String
    let order: Int
    let species: Species
    let sprites: Sprites

    enum CodingKeys: String, CodingKey {
        case abilities
        case baseExperience = "base_experience"
        case height
        case id
        case locationAreaEncounters = "location_area_encounters"
        case name, order
        case species, sprites, weight
    }
    
    // MARK: - Ability
    struct Ability: Codable {
        let ability: Species
        let isHidden: Bool
        let slot: Int

        enum CodingKeys: String, CodingKey {
            case ability
            case isHidden = "is_hidden"
            case slot
        }
    }

    // MARK: - Species
    struct Species: Codable {
        let name: String
        let url: String
    }
    
    // MARK: - Sprites
    struct Sprites: Codable {
        let backDefault: String
        let backShiny: String
        let frontDefault: String
        let frontShiny: String
        
        enum CodingKeys: String, CodingKey {
            case backDefault = "back_default"
            case backShiny = "back_shiny"
            case frontDefault = "front_default"
            case frontShiny = "front_shiny"
        }
    }
}

