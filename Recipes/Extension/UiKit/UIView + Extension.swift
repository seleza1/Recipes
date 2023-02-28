//
//  UIView + Extension.swift
//  Recipes
//
//  Created by user on 28.02.2023.
//

import UIKit

extension UIView {
    func addView(_ view: UIView) {
        self.addSubview(view)
        view.translatesAutoresizingMaskIntoConstraints = false
    }
}
