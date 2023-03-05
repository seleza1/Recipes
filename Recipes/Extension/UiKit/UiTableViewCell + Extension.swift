//
//  UiTableViewCell + Extension.swift
//  Recipes
//
//  Created by user on 03.03.2023.
//

import UIKit

final class MainTableViewCell: UITableViewCell {
    private let networkManager = NetworkManager()
    private let valueLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.text = "Test"
        label.numberOfLines = 0

        return label
    }()

    private var activityIndicator: UIActivityIndicatorView?

    private let imageViews: UIImageView = {
        let image = UIImageView()

        return image
    }()

    private var imageURL: URL? {
        didSet {
            imageView!.image = nil
            updateImage()
        }
    }

    static var idMainTableViewCell = "idMainTableViewCell"

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        activityIndicator = showSpinner(in: imageViews)
        setupViews()
        setConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func updateImage() {
        guard let imageURL = imageURL else { return }
        getImage(from: imageURL) { [weak self] result in
            switch result {
            case .success(let image):
                if imageURL == self?.imageURL {
                    self?.imageView?.image = image
                    self?.activityIndicator?.stopAnimating()

                }
            case .failure(let error):
                print(error)
            }
        }
    }

    private func getImage(from url: URL, completion: @escaping(Result<UIImage, Error>) -> Void) {

        // Download image from url
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

    private func setupViews() {
        selectionStyle = .none
        addView(valueLabel)
        addView(imageViews)

    }

    public func configure(name: Recipe, image: Recipe) {
        valueLabel.text = name.title
        imageURL = URL(string: image.image)

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

extension MainTableViewCell {
    private func setConstraints() {
        NSLayoutConstraint.activate([

            imageViews.topAnchor.constraint(equalTo: topAnchor, constant: 1),
            imageViews.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 0),
            imageViews.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -1),
            // imageViews.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -250),
            imageViews.widthAnchor.constraint(equalToConstant: 150),

            valueLabel.topAnchor.constraint(equalTo: topAnchor, constant: 5),
            valueLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -1),
            valueLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -6),
            valueLabel.leadingAnchor.constraint(equalTo: imageViews.trailingAnchor, constant: 6)

        ])
    }
}
