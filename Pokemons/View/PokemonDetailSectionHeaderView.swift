//
//  PokemonDetailSectionHeaderView.swift
//  Pokemons
//
//  Created by Rakhee Visakh on 28/05/23.
//

import UIKit

class PokemonDetailSectionHeaderView: UITableViewHeaderFooterView {
    @IBOutlet weak var lblPokemon: UILabel!
    @IBOutlet weak var imgDetail: UIImageView!

    static var nib: UINib {
        return UINib(nibName: identifier, bundle: nil)
    }
    
    static var identifier: String {
        return String(describing: self)
    }
}
