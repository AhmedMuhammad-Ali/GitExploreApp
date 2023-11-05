//
//  EmptyView.swift
//  GitExploreApp
//
//  Created by Ahmed Ali on 03/11/2023.
//

import UIKit
/// A custom view for displaying empty content with an image, title, and description.
class EmptyView: UIView {
    // MARK: - Properties
    /// The image view for displaying an image.
    @NoAutoresizingMask
    private var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    /// The label for displaying the title.
    @NoAutoresizingMask
    private var titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: Dimensions.d18)
        label.textAlignment = .center
        return label
    }()
    /// The label for displaying the description.
    @NoAutoresizingMask
    private var descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: Dimensions.d16)
        label.textAlignment = .center
        label.numberOfLines = .zero
        return label
    }()

    // MARK: - Init(s)
    /// Initializes an `EmptyView` using a view model.
    ///
    /// - Parameter viewModel: The view model containing title, description, and image information.
    init(using viewModel: ViewModel) {
        super.init(frame: .zero)

        imageView.image = viewModel.image
        titleLabel.text = viewModel.title
        descriptionLabel.text = viewModel.description

        setupView()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Private Handler(s)
private extension EmptyView {
    /// Sets up the layout and arrangement of subviews within the `EmptyView`.
    func setupView() {
        let stackView = UIStackView(arrangedSubviews: [imageView, titleLabel, descriptionLabel])
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.spacing = Dimensions.d20

        addSubview(stackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            stackView.centerYAnchor.constraint(equalTo: centerYAnchor),
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Dimensions.d20),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -Dimensions.d20)
        ])
    }
}
