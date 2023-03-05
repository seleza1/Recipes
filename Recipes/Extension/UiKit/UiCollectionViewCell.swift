//
//  UiCollectionViewCell.swift
//  Recipes
//
//  Created by user on 04.03.2023.
//

import UIKit

class CollectionViewCell: UICollectionViewCell {

    static let identifier = "Custom"
    private let networkManager = NetworkManager()

    private var activityIndicator: UIActivityIndicatorView?


    private let labelNameRecipe: UILabel = {
        let label = UILabel()
        label.text = "CollectionViewCellv"
        label.textAlignment = .center
        label.numberOfLines = 0

        return label
    }()

    private let imageView: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "plateFood")
        
        return image
    }()


    private var imageURL: URL? {
        didSet {
            imageView.image = nil
            updateImage()
        }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addView(imageView)
        contentView.addView(labelNameRecipe)
        activityIndicator = showSpinner(in: imageView)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func layoutSubviews() {
        labelNameRecipe.frame = CGRect(x: 4, y: Int(contentView.frame.size.height) - 50, width: Int(contentView.frame.size.width) - 10, height: 50)

        imageView.frame = CGRect(x: 4, y: 0, width: Int(contentView.frame.size.width) - 10, height: Int(contentView.frame.size.height) - 50)
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
                }
                self?.activityIndicator?.stopAnimating()

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

    private func showSpinner(in view: UIView) -> UIActivityIndicatorView {
        let activityIndicator = UIActivityIndicatorView(style: .medium)
        activityIndicator.color = .white
        activityIndicator.startAnimating()
        activityIndicator.center = view.center
        activityIndicator.hidesWhenStopped = true

        view.addView(activityIndicator)

        return activityIndicator
    }

}

