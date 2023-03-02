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
    
    private var randomRecipes: [Recipes] = []
    private let networkManager = NetworkManager()

    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false

        return tableView
    }()

    private let activityIndicator: UIActivityIndicatorView = {
        let activity = UIActivityIndicatorView()
        activity.hidesWhenStopped = true
        activity.style = .large
        return activity

    }()

    private let uiView: UIView = {
        let view = UIView()
        view.backgroundColor = #colorLiteral(red: 0.9018464684, green: 0.9260535836, blue: 0.9430833459, alpha: 1)

        return view
    }()

    private let connectionFiledLabel: UILabel = {
        let label = UILabel()
        // label.backgroundColor = #colorLiteral(red: 0.9018464684, green: 0.9260535836, blue: 0.9430833459, alpha: 1)
        label.text = "Connection failed"
        label.font = label.font.withSize(20)

        label.textAlignment = .center
        return label
    }()

    private let errorLabel: UILabel = {
        let label = UILabel()
        // label.backgroundColor = #colorLiteral(red: 0.9018464684, green: 0.9260535836, blue: 0.9430833459, alpha: 1)
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

    override func viewDidLoad() {
        super.viewDidLoad()
        addViews()
        updateTableView()
        setConstraints()
        updateUi()
        setupSearchController()
        getRandomRecipes()
        retryButton.addTarget(self, action: #selector(getAgain), for: .touchUpInside)


    }

    @objc func getAgain() {
        uiView.isHidden = true
        getRandomRecipes()
    }

    private func getRandomRecipes() {
        networkManager.getRandomRecipes(url: Link.url) { [weak self] result in
            switch result {

            case .success(let recipes):
                self?.randomRecipes = recipes
                self?.activityIndicator.stopAnimating()
                DispatchQueue.main.async {
                    self?.tableView.reloadData()
                }
            case .failure( _):
                DispatchQueue.main.async {
                    self?.uiView.isHidden = false
//                    self?.presentSimpleAlert(title: "Error", message: "problems with connection")
//                    self?.activityIndicator.stopAnimating()
                }
            }
        }
    }
}

extension ListOfRecipesViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return randomRecipes.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath)
        let indexPath = randomRecipes[indexPath.row]
        cell.configure(recipe: indexPath)
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let indexPath = randomRecipes[indexPath.row]

        router.showDetails(from: self, recipe: indexPath.title, instruction: indexPath.instructions, image: indexPath.image)
    }
}

extension ListOfRecipesViewController {
    private func setConstraints() {
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),

            uiView.topAnchor.constraint(equalTo: view.topAnchor, constant: 108),
            uiView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            uiView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            uiView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -50),

            activityIndicator.topAnchor.constraint(equalTo: view.topAnchor, constant: 300),
            activityIndicator.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
            activityIndicator.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50),

            connectionFiledLabel.topAnchor.constraint(equalTo: uiView.topAnchor, constant: 125),
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

    private func updateTableView() {
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: identifier)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = 70
    }

    private func setupSearchController() {
        navigationItem.searchController = searchController
        searchController.searchBar.placeholder = "What recipe are you looking for?"
        searchController.searchBar.delegate = self
        searchController.obscuresBackgroundDuringPresentation = false

    }

    private func updateUi() {
        view.backgroundColor = .white
        title = "List of recipes"
        activityIndicator.startAnimating()
        uiView.isHidden = true
    }

    private func addViews() {
        view.addView(tableView)
        view.addView(activityIndicator)
        view.addView(uiView)
        uiView.addView(connectionFiledLabel)
        uiView.addView(errorLabel)
        uiView.addView(retryButton)


    }
}

extension ListOfRecipesViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        searchBarText = searchText
    }
}

extension UITableViewCell {
    func configure(recipe: Recipes) {
        var content = defaultContentConfiguration()
        content.text = recipe.title
        guard let url = URL(string: recipe.image) else { return }
        DispatchQueue.global().async {
            if let data = try? Data(contentsOf: url) {
                content.image = UIImage(data: data)
                DispatchQueue.main.async {
                    self.contentConfiguration = content
                }
            }
        }
    }
}
