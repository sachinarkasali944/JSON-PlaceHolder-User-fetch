# JSON Placeholder Users 👥

A clean, interview-ready iOS app built with **SwiftUI** and **MVVM architecture** that fetches and displays users from the [JSONPlaceholder](https://jsonplaceholder.typicode.com/users) REST API.

---

## 📸 Features

- **Live data** fetched from `https://jsonplaceholder.typicode.com/users`
- **Search** users by name, username, email, or company
- **Detail screen** with full contact, address, geo, and company info
- **Loading / Error / Empty** states handled gracefully
- **Retry** button on network failure

---

## 🏗️ Architecture — MVVM

```
JSON Placeholder Users/
├── Models/
│   └── User.swift              # Codable data models (User, Address, Geo, Company)
├── Networking/
│   ├── NetworkManager.swift    # Generic async/await HTTP client (Singleton + Protocol)
│   └── NetworkError.swift      # Typed error enum with user-friendly messages
├── Services/
│   └── UserService.swift       # Data layer — fetches users via NetworkManager
├── ViewModels/
│   └── UserListViewModel.swift # Business logic, state machine, search filtering
└── Views/
    ├── UserListView.swift       # Main screen — list + search + state rendering
    ├── UserCardView.swift       # Reusable user row card with gradient avatar
    └── UserDetailView.swift     # Full detail screen with SectionCard + DetailRow
```

---

## 🔄 Data Flow

```
UserListView
    └── observes → UserListViewModel (@StateObject)
                      └── calls → UserService (protocol)
                                    └── calls → NetworkManager (protocol)
                                                  └── URLSession.data(from:)
                                                        └── https://jsonplaceholder.typicode.com/users
```

---

## 🧩 Key Design Decisions

| Concern | Decision | Reason |
|---|---|---|
| Architecture | MVVM | Clean separation; ViewModel is testable without UI |
| Networking | async/await | Modern, readable; avoids callback hell |
| Dependency Injection | Protocol-based (UserServiceProtocol, NetworkManagerProtocol) | Easy to swap mocks in unit tests |
| Error Handling | NetworkError enum | Strongly typed; maps raw errors to user-friendly messages |
| State Machine | ViewState enum (idle/loading/success/failure) | Single source of truth for UI state |
| Thread Safety | @MainActor on ViewModel | Guarantees all @Published updates on main thread |
| Search | Local filter on allUsers array | Avoids redundant API calls; instant results |
| List Performance | LazyVStack inside ScrollView | Renders rows on demand for large lists |

---

## 📦 Models

### User
```swift
struct User: Codable, Identifiable {
    let id: Int
    let name: String
    let username: String
    let email: String
    let address: Address   // nested
    let phone: String
    let website: String
    let company: Company   // nested
}
```

### Address
```swift
struct Address: Codable {
    let street, suite, city, zipcode: String
    let geo: Geo
    var formatted: String   // computed convenience property
}
```

### Company
```swift
struct Company: Codable {
    let name: String
    let catchPhrase: String
    let bs: String
}
```

---

## ⚠️ Error Handling

```swift
enum NetworkError: Error, LocalizedError {
    case invalidURL
    case requestFailed(Error)
    case invalidResponse
    case httpError(statusCode: Int)
    case decodingFailed(Error)
    case noInternetConnection
}
```

Each case exposes:
- `errorDescription` — detailed developer message
- `userFriendlyMessage` — safe message shown in UI

---

## 🔌 API

| Field | Value |
|---|---|
| Endpoint | https://jsonplaceholder.typicode.com/users |
| Method | GET |
| Auth | None |
| Response | [User] JSON array |

---

## 🧪 Testability

All major components are protocol-driven:

```swift
// Inject a mock during unit tests
let mockService = MockUserService()
let vm = UserListViewModel(userService: mockService)

// Inject a mock network layer into the service
let mockNetwork = MockNetworkManager()
let service = UserService(networkManager: mockNetwork)
```

---

## 🛠️ Requirements

- **iOS** 17.0+
- **Xcode** 15.0+
- **Swift** 5.9+
- No third-party dependencies

---

## 🚀 Getting Started

1. Clone the repository
2. Open `JSON Placeholder Users.xcodeproj` in Xcode
3. Select a simulator or device
4. Press ⌘R to build and run

> The app fetches live data — ensure the simulator/device has an active internet connection.

---

## 📁 File Reference

| File | Role |
|---|---|
| User.swift | All Codable data models |
| NetworkError.swift | Typed error definitions |
| NetworkManager.swift | Generic HTTP fetch layer |
| UserService.swift | Business-facing data service |
| UserListViewModel.swift | State + logic for list screen |
| UserListView.swift | Main list UI |
| UserCardView.swift | Individual user row card |
| UserDetailView.swift | Full user detail UI |

---

## 👨‍💻 Author

**Sachin Arkasali**

---

*Built as an LLD (Low Level Design) interview demonstration project.*
