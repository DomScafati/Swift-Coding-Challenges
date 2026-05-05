import Foundation

// Sliding Window Challenge
//
// Phrases/patterns that signal "Sliding Window":
// "best / highest / lowest over K consecutive..."     → fixed window, slide and track best
// "every group of K elements..."                      → fixed window, process each position
// "how many stretches of K days..."                   → fixed window, count qualifying windows
// "within a range / window of N days"                 → window boundary condition
// "consecutive stretch / run / sequence"              → think window before thinking loop-in-loop

// You run a food stall at Fernwood Weekend Market.
// You track daily sales figures and need to pull reports
// to decide staffing and spot your strongest trading windows.

// ============================================================
// MARK: - Challenge 1 (Best Window): Highest Sales Over K Days
// ============================================================
/*
 Story: The market committee awards a "Top Trader" trophy to the stall
 with the highest combined sales across any K consecutive trading days.
 You need to find your best K-day total to submit for consideration.

 Task: Given an array of daily sales figures and a window size K,
 return the highest combined total across any K consecutive days.

 Requirements:
 1. Implement: func bestWindow(_ sales: [Int], days k: Int) -> Int
    - Sum the first K elements to get your starting window total
    - Slide the window forward one day at a time:
        drop the oldest day (the one leaving the left side)
        add the newest day (the one entering the right side)
    - After each slide, check if the new total beats your current best
    - Return the highest total found
    - You can assume sales.count >= k and k >= 1
 */

// MARK: Pre-defined (do not modify)

let stallA: [Int] = [40, 15, 60, 80, 35, 50, 70]   // k=3 → best is [60,80,35] = 175
let stallB: [Int] = [10, 20, 30, 10, 20]            // k=2 → best is [20,30] = 50
let stallC: [Int] = [100, 200, 50]                  // k=1 → best single day = 200

// MARK: Your solution (Challenge 1)

func bestWindow(_ sales: [Int], days k: Int) -> Int {
    var highestTotal = 0
    var windowSum = 0
    
    for num in stride(from: 0, through: k, by: 1) {
        highestTotal += num
    }
    
    for num in k...sales.count {
         windowSum = windowSum - sales[num - k] + sales[num]
        if windowSum > highestTotal {
            highestTotal = windowSum
        }
    }
    return highestTotal
}


// MARK: Tests (Challenge 1) — uncomment as you go

 assert(bestWindow(stallA, days: 3) == 175)
// assert(bestWindow(stallB, days: 2) == 50)
// assert(bestWindow(stallC, days: 1) == 200)
// print("Challenge 1 passed!")


// ============================================================
// MARK: - Challenge 2 (Target Days): Count Strong Windows
// ============================================================
/*
 Story: Your supplier gives a discount whenever you can show K consecutive
 days where combined sales beat a target figure. You want to count how
 many such windows exist in your records to see how often you qualify.

 Task: Given an array of daily sales, a window size K, and a target,
 return the number of K-day windows whose total is strictly greater
 than the target.

 Requirements:
 1. Implement: func strongWindows(_ sales: [Int], days k: Int, target: Int) -> Int
    - Use the same sliding approach as Challenge 1
    - Instead of tracking the best, keep a running count
    - Increment the count each time a window total is greater than the target
    - Return the final count
 */

// MARK: Pre-defined (do not modify)

let recordA: [Int] = [40, 15, 60, 80, 35, 50, 70]  // k=3, target=160 → windows: 115,155,175,165,155 → count=2
let recordB: [Int] = [10, 20, 30, 40]               // k=2, target=45  → windows: 30,50,70 → count=2
let recordC: [Int] = [5, 5, 5, 5]                   // k=2, target=20  → windows: 10,10,10 → count=0

// MARK: Your solution (Challenge 2)



// MARK: Tests (Challenge 2) — uncomment as you go

// assert(strongWindows(recordA, days: 3, target: 160) == 2)
// assert(strongWindows(recordB, days: 2, target: 45) == 2)
// assert(strongWindows(recordC, days: 2, target: 20) == 0)
// print("Challenge 2 passed!")
