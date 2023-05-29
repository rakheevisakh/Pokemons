//
//  ImageLoader.swift
//  Pokemons
//
//  Created by Rakhee Visakh on 29/05/23.
//

import Foundation
import UIKit

class ImageLoader {
    func downloadImage(from url:URL) async throws -> UIImage {
            let request = URLRequest.init(url:url)
            let (data, response) = try await URLSession.shared.data(for: request)
            guard (response as? HTTPURLResponse)?.statusCode == 200 else { throw FetchError.badResponse }
            let image = UIImage(data: data) ?? #imageLiteral(resourceName: "pokemonBall")
            return image
        }
}
