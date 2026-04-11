import UIKit
// You're judging a tug of war. You receive a sorted list of team weights (Int). Return true if any two players together equal the target combined weight.

func canBalance(_ weights: [Int], _ target: Int) -> Bool {
    var left = 0
    var right = weights.count - 1
    
    while left <= right {
        var guess = weights[left] + weights[right]
        
        if guess == target {
            return true
        } else if guess < target {
            left += 1
        } else {
            right -= 1
        }
    }
    
    return false
}

let weights = [1, 4, 6, 8, 11]
let target = 15
canBalance(weights, target)
// expected output: true
