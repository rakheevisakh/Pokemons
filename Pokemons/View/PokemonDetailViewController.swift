//
//  PokemonDetailViewController.swift
//  Pokemons
//
//  Created by Rakhee Visakh on 27/05/23.
//

import UIKit

class PokemonDetailViewController: UIViewController {
    @IBOutlet weak var pokemonsListTableView: UITableView!
    @IBOutlet weak var pokemonImageView: UIImageView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!

    var pokemon: Pokemon?
    var pokemonDetail: PokemonDetails?
    var pokemonImage: UIImage?

    private var detailViewModel = PokemonDetailViewModel()
    private var basicDetailsList = [String]()

    override func viewDidLoad() {
        super.viewDidLoad()
        detailViewModel.delegate = self
        setupUI()
        getPokemonDetail()
        getPokemonImage()
    }
    
    private func setupUI() {
        activityIndicator.isHidden = true
        self.pokemonsListTableView.register(PokemonListTableViewCell.nib, forCellReuseIdentifier: PokemonListTableViewCell.identifier)
        self.pokemonsListTableView.register(PokemonDetailSectionHeaderView.nib,
                                            forHeaderFooterViewReuseIdentifier: PokemonDetailSectionHeaderView.identifier)
    }
    
    private func getPokemonDetail() {
        Task {
            pokemonDetail = await detailViewModel.fetchPokemonDetail(url: pokemon?.url ?? "")
            basicDetailsList = detailViewModel.pokemonDetailList
            pokemonsListTableView.reloadData()
        }
    }
    
    private func getPokemonImage() {
        Task {
            pokemonImageView.image = await detailViewModel.fetchPokemonImage()
        }
    }
}

// MARK: - Delegate to show loading indicator
extension PokemonDetailViewController: ViewModelDelegate {
    func willLoadData() {
        DispatchQueue.main.async {
            self.activityIndicator.isHidden = false
            self.activityIndicator.startAnimating()
        }
    }
    
    func didLoadData() {
        DispatchQueue.main.async {
            self.activityIndicator.isHidden = true
            self.activityIndicator.stopAnimating()
        }
    }
}

// MARK: - UITableViewDataSource, UITableViewDelegate
extension PokemonDetailViewController: UITableViewDataSource, UITableViewDelegate  {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return basicDetailsList.count
        }
        return pokemonDetail?.abilities.count ?? 0
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: PokemonDetailSectionHeaderView.identifier) as! PokemonDetailSectionHeaderView
        if section == 0 {
            headerView.lblPokemon.text = "Basic details"
            headerView.imgDetail.image = #imageLiteral(resourceName: "about")
        } else {
            headerView.lblPokemon.text = "Abilities"
            headerView.imgDetail.image = #imageLiteral(resourceName: "ability")
        }
        return headerView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 30
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: PokemonListTableViewCell.identifier, for: indexPath) as! PokemonListTableViewCell
        if indexPath.section == 0 {
            cell.pokemonBasicDetails = basicDetailsList[indexPath.row]
        } else {
            cell.lblPokemon.text = pokemonDetail?.abilities[indexPath.row].ability.name.capitalized
        }
        return cell
    }
}
