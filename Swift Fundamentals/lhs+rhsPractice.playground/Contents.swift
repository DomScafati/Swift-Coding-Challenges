import UIKit


// Method 1
// Wrap Int in your type and overload + there
struct IntBox {
    var value: Int
}

extension IntBox {
    static func + (lhs: IntBox, rhs: IntBox) -> IntBox {
        return IntBox(value: lhs.value + rhs.value)
    }
}

let a = IntBox(value: 10)
let b = IntBox(value: 5)
let c = a + b

// Method 2
// Define new operator
infix operator +++: AdditionPrecedence
func +++(lhs: Int, rhs: Int) -> Int {
    return lhs + rhs
}

let d = 10
let e = 5
let f = d+++e
