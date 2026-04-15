import UIKit

// You're a teacher. You receive an unsorted list of student IDs (Int) where some students may have checked in more than once by mistake. Return the ID of the first student who checked in more than once, in the order they appear in the list.

func doubleCheck(_ array: [Int]) -> Int? {
    var dict = [Int:Int]()
    
    for id in array {
        dict[id, default: 0] += 1
        
        if dict[id]! > 1 {
            return id
        }
    }
    
    return nil
}

// Test 1
let ids1 = [3, 5, 2, 7, 3, 8, 5]
doubleCheck(ids1)
//output: 3 3 appears twice, and shows up as a duplicate before 5 does

// Test 2
let ids2 = [1, 2, 3, 4, 5, 1]
doubleCheck(ids2)
// output: 1

// Test 3 - edge case
let ids3 = [1, 2, 3, 4, 5]
doubleCheck(ids3)
// output: nil no duplicates
