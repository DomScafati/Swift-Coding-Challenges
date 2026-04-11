import UIKit

// You're a librarian with a sorted catalog of book ISBNs. Given a target ISBN, return its index in the catalog, or nil if it doesn't exist.

func findBook(_ catalog: [Int], _ isbn: Int) -> Int? {
    var left = 0
    var right = catalog.count - 1
    
    while left <= right {
        var middle = left + (right - left)/2
        if catalog[middle] == isbn {
            return middle
        } else if catalog[middle] < isbn {
            left = middle + 1
        } else {
            right = middle - 1
        }
    }
    
    return nil
}

let catalog = [102, 215, 334, 478, 556, 623, 789]
let isbn = 478
findBook(catalog, isbn)
// expected output: 3 (the index)
