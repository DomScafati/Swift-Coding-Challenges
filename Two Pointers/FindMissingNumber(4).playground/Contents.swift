import UIKit

/*
 You’re given an array containing n distinct numbers in the range 0...n. Return the one number that is missing from the array.
 */

func findMissingNumber(_ array: [Int]) -> Int? {
    var previous: Int?
    
    for num in array {
        
        if let prevNum = previous,
           prevNum + 1 != num {
            return prevNum + 1
        }
        previous = num
    }
    
    return nil
}

func findMissingNumberWithSet(_ array: [Int]) -> Int {
    let expected = Set(0...array.count)     // All numbers from 0 to n
    let actual = Set(array)                 // Convert the array to a Set
    return expected.subtracting(actual).first!
}


var array1 = [0, 1,2,3,4,6] // 5
var array2 = [0, 1, 3, 4] // 2
print(findMissingNumber(array1))
