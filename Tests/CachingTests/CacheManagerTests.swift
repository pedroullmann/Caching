import XCTest
@testable import Caching

final class CacheManagerTests: XCTestCase {
    private let myObjectKey: String = "my-object-key"
    private let data: String = "my-object"
    private let manager = CacheManager.shared

    override func tearDown() {
        manager.removeObject(forKey: myObjectKey, service: .memory)
        manager.removeObject(forKey: myObjectKey, service: .fileManager)
        manager.removeObject(forKey: myObjectKey, service: .userDefaults)
        super.tearDown()
    }

    func test_setValue_and_getValue() {
        // When
        manager.setValue(data, forKey: myObjectKey, service: .memory)
        manager.setValue(data, forKey: myObjectKey, service: .fileManager)
        manager.setValue(data, forKey: myObjectKey, service: .userDefaults)

        let memory: String? = manager.getValue(forKey: myObjectKey, service: .memory)
        let fileManager: String? = manager.getValue(forKey: myObjectKey, service: .fileManager)
        let userDefaults: String? = manager.getValue(forKey: myObjectKey, service: .userDefaults)

        // Then
        XCTAssertEqual(memory, data)
        XCTAssertEqual(fileManager, data)
        XCTAssertEqual(userDefaults, data)
    }

    func test_removeObject() {
        // Given
        manager.setValue(data, forKey: myObjectKey, service: .memory)
        manager.setValue(data, forKey: myObjectKey, service: .fileManager)
        manager.setValue(data, forKey: myObjectKey, service: .userDefaults)

        // When
        manager.removeObject(forKey: myObjectKey, service: .memory)
        manager.removeObject(forKey: myObjectKey, service: .fileManager)
        manager.removeObject(forKey: myObjectKey, service: .userDefaults)

        let memory: String? = manager.getValue(forKey: myObjectKey, service: .memory)
        let fileManager: String? = manager.getValue(forKey: myObjectKey, service: .fileManager)
        let userDefaults: String? = manager.getValue(forKey: myObjectKey, service: .userDefaults)

        // Then
        XCTAssertNil(memory)
        XCTAssertNil(fileManager)
        XCTAssertNil(userDefaults)
    }
}
