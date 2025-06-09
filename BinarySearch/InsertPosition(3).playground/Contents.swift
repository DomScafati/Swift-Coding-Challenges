import UIKit
/*
 Given a sorted array of distinct integers and a target value, return the index if the target is found.
 If not, return the index where it would be inserted in order to keep the array sorted.
 
 Input: nums = [1,3,5,6], target = 5
 Output: 2

 Input: nums = [1,3,5,6], target = 2
 Output: 1

 Input: nums = [1,3,5,6], target = 7
 Output: 4

 Input: nums = [1,3,5,6], target = 0
 Output: 0

*/
var array = [1, 2, 3, 4, 5]

func searchInsert(_ nums: [Int], _ target: Int) -> Int {
    var result = nums[0]
    var left = 0
    var right = nums.count - 1
    while left <= right {
        var middle = (left + right)/2
        var guess = nums[middle]
        if guess == target {
            return middle
        } else if guess > target {
            right = middle - 1
        } else {
            left = middle + 1
        }
    }
    
    
    return left
}

print(searchInsert(array, 2))
