import UIKit
import SwiftUI

// MARK: - Any
// You cannot make induvidual properties generic!
func workWithAny() {
    var anyProperty: Any
    var description: String
    let rng = Int.random(in: 1...4)
    
    switch rng {
    case 1:
        anyProperty = "Hello World!"
        description = "\(anyProperty) is a \(String.self)"
    case 2:
        anyProperty = 9001
        description = "\(anyProperty) is an \(Int.self)"
    case 3:
        anyProperty = 2.0
        description = "\(anyProperty) is a \(Float.self)"
    default:
        anyProperty = Image("")
        description = "\(anyProperty) is an \(Image.self)"
    }
    
    print(description)
}

workWithAny()

// MARK: - Containers
// you have to either use a wrapper struct/class if you want to mark a property as generic.
struct Containter<T> {
    var item: T
}

func containerFunc() {
    var myString = "Hello World!"
    let myBox = Containter(item: myString)
    print(myBox.item)
}

containerFunc()

// MARK: - Associated Type
// Different than generics in that they A) are used only with protocols and B) have to be known at build-time.
protocol MyProtocol {
    associatedtype V
    var value: V { get }
}

struct Box: MyProtocol {
    typealias V = String
    var value: String
}

print(Box(value: "This is my string"))
