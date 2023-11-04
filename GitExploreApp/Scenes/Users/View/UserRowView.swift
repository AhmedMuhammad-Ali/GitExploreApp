//
//  UserRowView.swift
//  GitExploreApp
//
//  Created by Ahmed Ali on 30/10/2023.
//

import SwiftUI

/// A view that represents a user in a list or row.
struct UserRowView: View {

    /// The user information to display.
    let user: UserUIModel

    var body: some View {
        VStack(alignment: .leading, spacing: Dimensions.d24) {
            // Display the user's avatar and name using the UserAvatarView.
            GitHubUserView(user: .init(
                userName: user.userName,
                userAvatar: user.userAvatar,
                avatarStyle: .large
            ))

            // Display the user's repository count and followers count in a horizontal stack.
            HStack {
                Image(systemName: Constants.repoImageName)
                Text(user.formattedReposCount)
                Spacer()
                Image(systemName: Constants.followerImageName)
                Text(user.formattedFollowersCount)
            }
        }
    }
}
// MARK: - Constants
private extension UserRowView {
    enum Constants {
        static let repoImageName = "book"
        static let followerImageName = "person.fill"
    }
}
