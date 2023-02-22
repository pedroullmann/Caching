import Caching_Interface
import Combine
import Foundation

public struct UserDefaultsService: CacheService {
    public static var identifier: CacheServiceIdentifier { .userDefaults }
    private let userDefaults: UserDefaults

    public init(userDefaults: UserDefaults = .standard) {
        self.userDefaults = userDefaults
    }

    @discardableResult
    public func setValue<T: Codable>(_ value: T, forKey key: String) -> Bool {
        userDefaults.set(value, forKey: key)
        return true
    }

    public func getValue<T: Codable>(forKey key: String) -> T? {
        userDefaults.value(forKey: key) as? T
    }

    @discardableResult
    public func removeObject(forKey key: String) -> Bool {
        userDefaults.removeObject(forKey: key)
        return true
    }
}
