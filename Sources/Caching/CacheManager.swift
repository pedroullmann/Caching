import Caching_Interface
import Foundation

public final class CacheManager: CacheManagerProtocol {
    private let services: [CacheService]

    public static var shared: CacheManager {
        CacheManager()
    }

    private init(
        services: [CacheService] = [
            FileManagerService(),
            MemoryService(),
            UserDefaultsService()
        ]
    ) {
        self.services = services
    }

    @discardableResult
    public func setValue<T: Codable>(
        _ value: T,
        forKey key: String,
        service: CacheServiceIdentifier
    ) -> Bool {
        guard let service = getService(service) else { return false }
        return service.setValue(value, forKey: key)
    }

    public func getValue<T: Codable>(
        forKey key: String,
        service: CacheServiceIdentifier
    ) -> T? {
        guard let service = getService(service) else { return nil }
        return service.getValue(forKey: key)
    }

    @discardableResult
    public func removeObject(
        forKey key: String,
        service: CacheServiceIdentifier
    ) -> Bool {
        guard let service = getService(service) else { return false }
        return service.removeObject(forKey: key)
    }

    private func getService(
        _ service: CacheServiceIdentifier
    ) -> CacheService? {
        services.first(where: { type(of: $0).identifier == service })
    }
}
