# Caching

## Adding to your project

Add the following to the `dependencies` array in your "Package.swift" file:

     .package(url: "https://github.com/pedroullmann/Caching.git", from: Version("1.0.0"))

## Cache Services

### UserDefaults

UserDefaults caching storage is best suited for storing small amounts of data, such as user preferences, app settings, etc. UserDefaults is persistent, and the stored data will remain even after the app is closed.

### Memory

Memory caching storage is best suited for storing data that is frequently accessed and modified, such as image data or table view display data. Memory is limited, and the stored data will be lost when the app is closed. However, accessing data stored in memory is very fast.

### FileManager
FileManager caching storage is best suited for storing large amounts of data, such as image files, videos, audios, etc. FileManager is persistent, and the stored data will remain even after the app is closed. However, accessing data stored in the file system can be slower than accessing data stored in memory.

## Usage

```swift
let manager = CacheManager.shared

let data: CodableData = Mock()

/// Save (discardable result)
manager.setValue(data, forKey: "key", identifier: .memory)

/// Restore
let dataInMemory: CodableData? = manager.getValue(forKey: "Key", identifier: .memory)

/// Remove (discardable result)
manager.removeObject(forKey: "Key", identifier: .memory)
```
