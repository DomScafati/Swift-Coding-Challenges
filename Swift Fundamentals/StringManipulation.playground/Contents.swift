import UIKit

// String indexes cannot be used inherently
var string1 = "hello"
let start = string1.startIndex
let end = string1.index(start, offsetBy: string1.count - 1)
let char = string1[end]
let slice = string1[start...end]
let substring = String(slice)

