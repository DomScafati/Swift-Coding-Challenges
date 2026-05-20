import Foundation

// Sliding Window Challenge
//
// Phrases/patterns that signal "Sliding Window":
// "maximum/minimum sum across K consecutive items"    → fixed window
// "longest/shortest subarray that satisfies X"        → variable window
// "contiguous stretch / consecutive elements"         → sliding window
// "within a range of size K"                          → fixed window
// "as long as the condition holds / expand until..."  → variable window

// The Halverson family has run the same apple orchard for four
// generations. Between drought years and bumper crops, every row
// tells a different story — and this season, the family needs
// answers before the first frost hits.


// ============================================================
// MARK: - Challenge 1 (The Dry Stretch): Fixed Sliding Window
// ============================================================
/*
 Grandpa Halverson wants to know which stretch of k consecutive rows
 produced the fewest apples this season so he can target them for
 extra fertilizer next spring.

 Given an array of per-row yields and a window size k, return the
 minimum total yield across any k consecutive rows.

 func dryStretch(_ yields: [Int], k: Int) -> Int

 Hint: build the first window by hand, then slide — track the
 smallest sum you see instead of the largest.
*/

// MARK: Pre-defined (do not modify)

let rowYields = [12, 5, 9, 3, 7, 11, 4]
// windows of size 3:
// [12,5,9]=26  [5,9,3]=17  [9,3,7]=19  [3,7,11]=21  [7,11,4]=22
// expected: 17

// MARK: Your solution (Challenge 1)

func dryStretch(_ yields: [Int], k: Int) -> Int {

    var windowSum = 0
    for i in 0..<k {
        windowSum += yields[i]
    }
    
    var smallest = windowSum
    for i in k..<yields.count {
        windowSum -= yields[i - k]
        windowSum += yields[i]
        
        if windowSum < smallest {
            smallest = windowSum
        }
    }
    
    return smallest
}


// MARK: Tests (Challenge 1) — uncomment as you go

assert(dryStretch(rowYields, k: 3) == 17)
assert(dryStretch([1, 2, 3], k: 3) == 6)         // entire array is one window
assert(dryStretch([5, 1, 1, 1, 5], k: 2) == 2)   // minimum pair: 1+1
print("Challenge 1 passed!")


// ============================================================
// MARK: - Challenge 2 (The Harvest Run): Variable Sliding Window
// ============================================================
/*
 Pickers load crates onto a flatbed trailer as they work through
 consecutive rows. The trailer can carry at most `limit` pounds
 before it has to head back to the barn. Find the longest
 consecutive stretch of rows a picker can cover without the total
 crate weight exceeding the limit.

 Given an array of crate weights and a max limit, return the length
 of the longest consecutive group of rows whose total weight does
 not exceed the limit.

 func longestRun(_ crates: [Int], limit: Int) -> Int

 Hint: expand from the right; when you go over the limit, shrink
 from the left until you're back within it, then record the length.
*/

// MARK: Pre-defined (do not modify)

let crateWeights = [5, 2, 8, 1, 4, 3, 7]
// valid stretches within limit 10:
// [5,2]=7 ✓ len 2   [5,2,8]=15 ✗
// [2,8]=10 ✓ len 2  [2,8,1]=11 ✗
// [8,1]=9 ✓ len 2   [8,1,4]=13 ✗
// [1,4]=5 ✓         [1,4,3]=8 ✓ len 3  [1,4,3,7]=15 ✗
// expected: 3

// MARK: Your solution (Challenge 2)

func longestRun(_ crates: [Int], limit: Int) -> Int {
    var left = 0
    var right = 0
    var highest = 0
    var windowSum = 0
    
    while right <= crates.count - 1 {
        windowSum += crates[right]
        while windowSum > limit {
            windowSum -= crates[left]
            left += 1
        }
        
        var count = right - left + 1
        if count > highest {
            highest = count
        }
        right += 1
    }
    
    return highest
}

// MARK: Tests (Challenge 2) — uncomment as you go

assert(longestRun(crateWeights, limit: 10) == 3)
assert(longestRun([1, 1, 1, 1], limit: 4) == 4)  // entire array fits
assert(longestRun([9, 9, 9], limit: 8) == 0)      // nothing fits
assert(longestRun([2, 2, 2, 2], limit: 5) == 2)   // any two adjacent fit
print("Challenge 2 passed!")
