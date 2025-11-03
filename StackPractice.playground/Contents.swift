import UIKit

struct Stack<T> {
    private var elements: [T] = []
    
    var isEmpty: Bool {
        return elements.isEmpty
    }
    
    var count: Int {
        return elements.count
    }
    
    mutating func pop() -> T?{
        return elements.removeLast()
    }
    
    mutating func add(_ value: T) {
        elements.append(value)
    }
    
    mutating func peek() -> T? {
        return elements.last
    }
    
}

class NewStack <T> {
    private var elements: [T] = []
    
    var isEmpty: Bool {
        return elements.isEmpty
    }
    
    var count: Int {
        return elements.count
    }
    
    func pop() -> T? {
        return elements.removeLast()
    }
    
    func add(_ value: T) {
        elements.append(value)
    }
    
    func clear() {
        elements = []
    }
    
    func peak() -> T? {
        return elements.last
    }
}
