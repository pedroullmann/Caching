import Foundation

public protocol CacheService {
    static var identifier: CacheServiceIdentifier { get }

    @discardableResult
    func setValue<T: Codable>(
        _ value: T,
        forKey key: String
    ) -> Bool

    func getValue<T: Codable>(
        forKey key: String
    ) -> T?

    @discardableResult
    func removeObject(
        forKey key: String
    ) -> Bool
}

