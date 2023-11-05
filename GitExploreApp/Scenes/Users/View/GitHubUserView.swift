//
//  GitHubUserView.swift
//  GitExploreApp
//
//  Created by Ahmed Ali on 05/11/2023.
//

import SwiftUI
import Kingfisher

/// A view that displays a GitHub user's avatar and username.
struct GitHubUserView: View {
    /// The view model representing the user data.
    let user: ViewModel

    var body: some View {
        HStack {
            KFImage(URL(string: user.userAvatar))
                .resizable()
                .placeholder({
                    ProgressView()
                })
                .frame(width: user.avatarFrame.width, height: user.avatarFrame.height)
                .clipShape(Circle())
                .padding(Dimensions.d02)
                .overlay(
                    Circle()
                        .stroke(.gray, lineWidth: Dimensions.d02)
                )
            Text(user.userName)
                .font(.title)
                .padding(.leading, Dimensions.d12)
            Spacer()
        } //: HStack
    }
}

extension GitHubUserView {

    /// The view model that provides data for the `GitHubUserView`.
    struct ViewModel {
        let userName: String
        let userAvatar: String
        let avatarStyle: AvatarStyle

        var avatarFrame: (width: CGFloat, height: CGFloat) {
            avatarStyle.frame
        }

        init(userName: String, userAvatar: String, avatarStyle: AvatarStyle = .medium) {
            self.userName = userName
            self.userAvatar = userAvatar
            self.avatarStyle = avatarStyle
        }
    }

    /// An enumeration representing different avatar styles for the view.
    enum AvatarStyle {
        case small
        case medium
        case large

        var frame: (width: CGFloat, height: CGFloat) {
            switch self {
            case .small:
                return (Dimensions.d25, Dimensions.d25)
            case .medium:
                return (Dimensions.d50, Dimensions.d50)
            case .large:
                return (Dimensions.d70, Dimensions.d70)
            }
        }
    }
}
