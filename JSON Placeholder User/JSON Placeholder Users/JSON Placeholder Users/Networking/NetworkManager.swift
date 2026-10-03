import Foundation

// MARK: - Protocol
protocol NetworkingService {
    func fetch<T: Decodable>(from urlString: String) async throws -> T
}

// MARK: - Concrete Implementation
final class NetworkManager: NetworkingService {

    func fetch<T: Decodable>(from urlString: String) async throws -> T {
        guard let url = URL(string: urlString) else {
            throw NetworkError.invalidURL
        }

        let (data, _) = try await URLSession.shared.data(from: url)

        do {
            return try JSONDecoder().decode(T.self, from: data)
        } catch {
            throw NetworkError.decodingFailed
        }
    }
}
