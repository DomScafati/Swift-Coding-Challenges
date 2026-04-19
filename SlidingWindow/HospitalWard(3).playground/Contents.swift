import UIKit

// You're a hospital administrator. You receive an unsorted list of patient check-in times (Int). Given a time window (Int), return the maximum number of patients that checked in within that window.
// 💡 Hint — keywords to watch for: "maximum number", "within a range/window", "unsorted list of times." When you see these together, think sliding window.

func maxPatients(_ checkIns: [Int], _ window: Int) -> Int {
    var sorted = checkIns.sorted()
    
    var left = 0
    var right = 1
    
    var count = 0
    var maxCount = 0
    
    while right < sorted.count {
        
        while (sorted[right] - sorted[left]) >= window {
            left += 1
        }
        
        count = right - left + 1
        
        if count > maxCount {
            maxCount = count
        }
        
        right += 1
    }
    
    return maxCount
}

let checkIns = [3, 7, 1, 9, 4, 6, 2, 8] // 1 2 3 4 6 7 8 9
let window = 5
maxPatients(checkIns, window)
// expected output: 4
