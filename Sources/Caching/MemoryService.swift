import Foundation
import Caching_Interface

public struct MemoryService: CacheService {
    public static var identifier: CacheServiceIdentifier { .memory }

    private let cache: NSCache<NSString, NSData>
    private let encoder: JSONEncoder
    private let decoder: JSONDecoder

    public init(
        cache: NSCache<NSString, NSData> = .init(),
        encoder: JSONEncoder = .init(),
        decoder: JSONDecoder = .init()
    ) {
        self.cache = cache
        self.encoder = encoder
        self.decoder = decoder
    }

    @discardableResult
    public func setValue<T: Codable>(
        _ value: T,
        forKey key: String
    ) -> Bool {
        guard let data = try? encoder.encode(value) else {
            return false
        }
        cache.setObject(NSData(data: data), forKey: NSString(string: key))
        return true
    }

    public func getValue<T: Codable>(
        forKey key: String
    ) -> T? {
        guard
            let data = cache.object(forKey: NSString(string: key)) as Data?,
            let value = try? decoder.decode(T.self, from: data)
        else {
            return nil
        }
        return value
    }

    @discardableResult
    public func removeObject(
        forKey key: String
    ) -> Bool {
        cache.removeObject(forKey: NSString(string: key))
        return true
    }
}
