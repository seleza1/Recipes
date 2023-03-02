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
        return imageView

    }()

     let nameRecipesLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.text = "Пероженое"
        label.font = label.font.withSize(20)
        label.textAlignment = .center

        return label
    }()

    let instructionLabel: UILabel = {
       let label = UILabel()
       label.numberOfLines = 0
       label.font = label.font.withSize(12)
       label.textAlignment = .center

       return label
   }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white

        view.addView(imageView)
        view.addView(nameRecipesLabel)
        view.addView(instructionLabel)
        setConstraints()

    }
}

extension DetailsViewController {
    private func setConstraints() {
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: view.topAnchor, constant: 32),
            imageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
            imageView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50),
            imageView.heightAnchor.constraint(equalToConstant: 250),

            nameRecipesLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 16),
            nameRecipesLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            nameRecipesLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            nameRecipesLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 70),

            instructionLabel.topAnchor.constraint(equalTo: nameRecipesLabel.bottomAnchor, constant: 16),
            instructionLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            instructionLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16)
        ])
    }
}
