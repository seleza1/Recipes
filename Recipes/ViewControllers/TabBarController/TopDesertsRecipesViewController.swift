//
//  FavoriteRecipesViewController.swift
//  Recipes
//
//  Created by user on 27.02.2023.
//

import UIKit

final class TopDesertsRecipesViewController: UIViewController {

    private let searchController = UISearchController()
    private var searchBarText = ""

    private let activityIndicator: UIActivityIndicatorView = {
        let activity = UIActivityIndicatorView()
        activity.hidesWhenStopped = true
        activity.style = .large
        return activity

    }()

    private let uiView: UIView = {
        let view = UIView()
        view.backgroundColor = .white

        return view
    }()

    private let connectionFiledLabel: UILabel = {
        let label = UILabel()
        label.text = "Connection failed"
        label.font = label.font.withSize(20)
        label.textAlignment = .center
        return label
    }()

    private let errorLabel: UILabel = {
        let label = UILabel()
        label.text = "Your internet connection is offline. Please check your internet connection and try again"
        label.font = label.font.withSize(14)
        label.textColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
        label.numberOfLines = 0

        label.textAlignment = .center
        return label
    }()

    private let retryButton: UIButton = {
        let button = UIButton()
        button.setTitle("Retry", for: .normal)
        button.backgroundColor = #colorLiteral(red: 0.01562912948, green: 0.5854102373, blue: 0.9989331365, alpha: 1)
        button.layer.cornerRadius = 15
        return button
    }()

    private var randomRecipe: [Resultss] = []
    private let networkManager = NetworkManager()

    private var collectionView: UICollectionView?

    override func viewDidLoad() {
        super.viewDidLoad()

        addViews()
        updateUi()
        getRandomRecipes()
        setConstraints()
        setupSearchController()


        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 1
        layout.minimumInteritemSpacing = 1
        layout.itemSize = CGSize(width: (view.frame.size.width / 2 ) - 4, height: (view.frame.size.width / 2 ) - 4)

        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        guard let collectionViews = collectionView else { return }
        collectionViews.register(CollectionViewCell.self, forCellWithReuseIdentifier: CollectionViewCell.identifier)

        collectionViews.delegate = self
        collectionViews.dataSource = self
        collectionViews.frame = view.bounds
        view.addView(collectionViews)

        addTarget()
    }

    @objc func getAgain() async {
        uiView.isHidden = true
         getRandomRecipes()
    }

    private func getRandomRecipes() {

        Task {
            let url: String = "https://api.spoonacular.com/recipes/complexSearch?apiKey=1e87d8aad28344b6a87cdb89464059fb&query=\(searchBarText)&number=1"

            do {
                randomRecipe = try await networkManager.async(url: url)
                collectionView?.reloadData()
            } catch {

            }
        }


//
//        let url: String = "https://api.spoonacular.com/recipes/complexSearch?apiKey=1e87d8aad28344b6a87cdb89464059fb&query=\(searchBarText)&number=1"
//        networkManager.getSearchRecipes(url: url) { [weak self] result in
//            switch result {
//
//            case .success(let recipes):
//                self?.randomRecipe = recipes
//                self?.activityIndicator.stopAnimating()
//                DispatchQueue.main.async {
//                    self?.collectionView?.reloadData()
//                }
//            case .failure( _):
//                print("error")
//                DispatchQueue.main.async {
//                    self?.uiView.isHidden = false
//
//                }
//            }
//        }
    }
}

extension TopDesertsRecipesViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        randomRecipe.count
   }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CollectionViewCell.identifier, for: indexPath) as? CollectionViewCell else {
            return UICollectionViewCell()
        }
        let recipe = randomRecipe[indexPath.row]
        cell.configure(name: recipe, image: recipe)
       return cell
   }

//    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        let modelRecipes = randomRecipe[indexPath.row]
//         let detailsVC = DetailsViewController()
//        detailsVC.model = modelRecipes
//        present(detailsVC, animated: true)
//
//    }
}

extension TopDesertsRecipesViewController {
    private func setConstraints() {
        NSLayoutConstraint.activate([

            uiView.topAnchor.constraint(equalTo: view.topAnchor, constant: 108),
            uiView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            uiView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            uiView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -50),

            activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor),

            connectionFiledLabel.topAnchor.constraint(equalTo: uiView.topAnchor, constant: 200),
            connectionFiledLabel.leadingAnchor.constraint(equalTo: uiView.leadingAnchor, constant: 16),
            connectionFiledLabel.trailingAnchor.constraint(equalTo: uiView.trailingAnchor, constant: -16),

            errorLabel.topAnchor.constraint(equalTo: connectionFiledLabel.bottomAnchor, constant: 16),
            errorLabel.leadingAnchor.constraint(equalTo: uiView.leadingAnchor, constant: 16),
            errorLabel.trailingAnchor.constraint(equalTo: uiView.trailingAnchor, constant: -16),

            retryButton.topAnchor.constraint(equalTo: errorLabel.bottomAnchor, constant: 16),
            retryButton.leadingAnchor.constraint(equalTo: uiView.leadingAnchor, constant: 125),
            retryButton.trailingAnchor.constraint(equalTo: uiView.trailingAnchor, constant: -125),
            retryButton.heightAnchor.constraint(equalToConstant: 35)
        ])
    }

    private func updateUi() {
        uiView.isHidden = true
        activityIndicator.startAnimating()
        title = "Top deserts"

    }

    private func addViews() {
        uiView.addView(connectionFiledLabel)
        uiView.addView(errorLabel)
        uiView.addView(retryButton)
        view.addView(activityIndicator)
        view.addView(uiView)
    }

    private func setupSearchController() {
        navigationItem.searchController = searchController
        searchController.searchBar.placeholder = "What recipe are you looking for?"
        searchController.searchBar.delegate = self
        searchController.obscuresBackgroundDuringPresentation = false

    }

    private func addTarget(){
        retryButton.addTarget(self, action: #selector(getAgain), for: .touchUpInside)
    }
}

extension TopDesertsRecipesViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        activityIndicator.startAnimating()
        searchBarText = searchBar.text!
        print("Search")

    }
}

