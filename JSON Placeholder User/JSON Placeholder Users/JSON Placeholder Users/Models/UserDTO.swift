import Foundation

// MARK: - UserDTO
/// Raw API response model. Maps 1:1 with JSONPlaceholder JSON.
/// Only this layer knows about Codable / JSON keys.
struct UserDTO: Decodable {
    let id: Int
    let name: String
    let username: String
    let email: String
    let phone: String
    let website: String
    let address: AddressDTO
    let company: CompanyDTO
}

struct AddressDTO: Decodable {
    let street: String
    let suite: String
    let city: String
    let zipcode: String
}

struct CompanyDTO: Decodable {
    let name: String
}

// MARK: - Mapping
extension UserDTO {
    func toDomain() -> User {
        User(
            id: id,
            name: name,
            username: username,
            email: email,
            phone: phone,
            website: website,
            address: Address(
                street: address.street,
                suite: address.suite,
                city: address.city,
                zipcode: address.zipcode
            ),
            company: Company(name: company.name)
        )
    }
}
