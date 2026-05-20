import Foundation

// Sliding Window Challenge
//
// Phrases/patterns that signal "Sliding Window":
// "maximum/minimum sum across K consecutive items"    → fixed window
// "longest/shortest subarray that satisfies X"        → variable window
// "contiguous stretch / consecutive elements"         → sliding window
// "within a range of size K"                          → fixed window
// "as long as the condition holds / expand until..."  → variable window

// Two nights after old Ezra Pruitt died, half the county turned up
// at the crumbling Pruitt estate to pay their respects. The family
// tracked the food, the visitors, and the long slow hours of the wake.


// ============================================================
// MARK: - Challenge 1 (The Spread): Fixed Sliding Window
// ============================================================
/*
 This challenge is pre-solved. Read through the solution and inline
 comments carefully — the goal is to understand how a fixed sliding
 window works.

 Story: The family laid out food across seven long tables. Each table
 holds a different total weight of dishes (in pounds). Cousin Ida
 wants to know the heaviest spread across any 3 consecutive tables
 so she knows where to seat the hungriest mourners.

 Given an array of table weights and a window size k, return the
 maximum sum of any k consecutive elements.

 func maxSpread(_ tables: [Int], k: Int) -> Int

 Hint: you only need two adjustments per step — one element in, one out.
*/

// MARK: Pre-defined (do not modify)

let tableWeights = [4, 7, 2, 9, 5, 8, 3]
// windows of size 3:
// [4,7,2]=13  [7,2,9]=18  [2,9,5]=16  [9,5,8]=22  [5,8,3]=16
// expected: 22

// MARK: Solution (Challenge 1) — read and understand, do not modify

func maxSpread(_ tables: [Int], k: Int) -> Int {

    // --- Step 1: Build the first window by hand ---
    // We can't slide yet — we need a starting sum to work from.
    // So we manually add up the first k elements.
    var windowSum = 0
    for i in 0..<k {
        windowSum += tables[i]
    }

    // The first window is also our best result so far.
    var maxSum = windowSum

    // --- Step 2: Slide the window one step at a time ---
    // Instead of re-summing k elements from scratch each iteration,
    // we make exactly two cheap adjustments:
    //   • Add the new element entering from the right
    //   • Remove the old element falling off the left
    //
    // This keeps the sum current in O(1) per step — no inner loop needed.
    // 'i' is the index of the new element on the right.
    // The element leaving on the left is always at index (i - k).
    for i in k..<tables.count {
        windowSum += tables[i]      // new element slides in from the right
        windowSum -= tables[i - k] // old element drops off the left

        if windowSum > maxSum {
            maxSum = windowSum
        }
    }

    return maxSum
}

// MARK: Tests (Challenge 1)

assert(maxSpread(tableWeights, k: 3) == 22)
assert(maxSpread([1, 2, 3], k: 3) == 6)        // entire array is one window
assert(maxSpread([5, 1, 1, 1, 5], k: 2) == 6)  // first or last pair: 5+1
print("Challenge 1 passed!")


// ============================================================
// MARK: - Challenge 2 (The Offering): Variable Sliding Window
// ============================================================
/*
 This challenge is pre-solved. Read through the solution and inline
 comments carefully — a variable window grows AND shrinks, which is
 the key difference from the fixed window in Challenge 1.

 Story: Mourners filed past the casket one by one, each leaving a
 dish on the offering table. The table can only hold 8 pounds at
 a time. Deacon Hollis wants to find the longest unbroken line of
 mourners whose combined dishes fit within the table's limit —
 so he knows how many can pass through at once without it buckling.

 Given an array of dish weights and a max capacity, return the length
 of the longest consecutive group of mourners whose total weight
 does not exceed the capacity.

 func longestLine(_ dishes: [Int], capacity: Int) -> Int

 Hint: when the window goes over capacity, shrink it from the left
 until it fits again — then record the length.
*/

// MARK: Pre-defined (do not modify)

let dishWeights = [3, 1, 4, 2, 6, 1, 5, 2]
// valid stretches within capacity 8:
// [3,1,4]=8 ✓ length 3   [3,1,4,2]=10 ✗
// [1,4,2]=7 ✓ length 3   [1,4,2,6]=13 ✗
// ... best stretch is length 3
// expected: 3

// MARK: Solution (Challenge 2) — read and understand, do not modify

func longestLine(_ dishes: [Int], capacity: Int) -> Int {
    var left = 0       // left edge of the current window
    var windowSum = 0  // total weight currently inside the window
    var longest = 0    // best valid length found so far

    // 'right' is the right edge — we advance it every iteration to expand.
    // Think of [left...right] as the current group of mourners in line.
    for right in 0..<dishes.count {

        // --- Expand: pull the next mourner's dish into the window ---
        windowSum += dishes[right]

        // --- Shrink: if we're over capacity, push the left edge forward ---
        // We keep shrinking until the window fits again.
        // This is the core of a variable window: it can contract from the
        // left just as easily as it grows from the right.
        while windowSum > capacity {
            windowSum -= dishes[left]  // drop the leftmost dish off the table
            left += 1                  // the line starts one mourner later
        }

        // --- Record: the window always satisfies the condition at this point ---
        // Length = right - left + 1  (+1 because both ends are inclusive)
        let currentLength = right - left + 1
        if currentLength > longest {
            longest = currentLength
        }
    }

    return longest
}

// MARK: Tests (Challenge 2)

assert(longestLine(dishWeights, capacity: 8) == 3)
assert(longestLine([1, 1, 1, 1], capacity: 4) == 4)  // entire array fits
assert(longestLine([9, 9, 9], capacity: 8) == 0)      // nothing fits
assert(longestLine([2, 2, 2, 2], capacity: 5) == 2)   // any two adjacent fit
print("Challenge 2 passed!")
