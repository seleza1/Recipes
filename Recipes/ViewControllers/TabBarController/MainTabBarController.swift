//
//  RecipesViewController.swift
//  Recipes
//
//  Created by user on 26.02.2023.
//

import UIKit

class MainTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        navigationItem.hidesBackButton = true
        setupTabBar()
    }

    func setupTabBar() {
        let listOfRecipesViewController = createNavController(viewController: ListOfRecipesViewController(), itemName: "Рецепты", itemImage: "list.bullet")
        let favoriteRecipesViewController = createNavController(viewController: FavoriteRecipesViewController(), itemName: "Любимые рецепты", itemImage: "brain")

        viewControllers = [listOfRecipesViewController, favoriteRecipesViewController]

    }

    func createNavController(viewController: UIViewController, itemName: String, itemImage: String) -> UINavigationController {
        let item = UITabBarItem(title: itemName, image: UIImage(systemName: itemImage), tag: 0)


        let navigationController = UINavigationController(rootViewController: viewController)
        navigationController.tabBarItem = item

        return navigationController
    }
}
