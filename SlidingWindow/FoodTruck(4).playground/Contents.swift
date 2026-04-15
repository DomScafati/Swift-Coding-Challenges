import UIKit

// You're running a food truck. You have an unsorted list of customer arrival times (Int). Given a time window (Int), return the maximum number of customers you could serve in that window.

func maxCustomers(_ arrivals: [Int], _ window: Int) -> Int {
    var sorted = arrivals.sorted()
    var currentCount = 0
    var highestCount = 1
    var left = 0
    var right = 0
    
    while right < sorted.count {
        currentCount += 1
        if (sorted[right] - sorted[left]) > window {
            left += 1
            currentCount = right - left + 1
        }
        
        if currentCount > highestCount {
            highestCount = currentCount
        }

        right += 1
    }
    
    return highestCount
}

let arrivals = [1, 3, 5, 6, 8, 12]
let window = 4
maxCustomers(arrivals, window)
// expected output: 3
