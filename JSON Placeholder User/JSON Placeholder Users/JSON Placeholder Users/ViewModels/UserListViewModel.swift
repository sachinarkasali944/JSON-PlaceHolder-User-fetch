import Foundation
import Combine

// MARK: - ViewState
enum ViewState {
    case idle
    case loading
    case success([User])
    case failure(String)
}

// MARK: - UserListViewModel
@MainActor
final class UserListViewModel: ObservableObject {

    // MARK: - Published Properties
    @Published private(set) var viewState: ViewState = .idle
    @Published var searchText: String = "" {
        didSet { filterUsers() }
    }

    // MARK: - Private
    private var allUsers: [User] = []
    private let service: UserServiceProtocol

    // MARK: - Init
    init(service: UserServiceProtocol = UserService()) {
        self.service = service
    }

    // MARK: - Fetch
    func fetchUsers() async {
        viewState = .loading

        do {
            let fetchedUsers = try await service.fetchUsers()
            allUsers = fetchedUsers
            viewState = .success(fetchedUsers)
        } catch {
            viewState = .failure("Failed to load users. Please try again.")
        }
    }

    // MARK: - Search
    private func filterUsers() {
        guard !searchText.isEmpty else {
            viewState = .success(allUsers)
            return
        }
        let filtered = allUsers.filter {
            $0.name.localizedCaseInsensitiveContains(searchText) ||
            $0.email.localizedCaseInsensitiveContains(searchText)
        }
        viewState = .success(filtered)
    }
}
