//
//  DetailsRecipesViewController.swift
//  Recipes
//
//  Created by user on 27.02.2023.
//

import UIKit

final class DetailsViewController: UIViewController {

     let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "food")
        return imageView

    }()

     let label: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.text = "Пероженое"
        label.font = label.font.withSize(20)
        label.textAlignment = .center

        return label
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white

        view.addView(imageView)
        view.addView(label)
        setConstraints()

    }
}

extension DetailsViewController {
    private func setConstraints() {
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: view.topAnchor, constant: 50),
            imageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
            imageView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50),
            imageView.heightAnchor.constraint(equalToConstant: 250),

            label.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 70),
            label.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
            label.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50)

        ])
    }
}
