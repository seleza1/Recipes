//
//  FavoriteRecipesViewController.swift
//  Recipes
//
//  Created by user on 27.02.2023.
//

import UIKit

final class FavoriteRecipesViewController: UIViewController {

    private var randomRecipe: [Recipe] = []
    private let networkManager = NetworkManager()

    private var collectionView: UICollectionView?

    override func viewDidLoad() {
        super.viewDidLoad()

        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical

        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        guard let collectionView = collectionView else { return }
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "cell")

        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.frame = view.bounds
        view.addView(collectionView)

        //fetchSuperheroes()
    }

    // MARK: UICollectionViewDataSource


//    private func fetchSuperheroes() {
//        networkManager.getRandomRecipes(url: Link.url) { [weak self] result in
//            switch result {
//            case .success(let recipe):
//                self?.randomRecipe = recipe
//            case .failure( _):
//                print("error")
//            }
//        }
//    }
}

extension FavoriteRecipesViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
       return 3
//        randomRecipe.count
   }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
       let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
        cell.contentView.backgroundColor = .systemRed
        //as! CollectionViewCell

//        let superhero = randomRecipe[indexPath.row]
//        cell.configure(with: superhero)
       return cell
   }
}

