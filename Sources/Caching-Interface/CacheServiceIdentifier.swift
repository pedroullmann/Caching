import Foundation

public typealias CacheServiceIdentifier = String

public extension CacheServiceIdentifier {
    static let userDefaults: Self = "UserDefaults"
    static let memory: Self = "Memory"
    static let fileManager: Self = "FileManager"
}

public extension Set where Element == CacheServiceIdentifier {
    static func all() -> Set<CacheServiceIdentifier> {
        Set([.userDefaults, .memory, .fileManager])
    }
}
