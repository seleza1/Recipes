//
//  UiCollectionViewCell.swift
//  Recipes
//
//  Created by user on 04.03.2023.
//

import UIKit

class CollectionViewCell: UICollectionViewCell {
    private let labelNameRecipe: UILabel = {
        let label = UILabel()

        return label
    }()

    private let imageView: UIImageView = {
        let image = UIImageView()
        
        return image
    }()

    private var activityIndicator: UIActivityIndicatorView?
    private var imageURL: URL? {
        didSet {
            imageView.image = nil
            updateImage()
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        activityIndicator = showSpinner(in: imageView)
    }

    func configure(with recipe: Recipe) {
        labelNameRecipe.text = recipe.title
        imageURL = URL(string: recipe.image)
    }

    private func updateImage() {
        guard let imageURL = imageURL else { return }
        getImage(from: imageURL) { [weak self] result in
            switch result {
            case .success(let image):
                if imageURL == self?.imageURL {
                    self?.imageView.image = image
                    self?.activityIndicator?.stopAnimating()
                }
            case .failure(let error):
                print(error)
            }
        }
    }

    private func getImage(from url: URL, completion: @escaping(Result<UIImage, Error>) -> Void) {
        // Download image from url
        NetworkManager.shared.fetchImage(from: url) { result in
            switch result {
            case .success(let imageData):
                guard let uiImage = UIImage(data: imageData) else { return }
                completion(.success(uiImage))
            case .failure(let error):
                print(error)
            }
        }
    }

    private func showSpinner(in view: UIView) -> UIActivityIndicatorView {
        let activityIndicator = UIActivityIndicatorView(style: .medium)
        activityIndicator.color = .white
        activityIndicator.startAnimating()
        activityIndicator.center = view.center
        activityIndicator.hidesWhenStopped = true

        view.addSubview(activityIndicator)

        return activityIndicator
    }

}

