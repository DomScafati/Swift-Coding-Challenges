import SwiftUI

final class GenericCache <Key: Hashable, Value> {
    var store = [Key:Value]()
    
    func get(at key: Key) -> Value? {
        return store[key]
    }
    
    func set(_ value: Value, for key: Key) {
        store[key] = value
    }
    
    func remove(at key: Key) {
        store.removeValue(forKey: key)
    }
    
    func clear() {
        store = [:]
    }
}
