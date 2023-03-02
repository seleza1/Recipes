//
//  ListRouter.swift
//  Recipes
//
//  Created by user on 28.02.2023.
//

import UIKit

protocol ListRouter {
    func showDetails(from viewController: UIViewController, recipe: String, instruction: String, image: String)
}

extension Router: ListRouter {

    func showDetails(from viewController: UIViewController, recipe: String, instruction: String, image: String) {
        let detailsViewController = DetailsViewController()
        detailsViewController.nameRecipesLabel.text = recipe
        detailsViewController.instructionLabel.text = instruction
        detailsViewController.imageView.image = UIImage(named: image)
        detailsViewController.modalPresentationStyle = .pageSheet
        viewController.present(detailsViewController, animated: true, completion: nil)
    }
}
