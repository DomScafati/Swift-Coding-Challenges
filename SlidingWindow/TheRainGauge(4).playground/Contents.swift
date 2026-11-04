import Foundation

// Sliding Window Challenge
//
// Phrases/patterns that signal "Sliding Window":
// "most / best / highest in any K consecutive..."     → fixed window, slide and track the best
// "every block of K days..."                          → fixed window, process each position
// "longest / shortest stretch where..."               → variable window, expand then shrink
// "at most N / no more than N / stays under..."       → shrink while the rule is broken
// "consecutive stretch / run / sequence"              → think window before thinking loop-in-loop

// You keep the rain gauge at Hollow Creek vineyard. Each reading is the
// millimetres of rain that fell on one day, and a day counts as "wet" if
// its reading is above 0. The crew plans the harvest around the weather.

// ============================================================
// MARK: - Challenge 1 (The Equipment Block): Fixed Sliding Window
// ============================================================
/*
 The crew books the press equipment in blocks of k consecutive days.
 Before booking, you want the worst case: the most wet days that fall
 inside any one block.

 Given the daily rainfall readings and a block length k, return the
 largest number of wet days found in any k consecutive days.
 A day is wet if its reading is above 0.

 func mostWetDays(_ rainfall: [Int], k: Int) -> Int

 Hint: build the first block by hand, then slide one day at a time.
 The number you keep up to date is a count of wet days, not a sum.
*/

// MARK: Pre-defined (do not modify)
let spring: [Int] = [0, 4, 0, 7, 2, 5, 0, 0, 3, 0]      // wet days: 0 1 0 1 1 1 0 0 1 0
let earlyRains: [Int] = [3, 6, 0, 0, 0, 2, 0]           // wet days: 1 1 0 0 0 1 0
let lateRains: [Int] = [0, 0, 1, 0, 5, 8, 9]            // wet days: 0 0 1 0 1 1 1
let shortSeason: [Int] = [2, 0, 5]                      // wet days: 1 0 1
let drySeason: [Int] = [0, 0, 0, 0]                     // wet days: 0 0 0 0

// MARK: Your solution (Challenge 1)

func mostWetDays(_ rainfall: [Int], k: Int) -> Int {
    var windowSum = 0
    for right in 0..<k {
        if rainfall[right] > 0 {
            windowSum += 1
        }
    }
    var largestSum = windowSum
    
    for right in k..<rainfall.count {
        let left = right - k
        if rainfall[right] > 0 { windowSum += 1 }
        if rainfall[left] > 0 { windowSum -= 1 }
        if windowSum > largestSum { largestSum = windowSum }
    }
    
    return largestSum
}

// MARK: Tests (Challenge 1) — uncomment as you go
 assert(mostWetDays(spring, k: 3) == 3)        // best block is in the middle
// assert(mostWetDays(earlyRains, k: 2) == 2)    // best block is the very first one
// assert(mostWetDays(lateRains, k: 3) == 3)     // best block is the very last one
// assert(mostWetDays(shortSeason, k: 3) == 2)   // k equals the whole array
// assert(mostWetDays(spring, k: 1) == 1)        // single-day blocks
// assert(mostWetDays(drySeason, k: 2) == 0)     // no wet days at all
 print("Challenge 1 passed!")

// ============================================================
// MARK: - Challenge 2 (The Picking Run): Variable Sliding Window
// ============================================================
/*
 The pickers can work through a run of days in a row, as long as no
 more than maxWet of those days are wet. You want to know how long the
 longest possible run is.

 Given the daily rainfall readings and maxWet, return the length of the
 longest stretch of consecutive days that contains at most maxWet wet
 days. A day is wet if its reading is above 0. maxWet is 0 or more.
 If no day can be included, or the array is empty, return 0.

 func longestRun(_ rainfall: [Int], maxWet: Int) -> Int

 Hint: grow the window one day at a time. When it holds too many wet
 days, shrink it from the left until it is allowed again.
*/

// MARK: Pre-defined (do not modify)
// `spring` from Challenge 1 is reused here.
let harvest: [Int] = [6, 3, 2, 0, 0, 0, 5, 0, 0, 0, 0]  // wet days: 1 1 1 0 0 0 1 0 0 0 0
let mildSeason: [Int] = [0, 0, 5, 0]                    // wet days: 0 0 1 0
let soakedSeason: [Int] = [4, 2, 7]                     // wet days: 1 1 1

// MARK: Your solution (Challenge 2)

func longestRun(_ rainfall: [Int], maxWet: Int) -> Int {
    var longestStretch = 0
    var windowSum = 0
    var left = 0
    var right = 0
    
    while right < rainfall.count {
        if rainfall[right] > 0 {
            windowSum += 1
        }
        
        while windowSum > maxWet {
            if rainfall[left] > 0 {
                windowSum -= 1
            }
            
            left += 1
        }
        
        var width = right - left + 1
        if width > longestStretch { longestStretch = width }
        
        right += 1
    }
    
    return longestStretch
}

// MARK: Tests (Challenge 2) — uncomment as you go
 assert(longestRun(spring, maxWet: 1) == 4)        // must shrink past a run of wet days
 assert(longestRun(spring, maxWet: 0) == 2)        // limit of zero: longest dry run
 assert(longestRun(harvest, maxWet: 1) == 8)       // best stretch is at the very end
 assert(longestRun(mildSeason, maxWet: 3) == 4)    // the whole array is allowed
 assert(longestRun(soakedSeason, maxWet: 0) == 0)  // no day can be included
 assert(longestRun([], maxWet: 2) == 0)            // empty input
 print("Challenge 2 passed!")
