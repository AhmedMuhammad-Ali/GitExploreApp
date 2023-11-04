//
//  UsersListView.swift
//  GitExploreApp
//
//  Created by Ahmed Ali on 30/10/2023.
//

import SwiftUI
import Combine

struct UsersListView: View {
    @ObservedObject var viewModel: UsersListViewModel
    // MARK: - Init
    init(viewModel: UsersListViewModel) {
        self.viewModel = viewModel
    }
    // MARK: - Body
    var body: some View {
        VStack {
            List {
                ForEach(viewModel.usersCountRange, id: \.self) { index in
                    Section {
                        UserRowView(user: viewModel[index])
                            .contentShape(Rectangle())
                            .onTapGesture {
                                viewModel.didTappedOnUser(at: index)
                            }
                    } //: Section
                } //: ForEach
            } //: List
        } //: VStack
        .navigationBarTitle(viewModel.screenTitle, displayMode: .inline)
    }
}
