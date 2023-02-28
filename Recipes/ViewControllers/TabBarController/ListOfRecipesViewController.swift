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

    }
}

extension ListOfRecipesViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        10
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath)
        cell.textLabel?.text = "dfss"
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
