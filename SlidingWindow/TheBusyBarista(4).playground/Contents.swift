import UIKit

// You work at a coffee shop. You receive an unsorted list of order wait times (Int) in minutes. Your manager wants to know: given a maximum wait window (Int), what is the maximum number of orders that could have been fulfilled within that window?

func coffeeList(_ list: [Int], _ window: Int) -> Int {
    var sorted = list.sorted()
    var left = 0
    var right = 0
    var count = 0
    for right in 1..<sorted.count {
        while sorted[right] - sorted[left] > window {
            left += 1
            // stuck
        }
    }
    
    return 0
}

// Test 1
let orders1 = [8, 3, 1, 5, 2, 7]
let window1 = 4
coffeeList(orders1, window1)
// expected output: 3 [1, 2, 3] or [3, 5, 7] won't work, think carefully!

// Test 2
let orders2 = [10, 2, 8, 4, 6]
let window2 = 5
coffeeList(orders2, window2)
// output: 3 [4, 6, 8] fits within a window of 5 (8-4=4... wait is that right? you tell me!)

// Test 3 - edge case
let orders3 = [1, 1, 1, 1]
let window3 = 0
coffeeList(orders3, window3)

// output: 4 all orders take the same time
