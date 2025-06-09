import UIKit

/*
 Given a sorted array of integers and a target value, determine if there are any two numbers in the array that add up exactly to the target.

 Return true if such a pair exists, otherwise return false.
 */

var array1 = [1, 2, 3, 4, 5, 6, 11, 19, 20, 25, 25, 100, 200, 201]

func pairSum(_ array: [Int], target: Int) -> Bool {
    var left = 0
    var right = array.count - 1
    
    while left < right {
        var guess = array[left] + array[right]
        
        if guess == target {
            return true
        } else if guess < target {
            left += 1
        } else {
            right -= 1
        }
    }
    return false
}

var array2 = [1,2,3,4,5, 100, 200, 233]
print(pairSum(array2, target: 101))
print(pairSum(array2, target: 7))
print(pairSum(array2, target: 2))


