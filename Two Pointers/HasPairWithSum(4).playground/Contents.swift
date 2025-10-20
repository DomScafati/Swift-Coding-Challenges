import UIKit

var greeting = [1, 2, 3, 4, 5, 6, 6, 7, 10, 20]

/*
 Given a sorted array of integers, write a function that determines if there exist two numbers such that their sum is equal to a given target.

 Return true if such a pair exists, false otherwise.
 */

func hasPairWithSum(array: [Int], target: Int) -> Bool {
    var leftIndex = 0
    var rightIndex = array.count - 1
    
    while leftIndex < rightIndex {
        var sum = array[leftIndex] + array[rightIndex]
        if  sum == target {
            return true
        } else if sum < target {
            leftIndex += 1
        } else {
            rightIndex -= 1
        }
    }
    
    return false
}
func hasPairWithSumUnordered(array: [Int], target: Int) -> Bool {
    var left = 0
    
    while left < array.count - 1 {
        for right in stride(from: array.count - 1, to: left, by: -1) {
            let guess = array[left] + array[right]
            if guess == target {
                return true
            }
        }
        left += 1
    }
    
    return false
}


// ✅ Basic positive case
let nums1 = [1, 2, 4, 7, 11, 15]
let target1 = 15 // true (4 + 11)
print(hasPairWithSum(array: nums1, target: target1))

let nums2 = [1, 3, 5, 7, 9]
let target2 = 10 // true (1 + 9 or 3 + 7)
print(hasPairWithSum(array: nums2, target: target2))

let nums3 = [1, 2, 3, 4]
let target3 = 10 // false
print(hasPairWithSum(array: nums3, target: target3))
// ⚠️ Edge cases
let nums4: [Int] = []
let target4 = 5 // false

let nums5 = [3]
let target5 = 6 // false

// ✅ With negative numbers
let nums6 = [-10, -5, 0, 3, 8, 12]
let target6 = 3 // true (-5 + 8)

let nums7 = [-10, -3, -1, 0]
let target7 = -4 // true (-3 + -1)

// ✅ With duplicates
let nums8 = [1, 2, 2, 3, 4]
let target8 = 4 // true (2 + 2)

let nums9 = [1, 1, 1, 1]
let target9 = 3 // false

// ✅ Target is zero
let nums10 = [-4, -2, 0, 2, 4]
let target10 = 0 // true (-4 + 4 or -2 + 2)
