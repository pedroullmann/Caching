import Caching_Interface
import Foundation

public struct FileManagerService: CacheService {
    public static var identifier: CacheServiceIdentifier { .fileManager }

    private let fileManager: FileManager
    private let documentsDirectory: URL?
    private let encoder: JSONEncoder
    private let decoder: JSONDecoder

    public init(
        fileManager: FileManager = .default,
        encoder: JSONEncoder = .init(),
        decoder: JSONDecoder = .init()
    ) {
        self.fileManager = fileManager
        self.documentsDirectory = try? fileManager.url(
            for: .documentDirectory,
            in: .userDomainMask,
            appropriateFor: nil,
            create: true
        )
        self.encoder = encoder
        self.decoder = decoder
    }

    @discardableResult
    public func setValue<T: Codable>(
        _ value: T,
        forKey key: String
    ) -> Bool {
        guard let fileURL = documentsDirectory?.appendingPathComponent(key) else {
            return false
        }
        do {
            let data = try encoder.encode(value)
            try data.write(to: fileURL)
            return true
        } catch {
            return false
        }
    }

    public func getValue<T: Codable>(
        forKey key: String
    ) -> T? {
        guard
            let fileURL = documentsDirectory?.appendingPathComponent(key),
            let data = try? Data(contentsOf: fileURL),
            let value = try? decoder.decode(T.self, from: data)
        else {
            return nil
        }
        return value
    }

    @discardableResult
    public func removeObject(
        forKey key: String)
    -> Bool {
        guard let fileURL = documentsDirectory?.appendingPathComponent(key) else {
            return false
        }
        do {
            try fileManager.removeItem(at: fileURL)
            return true
        } catch {
            return true
        }
    }
}
