import UIKit

// You're a pharmacist. You receive an unsorted list of prescription fill times (Int). Given a time window (Int), return the maximum number of prescriptions that could be filled within that window.
//Expand — move right forward
//Fix — shrink from left until window is valid
//Measure — calculate count from indices
//Record — update max if needed

func maxPrescriptions(_ fillTimes: [Int], _ window: Int) -> Int {
    var count = 0
    var maxCount = 0
    var sorted = fillTimes.sorted()
    var left = 0
    var right = 1
    
    while right < sorted.count {
        while sorted[right] - sorted[left] > window {
            left += 1
        }
        
        let count = right - left + 1
        
        if count > maxCount {
            maxCount = count
        }
        
        right += 1
    }
    
    return maxCount
}

let fillTimes = [2, 5, 1, 4, 3, 8, 6] // 1 2 3 4 5 6 8
let window = 3
maxPrescriptions(fillTimes, window)
// expected output: 3

