//
//  ListRouter.swift
//  Recipes
//
//  Created by user on 28.02.2023.
//

import UIKit

protocol ListRouter {
    func showDetails(from viewController: UIViewController)
}

extension Router: ListRouter {
    func showDetails(from viewController: UIViewController) {
        let detailsViewController = DetailsViewController()
        detailsViewController.modalPresentationStyle = .fullScreen
        viewController.present(detailsViewController, animated: true, completion: nil)
    }
}
