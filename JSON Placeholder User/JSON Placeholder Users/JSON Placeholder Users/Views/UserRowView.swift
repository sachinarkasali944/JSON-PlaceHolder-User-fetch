//
//  UserRowView.swift
//  JSON Placeholder Users
//
//  Created by Sachin Arkasali on 03/10/26.
//

import SwiftUI

struct UserRowView: View {

    let user: User

    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text(user.name)
                .font(.headline)

            Text(user.email)
                .font(.subheadline)
                .foregroundColor(.gray)

            Text(user.company.name)
                .font(.caption)
                .foregroundColor(.secondary)
        }
    }
}
