//
//  UiViewController + Extension.swift
//  Recipes
//
//  Created by user on 27.02.2023.
//

import UIKit

extension UIViewController {

    func presentSimpleAlert(title: String, message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)

        let okAction = UIAlertAction(title: "Ok", style: .cancel)
                alertController.addAction(okAction)
                present(alertController, animated: true)
    }
}
