//
//  FavoriteRecipesViewController.swift
//  Recipes
//
//  Created by user on 27.02.2023.
//

import UIKit

final class FavoriteRecipesViewController: UICollectionViewController {

    private var randomRecipe: [Recipe] = []
    private let networkManager = NetworkManager()

    override func viewDidLoad() {
        super.viewDidLoad()
        fetchSuperheroes()
    }

    // MARK: UICollectionViewDataSource
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        randomRecipe.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "superhero", for: indexPath) as! CollectionViewCell
        let superhero = randomRecipe[indexPath.row]
        cell.configure(with: superhero)
        return cell
    }

    private func fetchSuperheroes() {
        networkManager.getRandomRecipes(url: Link.url) { [weak self] result in
            switch result {
            case .success(let recipe):
                self.randomRecipe = recipe
            case .failure( _):
                print("error")
            }
        }
    }
}

