import UIKit

// You're a food inspector. You receive a sorted list of temperatures (Int). Given a freezing threshold (Int), return the index of the first temperature that is greater than or equal to the threshold.

func firstFrozen(_ temps: [Int], _ threshold: Int) -> Int? {
    var left = 0
    var right = temps.count - 1

    while left <= right {
        var middle = (left + right)/2
        var guess = temps[middle]
        
        if guess == threshold {
            return middle
        } else if guess < threshold {
            left = middle + 1
        } else {
            right = middle - 1
        }
        
    }
    
    return nil
}

let temps = [-10, -4, -1, 0, 3, 7, 12]
let threshold = 0
firstFrozen(temps, threshold)
// expected output: 3
