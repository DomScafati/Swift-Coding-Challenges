import Foundation

// Two Pointers Challenge
//
// Phrases/patterns that signal "Two Pointers":
// "find two items that together equal / sum to..."    → converging pointers from both ends
// "sorted array, check if a pair exists..."           → left moves right if sum too small, right moves left if sum too large
// "reads the same forwards and backwards"             → palindrome check, one pointer at each end, move inward
// "move all X to the end / keep order of the rest"   → slow/fast pointer, fast scans ahead, slow marks next write position
// "merge two sorted sequences"                        → one pointer per array, always pick the smaller value

// A surf forecasting station on a remote island monitors wave
// patterns across three buoy arrays. The station logs readings
// around the clock — some clean data, some noise — and the
// analysts need it sorted out before the morning briefing.


// ============================================================
// MARK: - Challenge 1 (The Cleanup): Move Zeros to End
// ============================================================
/*
 The buoy logs record 0 whenever a sensor goes offline. Analysts
 need all the real readings grouped at the front, with the 0s
 pushed to the end — and the order of the real readings must
 be preserved.

 Given an array of integers, return a new array with all non-zero
 values at the front (in their original order) and all zeros at
 the end.

 func cleanup(_ readings: [Int]) -> [Int]

 Hint: use a slow pointer to track the next write position and a
 fast pointer to scan ahead. When fast finds a non-zero, write it
 at slow and advance both. Fill the rest with zeros.
*/

// MARK: Pre-defined (do not modify)

let buoyA = [0, 3, 0, 1, 2]
// expected: [3, 1, 2, 0, 0]

let buoyB = [0, 0, 0, 4]
// expected: [4, 0, 0, 0]

// MARK: Your solution (Challenge 1)

func cleanup(_ readings: [Int]) -> [Int] {
    var slow = 0
    var newArray = readings
    
    // go through the entire newArray and find where the value is 0
    for fast in 0..<readings.count {
        if newArray[fast] != 0 {
            newArray[slow] = newArray[fast]
            slow += 1
        }
    }
    
    // handle leftover positions
    while slow < readings.count {
        newArray[slow] = 0
        slow += 1
    }
    
    return newArray
}

// MARK: Tests (Challenge 1) — uncomment as you go

assert(cleanup(buoyA) == [3, 1, 2, 0, 0])
assert(cleanup(buoyB) == [4, 0, 0, 0])
assert(cleanup([1, 2, 3]) == [1, 2, 3])   // no zeros, unchanged
assert(cleanup([0, 0, 0]) == [0, 0, 0])   // all zeros
assert(cleanup([]) == [])                  // empty
print("Challenge 1 passed!")


// ============================================================
// MARK: - Challenge 2 (The Gap): Pair with Difference K
// ============================================================
/*
 The analysts want to know whether any two wave heights in a
 sorted log differ by exactly k — that pattern signals a rogue
 wave forming between two buoys.

 Given a sorted array of wave heights and a target difference k,
 return true if any two elements differ by exactly k.

 func hasGap(_ heights: [Int], k: Int) -> Bool

 Hint: use left and right pointers both starting from the left
 (right = left + 1). If the difference is exactly k you're done.
 If it's less than k, advance right to widen the gap.
 If it's more than k, advance left to shrink it — but make sure
 left never catches up to right.
*/

// MARK: Pre-defined (do not modify)

let waveHeights = [1, 3, 5, 8, 12]
// pairs: (1,3)=2  (3,5)=2  (5,8)=3  (8,12)=4  (1,5)=4  (3,8)=5  ...
// expected: hasGap(waveHeights, k: 3) == true   → 5 and 8
// expected: hasGap(waveHeights, k: 6) == false  → no pair differs by exactly 6

// MARK: Your solution (Challenge 2)

func hasGap(_ heights: [Int], k: Int) -> Bool {
    var left = 0
    var right = 1
    
    while right < heights.count {
        var difference = heights[right] - heights[left]
        if difference == k {
            return true
        } else if difference < k {
            right += 1
        } else {
            left += 1
            if left == right {
                right += 1
            }
        }
    }
    
    return false
}

// MARK: Tests (Challenge 2) — uncomment as you go

assert(hasGap(waveHeights, k: 3) == true)    // 5 and 8
assert(hasGap(waveHeights, k: 4) == true)    // 8 and 12, or 1 and 5
assert(hasGap(waveHeights, k: 6) == false)   // no such pair
assert(hasGap([1, 1, 1], k: 0) == true)      // different indices, 1-1=0 matches k
assert(hasGap([2, 5], k: 3) == true)         // exactly one pair
print("Challenge 2 passed!")
