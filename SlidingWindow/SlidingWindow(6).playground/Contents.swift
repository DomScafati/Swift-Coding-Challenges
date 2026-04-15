import UIKit

// Given an array of delivery times and a time window W, find the maximum number of deliveries that can be completed where the difference between the earliest and latest delivery time in a group is within the window W.

func maxDeliveries(_ times: [Int], _ window: Int) -> Int {
    let sorted = times.sorted() // ensure the array is sorted
    var left = 0 // left index
    var maxCount = 0 // tracking deliveries
    
    for right in 0..<sorted.count {
        while sorted[right] - sorted[left] > window {
            left += 1
        }
        maxCount = max(maxCount, right - left + 1)
    }
    
    return maxCount
}

// You're a park ranger monitoring wildlife. You have an array of timestamps (Int) representing when animals were spotted. Given a time range (Int), return the maximum number of animal sightings that occurred within any single time range.

func maxSightings(_ timestamps: [Int], _ range: Int) -> Int {
    let sorted = timestamps.sorted() // sort so all timestamps in any valid window are contiguous
    var maxCount = 0 // track the best window size we've seen
    var left = 0 // left pointer, marks the start of the current window
    var right = 0 // right pointer, marks the end of the current window
    
    while right < sorted.count { // expand right until we've checked every element
        while sorted[right] - sorted[left] > range { // if the window is too large...
            left += 1 // ...shrink from the left until it's valid again
        }
        let currentCount = right - left + 1 // count elements in the current valid window
        if currentCount > maxCount { // if this window is the biggest we've seen...
            maxCount = currentCount // ...save it
        }
        right += 1 // move right pointer forward to expand the window
    }
    
    return maxCount // return the size of the largest valid window found
}

let times1 = [1, 3, 6, 7, 10, 15]
let window = 5
maxSightings(times1, window) // expecting 3

