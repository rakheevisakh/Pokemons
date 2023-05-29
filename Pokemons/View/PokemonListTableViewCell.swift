//
//  PokemonListTableViewCell.swift
//  Pokemons
//
//  Created by Rakhee Visakh on 28/05/23.
//

import UIKit

class PokemonListTableViewCell: UITableViewCell {
    @IBOutlet weak var lblPokemon: UILabel!
    @IBOutlet weak var parentView: UIView!

    override func awakeFromNib() {
        super.awakeFromNib()
        parentView.layer.cornerRadius = 5
    }
    
    static var nib: UINib {
        return UINib(nibName: identifier, bundle: nil)
    }
    
    static var identifier: String {
        return String(describing: self)
    }
    
    var pokemon: Pokemon! {
        didSet {
            lblPokemon.text = pokemon.name.capitalized
        }
    }
    
    var pokemonBasicDetails: String! {
        didSet {
            lblPokemon.text = pokemonBasicDetails
        }
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
}
