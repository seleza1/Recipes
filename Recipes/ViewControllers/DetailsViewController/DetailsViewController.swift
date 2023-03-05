//
//  DetailsRecipesViewController.swift
//  Recipes
//
//  Created by user on 27.02.2023.
//

import UIKit

final class DetailsViewController: UIViewController {
    private let networkManager = NetworkManager()

    var model: Recipe!


    let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "plateFood")
        return imageView

    }()
    
    let nameRecipesLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = label.font.withSize(20)
        label.textAlignment = .center

        return label
    }()

    let ingredientsLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = label.font.withSize(12)
        label.textAlignment = .center

        return label
    }()

    let cookingTimeLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = label.font.withSize(15)
        label.textAlignment = .center

        return label
    }()
    private var imageURL: URL? {
        didSet {
            imageView.image = nil
            updateImage()
        }
    }


    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        addViews()
        setConstraints()
        nameRecipesLabel.text = model.title
        imageURL = URL(string: model.image)
        cookingTimeLabel.text = "\(model.readyInMinutes)"
        ingredientsLabel.text = model.instructions

    }

    private func updateImage() {
        guard let imageURL = imageURL else { return }
        getImage(from: imageURL) { [weak self] result in
            switch result {
            case .success(let image):
                if imageURL == self?.imageURL {
                    self?.imageView.image = image
                }
            case .failure(let error):
                print(error)
            }
        }
    }


    private func getImage(from url: URL, completion: @escaping(Result<UIImage, Error>) -> Void) {
        networkManager.fetchImage(from: url) { result in
            switch result {
            case .success(let imageData):
                guard let uiImage = UIImage(data: imageData) else { return }
                completion(.success(uiImage))
            case .failure(let error):
                print(error)
            }
        }
    }
    
}

extension DetailsViewController {
    private func setConstraints() {
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: view.topAnchor, constant: 32),
            imageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
            imageView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50),
            imageView.heightAnchor.constraint(equalToConstant: 250),

            nameRecipesLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 8),
            nameRecipesLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            nameRecipesLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            nameRecipesLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 70),

            ingredientsLabel.topAnchor.constraint(equalTo: cookingTimeLabel.bottomAnchor, constant: 6),
            ingredientsLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            ingredientsLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),

            cookingTimeLabel.topAnchor.constraint(equalTo: nameRecipesLabel.bottomAnchor, constant: 32),
            cookingTimeLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
            cookingTimeLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50)
        ])
    }

    private func addViews() {
        view.addView(imageView)
        view.addView(nameRecipesLabel)
        view.addView(ingredientsLabel)
        view.addView(cookingTimeLabel)
    }
}
