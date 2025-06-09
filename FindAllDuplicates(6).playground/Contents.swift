import UIKit
/*
 Given an array of integers where each value is between 1 and n (where n is the length of the array), return all elements that appear more than once.
 
 You should return each duplicate only once, regardless of how many times it repeats.
 */
var greeting = "Hello, playground"

func returnDuplicates(array: [Int]) -> [Int] {
    let highestValue = array.count
    let lowestValue = 1
    var dictionary = [Int:Int]() // the integer and the count of the integer
    var duplicates = [Int]()
    guard !array.isEmpty else {
        return []
    }
    for int in array {
        dictionary[int, default: 0] += 1
    }
    
    for (key, value) in dictionary {
        if value > 1 {
            duplicates.append(key)
        }
    }
    return duplicates
}
let array1 = [1, 1, 1, 3, 2, 4, 5, 5] // should return 1, 5
let array2 = [Int]()
returnDuplicates(array: array1)
returnDuplicates(array: array2)
