//
//  MainRouter.swift
//  Recipes
//
//  Created by user on 28.02.2023.
//

import UIKit

protocol MainRouter {
    func showMain(from viewController: UIViewController)
}

extension Router: MainRouter {
    func showMain(from viewController: UIViewController) {
        let recipesVC = MainTabBarController()
        recipesVC.modalPresentationStyle = .fullScreen
        viewController.present(recipesVC, animated: true, completion: nil)
    }


}
