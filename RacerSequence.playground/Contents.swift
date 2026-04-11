import UIKit

// You're a marathon race director. Runners check in at various checkpoints along the route, and you receive their checkpoint numbers (Int) in the order they checked in. A valid race sequence requires a runner to hit checkpoints in a perfectly consecutive order with no gaps, starting from any checkpoint. Return the length of the longest valid sequence any runner achieved.

func sequence(_ route: [Int]) -> Int {
    let sorted = route.sorted()
    var highestCount = 0
    var currentCount = 1
    var expectedNext = sorted[0] + 1 // prime expectedNext from the first element
    
    for num in sorted.dropFirst() { // skip the first element since we already primed from it
        if num == expectedNext {
            currentCount += 1
        } else {
            currentCount = 1
        }
        expectedNext = num + 1
        highestCount = max(highestCount, currentCount) // check at the bottom so we never miss the final count
    }
    return highestCount
}


let checkpoints = [100, 4, 200, 1, 3, 2] // 1 2 3 4 100 200
sequence(checkpoints)
// expected output: 4
