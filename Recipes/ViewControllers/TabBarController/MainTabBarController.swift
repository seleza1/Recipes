//
//  RecipesViewController.swift
//  Recipes
//
//  Created by user on 26.02.2023.
//

import UIKit

final class MainTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        updateUi()
        setupTabBar()
    }
}

extension MainTabBarController {

    private func setupTabBar() {
        let listOfRecipesViewController = createNavController(viewController: ListOfRecipesViewController(), itemName: "Search recipes", itemImage: "list.bullet")
        let favoriteRecipesViewController = createNavController(viewController: TopDesertsRecipesViewController(), itemName: "Top deserts", itemImage: "brain")

        viewControllers = [listOfRecipesViewController, favoriteRecipesViewController]

    }
    private func createNavController(viewController: UIViewController, itemName: String, itemImage: String) -> UINavigationController {
        let item = UITabBarItem(title: itemName, image: UIImage(systemName: itemImage), tag: 0)

        let navigationController = UINavigationController(rootViewController: viewController)
        navigationController.tabBarItem = item

        return navigationController
    }

    private func updateUi() {
        view.backgroundColor = .white
        navigationItem.hidesBackButton = true
    }
}
