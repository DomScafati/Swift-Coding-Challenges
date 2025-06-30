import UIKit

/*
 binary search is entirely dependent on the array being sorted.
 Write a function that returns the index of a given number in a sorted array.
 If the number is not found, return -1.
 */

func binarySearch(_ array: [Int], _ target: Int) -> Int? {
    var left = 0
    var right = array.count - 1
    
    while left <= right {
        var middle = (left + right) / 2
        var guess = array[middle]
        
        if guess == target {
            return middle
        } else if guess < target {
            left = middle + 1
        } else {
            right = middle - 1
        }
    }
 return nil
}

var array1 = [1,2,3,4,5,6,7,8,9]

print(binarySearch(array1, 9))
