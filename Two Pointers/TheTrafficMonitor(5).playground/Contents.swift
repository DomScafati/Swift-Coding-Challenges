import UIKit

// You're a highway traffic monitor. You receive an unsorted list of vehicle speeds (Int). Given a speed range (Int), return the maximum number of vehicles traveling within that speed range of each other.

// Create the loop
// Adjust the window if its too big using a loop
// figure out the current count
// check count vs max count

func maxCars(_ speeds: [Int], _ window: Int) -> Int {
    var sorted = speeds.sorted()
    var left = 0
    var right = 0
    var maxCount = 0
    
    while right < sorted.count {
        
        while sorted[right] - sorted[left] > window {
            left += 1
        }
        
        var count = right - left + 1

        if count > maxCount {
            maxCount = count
        }
        
        right += 1
    }
    
    return maxCount
}

let speeds = [45, 60, 30, 75, 55, 40, 65, 80]
let window = 20

maxCars(speeds, window)
// expected output: 4
