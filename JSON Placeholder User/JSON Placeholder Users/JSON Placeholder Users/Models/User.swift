import Foundation

// MARK: - Domain Models
/// Clean domain models used by the UI and ViewModel.
/// No Codable — completely decoupled from the API layer.

struct User: Identifiable {
    let id: Int
    let name: String
    let username: String
    let email: String
    let phone: String
    let website: String
    let address: Address
    let company: Company
}

struct Address {
    let street: String
    let suite: String
    let city: String
    let zipcode: String
}

struct Company {
    let name: String
}
