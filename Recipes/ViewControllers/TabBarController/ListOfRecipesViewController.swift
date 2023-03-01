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
    private let detailsVC = DetailsViewController()

    private var randomRecipes: [Recipes] = []
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

        networkManager.getRandomRecipes(url: Link.url) { [weak self] result in

            switch result {
            case .success(let recipes):
                self?.randomRecipes = recipes
                DispatchQueue.main.async {
                    self?.tableView.reloadData()
                }
            case .failure(let error):
                print(error)
            }
        }
    }
}

extension ListOfRecipesViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        randomRecipes.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath)
        let indexPath = randomRecipes[indexPath.row]
        cell.textLabel?.text = indexPath.title
        cell.configure(with: indexPath)

        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let indexPathTitle = randomRecipes[indexPath.row].title
        detailsVC.label.text = indexPathTitle
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
        tableView.rowHeight = 70
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
        searchBarText = searchText
    }
}

extension UITableViewCell {
    func configure(with track: Recipes) {
        var content = defaultContentConfiguration()
        content.text = track.title
        guard let url = URL(string: track.image) else { return }
        DispatchQueue.global().async {
            if let data = try? Data(contentsOf: url) {
                content.image = UIImage(data: data)
            }
            DispatchQueue.main.async {
                self.contentConfiguration = content

            }
        }

    }

}
