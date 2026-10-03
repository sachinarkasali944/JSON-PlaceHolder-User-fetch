//
//  UserService.swift
//  JSON Placeholder Users
//
//  Created by Sachin Arkasali on 03/10/26.
//

import Foundation

// MARK: - Protocol
protocol UserServiceProtocol {
    func fetchUsers() async throws -> [User]
}

// MARK: - Concrete Implementation
final class UserService: UserServiceProtocol {

    private let url = "https://jsonplaceholder.typicode.com/users"
    private let network: NetworkingService

    init(network: NetworkingService = NetworkManager()) {
        self.network = network
    }

    func fetchUsers() async throws -> [User] {
        let dtos: [UserDTO] = try await network.fetch(from: url)
        return dtos.map { $0.toDomain() }
    }
}
