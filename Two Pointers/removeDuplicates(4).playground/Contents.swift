import UIKit

/*
 Given a sorted array of integers, remove the duplicates in-place so that each element appears only once.

 Return the number of unique elements.

 You must not use extra space for another array—just modify the input array in-place as much as needed.
 
 note:
 fast pointer: scans through every element quickly, looking for interesting stuff.
 slow pointer: marks where we should put the next interesting thing.


 */

func removeDuplicates(_ array: inout [Int]) -> Int {
    if array.isEmpty { return 0 }
    
    var slow = 0
    
    for fast in 1..<array.count {
        if array[fast] != array[slow] {
            slow += 1
            array[slow] = array[fast]
        }
    }
    
    return slow + 1
}

var nums1 = [1, 1, 2]
var nums2 = [0,0,1,1,1,2,2,3,3,4]
var nums3 = [1,2,3,4,5]
var nums4 = [1]
var nums5 = []
