//
//  UserRepositoryCell.swift
//  GitExploreApp
//
//  Created by Ahmed Ali on 31/10/2023.
//

import UIKit
import Domain

class UserRepositoryCell: UITableViewCell {
    // MARK: - Outlets
    @IBOutlet private weak var cardView: UIView!
    @IBOutlet private weak var nameLabel: UILabel!
    @IBOutlet private weak var descriptionLabel: UILabel!
    @IBOutlet private weak var licenseLabel: UILabel!

    // MARK: - LifeCycle
    override func awakeFromNib() {
        super.awakeFromNib()
        configureAppearance()
    }
}
// MARK: - Configure Cell
extension UserRepositoryCell {
    /// Configures the cell view and binds the data from the provided view model.
    ///
    /// - Parameter viewModel: The view model containing the data to be displayed in the cell view.
    func configure(with viewModel: ViewModel) {
        nameLabel.text = viewModel.repoName
        descriptionLabel.text = viewModel.repoDescription
        licenseLabel.text = viewModel.repoLicense
    }
    // MARK: - Private Methods
    private func configureAppearance() {
        cardView.applyDefaultCardShadow(cornerRadius: Dimensions.d12)
    }
}
/// The `ViewModel` struct represents the view model used to configure the `UserRepositoryCell`.
///
/// Contains the necessary data for displaying the user repo information.
/// - SeeAlso: `Repo`
///
extension UserRepositoryCell {
    /// The view model used to configure the `UserRepositoryCell`.
    struct ViewModel {
        /// The name of the repo.
        var repoName: String = .empty
        /// The description of the repo
        var repoDescription: String?
        /// The license of the repo
        var repoLicense: String?
    }
}

extension UserRepositoryCell.ViewModel {
    /// Initializes a `UserRepositoryCell.ViewModel` from a `Repo`.
    /// - Parameter repo: The repository from which to extract data for the view model.
    init(from repo: Repo) {
        self.repoName = repo.name
        self.repoDescription = repo.description
        self.repoLicense = repo.license
    }
}
