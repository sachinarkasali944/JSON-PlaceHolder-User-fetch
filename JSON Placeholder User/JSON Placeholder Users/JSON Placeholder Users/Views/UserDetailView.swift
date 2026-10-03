//
//  UserDetailView.swift
//  JSON Placeholder Users
//
//  Created by Sachin Arkasali on 03/10/26.
//

import SwiftUI

struct UserDetailView: View {

    let user: User

    var body: some View {
        List {
            Section("Contact") {
                LabeledRow(label: "Name", value: user.name)
                LabeledRow(label: "Email", value: user.email)
                LabeledRow(label: "Phone", value: user.phone)
                LabeledRow(label: "Website", value: user.website)
            }

            Section("Address") {
                LabeledRow(label: "Street", value: user.address.street)
                LabeledRow(label: "Suite", value: user.address.suite)
                LabeledRow(label: "City", value: user.address.city)
                LabeledRow(label: "Zipcode", value: user.address.zipcode)
            }

            Section("Company") {
                LabeledRow(label: "Name", value: user.company.name)
            }
        }
        .navigationTitle(user.name)
        .navigationBarTitleDisplayMode(.inline)
    }
}

// MARK: - LabeledRow
struct LabeledRow: View {
    let label: String
    let value: String

    var body: some View {
        HStack {
            Text(label)
                .foregroundColor(.secondary)
            Spacer()
            Text(value)
                .multilineTextAlignment(.trailing)
        }
    }
}

