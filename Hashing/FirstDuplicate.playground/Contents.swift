import UIKit

/*
Given an array of integers, return the first number that appears more than once.
If no duplicates exist, return nil.

Return the first duplicate by position, not by value.
*/

func firstDuplicate(_ collection: [Int]) -> Int? {
    var answer: Int?
    var dict: [Int: Int] = [:]
    
    for num in collection {
        dict[num, default: 0] += 1
        
        if dict[num]! > 1 {
            return num
        }
    }
    
    return answer
}

let array1 = [1,2,1,1] // returns 1
let array2 = [1,2,3,4,3] // returns 1
let array3 = [1,2,3] // returns nil

print(firstDuplicate(array1))
print(firstDuplicate(array2))
print(firstDuplicate(array3))

