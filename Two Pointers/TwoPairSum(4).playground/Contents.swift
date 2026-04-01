import UIKit

/*
 Problem: Pair With Target Sum

 Given a sorted array of integers and a target value, return true if there exists a pair of numbers that add up to the target. Otherwise, return false.
 */

func pairSum(_ array: [Int], _ target: Int) -> Bool {
    var left = 0
    var right = array.count - 1
    
    while left < right {
        var guess = array[left] + array[right]
        if guess == target {
            return true
        } else if guess > target {
            right -= 1
        } else if guess < target {
            left += 1
        }
    }
    return false
}

let arrayA = [1,2,3,4,5,6,7,8,9,10]
let targetA = 11
let arrayB = [10,20,30,40,50,60,70,80,90,1000]
let targetB = 100

print(pairSum(arrayB, targetB))

