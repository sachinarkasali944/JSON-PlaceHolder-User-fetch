//
//  ContentView.swift
//  JSON Placeholder Users
//
//  Created by Sachin Arkasali on 03/10/26.
//

import SwiftUI

struct ContentView: View {
    private let viewModel = UserListViewModel(service: UserService())
    
    var body: some View {
        UserListView(viewModel: viewModel)
    }
}

#Preview {
    ContentView()
}
