//
//  PokemonDetailViewModel.swift
//  Pokemons
//
//  Created by Rakhee Visakh on 27/05/23.
//

import Foundation
import UIKit

final class PokemonDetailViewModel {
    
    var apiHandler = APIHandler()
    var pokemonDetailList = [String]()
    var delegate: ViewModelDelegate?
    var imageLoader = ImageLoader()

    func fetchPokemonDetail(url: String) async -> PokemonDetails {
        delegate?.willLoadData()
        let pokemonDetail = try! await apiHandler.fetchPokemonDetail(urlString: url)
        print("Fetched pokemon's detail..\(pokemonDetail.name)")
        pokemonDetailList = ["Name: \(pokemonDetail.name.capitalized)", "Height: \(pokemonDetail.height)", "Weight: \(pokemonDetail.weight)", "Base experience: \(pokemonDetail.baseExperience)"]
        delegate?.didLoadData()
        return pokemonDetail
    }
    
    func fetchPokemonImage() async -> UIImage {
        delegate?.willLoadData()
        let image = try! await imageLoader.downloadImage(from: URL(string: Constants.IMAGE_URL)!)
        return image
        delegate?.didLoadData()
    }
}

