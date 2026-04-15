import UIKit

// MARK: - Map functions
// map
let array1 = [1, 2, 3, 4, 5, 6]
let mappedArray = array1.map { $0 * 2}

// flat map
let matrix = [
    [1, 2, 3],
    [4, 5, 6],
    [7, 8, 9]
]
let flatMappedArray = matrix.flatMap { $0.map { $0 + 1 } }

// compact map
let array2 = [1, 2, nil, 4, nil, 6, nil, nil, 9]
let compactedArray = array2.compactMap { $0 }

// MARK: - Sort
// basic sort
let array3 = [4, 2, 1, 3]
let sortedArray1 = array3.sorted()

// logic note: IF the left item is LESS THAN the right, THEN keep this order ELSE swap them
var array4 = [3, 3, 8, 10]
let sortedArray2 = array4.sorted { $0 < $1 } // returns [10, 8, 3, 3]
array4.sort { $0 < $1 }

// MARK: - Filters
// prefix filters an array by returning every element until the conditional fails.
let array5 = [1, 2, 3, 4, 5, 6]

//WHILE TRUE, give me the front part.
let prefixedArray = array5.prefix { $0 < 6 }

// WHILE TRUE, remove the front part
let dropArray = array5.drop { $0 < 6 }

// MARK: - Reducers
let array6 = [1, 2, 3, 4, 5]
let reducedArray1 = array6.reduce(0) { result, next in
    // 0 = starting value
    // result = running total
    // next = each element
    result + next
}

// shorthand for the above
let reducedArray2 = array6.reduce(0, +)
