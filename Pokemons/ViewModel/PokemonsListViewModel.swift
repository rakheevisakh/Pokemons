//
//  PokemonsListViewModel.swift
//  Pokemons
//
//  Created by Rakhee Visakh on 27/05/23.
//

import UIKit

@objc protocol ViewModelDelegate {
    func willLoadData()
    func didLoadData()
    @objc optional func isNextPageAvailable(available: Bool)
}

final class PokemonsListViewModel {
    
    var apiHandler = APIHandler()
    var pokemonsList = [Pokemon]()
    var totalCount = 0
    private var pageNumber = 0
    private var isNextPageAvailable: Bool = false
    var delegate: ViewModelDelegate?
    
    func fetchPokemonsList() async -> [Pokemon] {
        delegate?.willLoadData()
        do {
            let response = try await apiHandler.fetchPokemons(pageNumber: pageNumber)
            pokemonsList += response.results
            totalCount += response.count
            print("Fetched \(pokemonsList.count) pokemons.")
        } catch {
            print("Fetching failed with \(error)")
        }
        calculateNextPage()
        delegate?.didLoadData()
        return pokemonsList
    }
    
    private func calculateNextPage() {
        if isPaginationRequired(page: pageNumber) {
            pageNumber += 1
            delegate?.isNextPageAvailable?(available: true)
        } else {
            delegate?.isNextPageAvailable?(available: false)
        }
    }
    
    private func isPaginationRequired(page: Int) -> Bool {
        return (page * Constants.pageSize) < totalCount
    }
}
