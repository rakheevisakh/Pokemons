//
//  PokemonsListViewController.swift
//  Pokemons
//
//  Created by Rakhee Visakh on 27/05/23.
//

import UIKit

class PokemonsListViewController: UIViewController {

    @IBOutlet weak var pokemonsListTableView: UITableView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!

    private var listViewModel = PokemonsListViewModel()
    var pokemons: [Pokemon]?
    private var selectedPokemon: Pokemon?
    private var isNextPageAvailable: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupUI()
        listViewModel.delegate = self
        getPokemonsList()
    }
    
    private func setupUI() {
        self.title = "Pokemons"
        activityIndicator.isHidden = true
        self.pokemonsListTableView.register(PokemonListTableViewCell.nib, forCellReuseIdentifier: PokemonListTableViewCell.identifier)
    }
    
    private func getPokemonsList() {
        Task {
            pokemons = await listViewModel.fetchPokemonsList()
            pokemonsListTableView.reloadData()
        }
    }
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard segue.identifier == "showPokemonDetail", let pokemonDetailViewController = segue.destination as? PokemonDetailViewController
          else {
            return
        }
        pokemonDetailViewController.pokemon = selectedPokemon
    }
}

// MARK: - Delegate to show loading indicator
extension PokemonsListViewController: ViewModelDelegate {
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
    
    func isNextPageAvailable(available: Bool) {
        isNextPageAvailable = available
    }
}

// MARK: - UITableViewDataSource, UITableViewDelegate
extension PokemonsListViewController: UITableViewDataSource, UITableViewDelegate  {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pokemons?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: PokemonListTableViewCell.identifier, for: indexPath) as! PokemonListTableViewCell
        cell.pokemon = pokemons![indexPath.row]
        
        if indexPath.row == self.listViewModel.pokemonsList.count - 1 && isNextPageAvailable {
            self.getPokemonsList()
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.selectedPokemon = pokemons?[indexPath.row]
        self.performSegue(withIdentifier: "showPokemonDetail", sender: self)
    }
}

