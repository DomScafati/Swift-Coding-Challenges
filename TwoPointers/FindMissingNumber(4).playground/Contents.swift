import UIKit

/*
 You’re given an array containing n distinct numbers in the range 0...n. Return the one number that is missing from the array.
 use a two-pointer algorithm for this.
 */

func findMissingNumber(_ array: [Int]) -> Int? {
    var left = 0
    var right = array.count - 1
    let start = array[0]
    
    while left <= right {
        let mid = left + (right - left)/2
        let expected = start + mid
        
        if array[mid] == expected {
            left = mid + 1
        } else {
            right = mid - 1
        }
    }
    
    return start + left
}

func findMissingNumberWithSet(_ array: [Int]) -> Int {
    let expected = Set(0...array.count)     // All numbers from 0 to n
    let actual = Set(array)                 // Convert the array to a Set
    return expected.subtracting(actual).first!
}


var array1 = [0, 1,2,3,4,6] // 5
var array2 = [0, 1, 3, 4] // 2
print(findMissingNumber(array2))
