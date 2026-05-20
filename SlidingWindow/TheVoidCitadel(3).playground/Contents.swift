import Foundation

// Sliding Window Challenge
//
// Phrases/patterns that signal "Sliding Window":
// "maximum/minimum sum across K consecutive items"    → fixed window
// "longest/shortest subarray that satisfies X"        → variable window
// "contiguous stretch / consecutive elements"         → sliding window
// "within a range of size K"                          → fixed window
// "as long as the condition holds / expand until..."  → variable window

// Deep in the Shattered Reaches, the Void Citadel hums with ancient
// rune-tech — part fortress, part machine, abandoned by the Star-Mages
// three centuries ago. A squad of Ironclad Knights has been sent to
// reactivate it before the Rift tears the sector apart.


// ============================================================
// MARK: - Challenge 1 (The Conduit): Fixed Sliding Window
// ============================================================
/*
 The citadel's power conduits run in a long chain through the outer wall.
 Each conduit holds a charge reading. To reactivate the inner core, the
 knights must locate the 3 consecutive conduits with the highest combined
 charge and plug the reactivation crystal in there.

 Given an array of conduit charge readings and a window size k, return
 the maximum total charge across any k consecutive conduits.

 func maxCharge(_ conduits: [Int], k: Int) -> Int

 Hint: build the first window manually, then slide by adding one on the
 right and removing one on the left.
*/

// MARK: Pre-defined (do not modify)

let conduitReadings = [3, 8, 1, 6, 4, 9, 2]
// expected (k: 3): 19

// MARK: Your solution (Challenge 1)

func maxCharge(_ conduits: [Int], k: Int) -> Int {
    var windowSum = 0
    for index in 0..<k {
        windowSum += conduits[index]
    }
    
    var max = windowSum
    for index in k..<conduits.count {
        windowSum += conduits[index] // newest element adds
        windowSum -= conduits[index - k] // oldest element drops
        
        if max < windowSum {
            max = windowSum
        }
    }
    
    return max
}


// MARK: Tests (Challenge 1) — uncomment as you go

assert(maxCharge(conduitReadings, k: 3) == 19)
assert(maxCharge([1, 2, 3], k: 3) == 6)
assert(maxCharge([5, 1, 1, 1, 5], k: 2) == 6)
print("Challenge 1 passed!")


// ============================================================
// MARK: - Challenge 2 (The Bridge): Variable Sliding Window
// ============================================================
/*
 The bridge to the inner sanctum has a weight limit — too much Ironclad
 armor at once and the ancient stonework will collapse. Knights are
 queuing to cross in single file. Find the longest consecutive group
 of knights that can stand on the bridge together without exceeding
 the weight limit.

 Given an array of armor weights and a max limit, return the length of
 the longest consecutive group of knights whose total weight does not
 exceed the limit.

 func longestCrossing(_ weights: [Int], limit: Int) -> Int

 Hint: expand from the right, and when you go over the limit shrink
 from the left until you're back within it.
*/

// MARK: Pre-defined (do not modify)

let armorWeights = [4, 2, 5, 1, 3, 6, 2]
// expected (limit: 8): 3

// MARK: Your solution (Challenge 2)

func longestCrossing(_ weights: [Int], limit: Int) -> Int {
    var left = 0
    var right = 0
    var maxCount = 0
    var windowSum = 0
    
    while right <= weights.count - 1 {
        windowSum += weights[right]
        while windowSum > limit {
            windowSum -= weights[left]
            left += 1
        }
        
        var count = right - left + 1
        if maxCount < count {
            maxCount = count
        }
            right += 1

    }
    
    return maxCount
}


// MARK: Tests (Challenge 2) — uncomment as you go

assert(longestCrossing(armorWeights, limit: 8) == 3)
assert(longestCrossing([1, 1, 1, 1], limit: 4) == 4)
assert(longestCrossing([9, 9, 9], limit: 8) == 0)
assert(longestCrossing([2, 2, 2, 2], limit: 5) == 2)
print("Challenge 2 passed!")
