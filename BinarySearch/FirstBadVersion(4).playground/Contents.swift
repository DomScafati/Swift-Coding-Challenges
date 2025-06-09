import UIKit

/*
 
 There is a version history from 1 to n. You are guaranteed that:

 All versions before a certain version are good

 All versions from that version on are bad

 📌 Your job is to find the first bad version, using the minimum number of calls to isBadVersion.


 */


// 1. Simulate the hidden first bad version
let firstBroken = 4

// 2. Simulated API function provided by the system
func isBadVersion(_ version: Int) -> Bool {
    return version >= firstBroken
}

func firstBadVersion(_ n: Int) -> Int {
    var array = [Int]()
    for num in stride(from: 1, to: n, by: 1) {
        array.append(num)
    }
    
    var left = 0
    var right = array.count - 1
    var middle = (left + right)/2
    var result = n
    
    while left <= right {
        var guess = array[middle]
        if isBadVersion(guess) {
            result = guess
            right = middle - 1
        } else {
            left = middle + 1
        }
            return result
    }
    return -1
}

print(firstBadVersion(10))
