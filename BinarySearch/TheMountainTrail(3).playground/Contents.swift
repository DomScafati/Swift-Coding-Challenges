import UIKit

// You're a park ranger with a sorted list of altitude markers (Int) along a trail. Return true if a target altitude exists on the trail, false if it doesn't.

func findAltitude(_ trail: [Int], _ target: Int) -> Bool {
    var left = 0
    var right = trail.count - 1

    while left <= right {
        var middle = (left + right)/2
        var guess = trail[middle]
        if guess == target {
            return true
        } else if guess < target {
            left = middle + 1
        } else {
            right = middle - 1
        }
    }
    
    return false
}

let trail = [120, 340, 490, 610, 780, 920]
let target = 610
findAltitude(trail, target)
// expected output: true
