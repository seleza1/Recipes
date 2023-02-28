//
//  ListOfRecipesViewController.swift
//  Recipes
//
//  Created by user on 27.02.2023.
//

import UIKit

final class ListOfRecipesViewController: UIViewController {

    private let identifier = "cell"
    private let router: ListRouter = Router.shared
    private let searchController = UISearchController()
    private var searchBarText: String = ""
    
    private var nameRecipes: [Recipes] = []
    private let networkManager = NetworkManager()

    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false

        return tableView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        updateTableView()
        setConstraints()
        updateUi()
        setupSearchController()

        networkManager.getRandomRecipes(url: Link.url) { [weak self]result in
            switch result {

            case .success(let recipes):
                self?.nameRecipes = recipes
            case .failure(let error):
                print(error)
            }
        }
    }
}

extension ListOfRecipesViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        nameRecipes.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath)
        cell.textLabel?.text = nameRecipes[indexPath.row].title
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        router.showDetails(from: self)
    }
}

extension ListOfRecipesViewController {
    private func setConstraints() {
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }

    private func updateTableView() {
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: identifier)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = 90
    }

    private func setupSearchController() {
        navigationItem.searchController = searchController
        searchController.searchBar.placeholder = "Кого ищем?"
        searchController.searchBar.delegate = self
        searchController.obscuresBackgroundDuringPresentation = false

    }

    private func updateUi() {
        view.backgroundColor = .white
        title = "Список рецептов"
    }

    private func setupViews() {
        view.addView(tableView)
    }
}

extension ListOfRecipesViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        print(searchText)
    }
}
