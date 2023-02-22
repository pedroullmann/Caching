import Foundation

public protocol CacheManagerProtocol: AnyObject {
    @discardableResult
    func setValue<T: Codable>(
        _ value: T,
        forKey key: String,
        service: CacheServiceIdentifier
    ) -> Bool

    func getValue<T: Codable>(
        forKey key: String,
        service: CacheServiceIdentifier
    ) -> T?

    @discardableResult
    func removeObject(
        forKey key: String,
        service: CacheServiceIdentifier
    ) -> Bool
}
