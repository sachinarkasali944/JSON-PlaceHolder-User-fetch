//
//  UserListView.swift
//  JSON Placeholder Users
//
//  Created by Sachin Arkasali on 03/10/26.
//

import SwiftUI

struct UserListView: View {

    @ObservedObject private var viewModel: UserListViewModel

    // MARK: - Init
    init(viewModel: UserListViewModel) {
        self.viewModel = viewModel
    }

    var body: some View {
        NavigationStack {
            Group {
                switch viewModel.viewState {
                case .idle, .loading:
                    ProgressView("Loading...")

                case .failure(let message):
                    VStack(spacing: 12) {
                        Text(message)
                            .foregroundColor(.red)
                            .multilineTextAlignment(.center)
                        Button("Retry") {
                            Task { await viewModel.fetchUsers() }
                        }
                    }
                    .padding()

                case .success(let users):
                    List(users) { user in
                        NavigationLink(destination: UserDetailView(user: user)) {
                            UserRowView(user: user)
                        }
                    }
                    .searchable(text: $viewModel.searchText, prompt: "Search by name or email")
                }
            }
            .navigationTitle("Users")
            .task {
                await viewModel.fetchUsers()
            }
        }
    }
} 
