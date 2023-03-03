//
//  UiTableViewCell + Extension.swift
//  Recipes
//
//  Created by user on 03.03.2023.
//

import UIKit
import Kingfisher

extension UITableViewCell {
    func configure(recipe: Recipes) {
        var content = defaultContentConfiguration()
        content.text = recipe.title
        content.secondaryText = "Сooking time - \(recipe.readyInMinutes)"
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
