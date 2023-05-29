//
//  APIHandler.swift
//  Pokemons
//
//  Created by Rakhee Visakh on 27/05/23.
//

import Foundation

class APIHandler {
    
    func fetchPokemons(pageNumber: Int) async throws -> ListResponseModel {
        guard let url = URL(string: Constants.BASE_URL + "offset=\(pageNumber)&limit=\(Constants.pageSize)")
        else { throw FetchError.badURL }
        let urlRequest = URLRequest(url: url)
        
        let (data, response) = try await URLSession.shared.data(for: urlRequest)
        
        guard (response as? HTTPURLResponse)?.statusCode == 200 else { throw FetchError.badResponse }
        guard !data.isEmpty else { throw FetchError.badData }
        let responseList = try JSONDecoder().decode(ListResponseModel.self, from: data)
        return responseList
    }
    
    func fetchPokemonDetail(urlString: String) async throws -> PokemonDetails {
        guard let url = URL(string: urlString)
        else { throw FetchError.badURL }
        let urlRequest = URLRequest(url: url)
        
        let (data, response) = try await URLSession.shared.data(for: urlRequest)
        
        guard (response as? HTTPURLResponse)?.statusCode == 200 else { throw FetchError.badResponse }
        guard !data.isEmpty else { throw FetchError.badData }
        let responseData = try JSONDecoder().decode(PokemonDetails.self, from: data)
        return responseData
    }
}
