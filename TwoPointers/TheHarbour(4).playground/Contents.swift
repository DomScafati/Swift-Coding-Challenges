import Foundation

// Two Pointers Challenge
//
// Phrases/patterns that signal "Two Pointers":
// "find two items that together equal / sum to..."    → converging pointers from both ends
// "sorted array, check if a pair exists..."           → left moves right if sum too small, right moves left if sum too large
// "reads the same forwards and backwards"             → palindrome check, one pointer at each end, move inward
// "move all [x] to the end / keep order of the rest" → fast/slow pointer, swap in-place
// "largest area / container between two walls"        → converging pointers, shrink from the shorter side

// You're the harbour master on a busy morning.
// Crates need sorting on the dock, the water tanks need inspecting,
// and the cargo manifests have to balance before the ships depart.

// ============================================================
// MARK: - Challenge 1 (The Dock): Move Zeroes
// ============================================================
/*
 Story: Empty slots on the loading dock are recorded as 0 in the bay layout.
 You need to push all the empty slots to the far end while keeping every
 loaded crate in its original relative order. Do it in-place — no new arrays.

 Task: Given an array of integers, move all zeroes to the end while
 maintaining the relative order of the non-zero elements.

 func moveCrates(_ bay: inout [Int])

 Hint: use a slow pointer that tracks where the next non-zero value should land,
 and a fast pointer that scans ahead looking for non-zero values to place there.
 */

// MARK: Pre-defined (do not modify)

var bay1 = [0, 1, 0, 3, 12]         // [1, 3, 12, 0, 0]
var bay2 = [0, 0, 1]                 // [1, 0, 0]
var bay3 = [4, 2, 0, 0, 7, 0, 9]    // [4, 2, 7, 9, 0, 0, 0]
var bay4 = [1, 2, 3]                 // [1, 2, 3] — no change

// MARK: Your solution (Challenge 1)

func moveCrates(_ bay: inout [Int]) {
    var slow = 0
    for fast in 0..<bay.count {
        if bay[fast] != 0 {
            bay[slow] = bay[fast]
            slow += 1
        }
    }
    
    while slow < bay.count {
        bay[slow] = 0
        slow += 1
    }
}

// MARK: Tests (Challenge 1) — uncomment as you go

 moveCrates(&bay1)
 assert(bay1 == [1, 3, 12, 0, 0])

 moveCrates(&bay2)
 assert(bay2 == [1, 0, 0])

 moveCrates(&bay3)
 assert(bay3 == [4, 2, 7, 9, 0, 0, 0])

 moveCrates(&bay4)
 assert(bay4 == [1, 2, 3])

 print("Challenge 1 passed!")


// ============================================================
// MARK: - Challenge 2 (The Ferry): Closest Load to Capacity
// ============================================================
/*
 Story: A ferry has a weight limit and you have a sorted list of cargo weights.
 You want to pick two cargo items whose combined weight comes as close as
 possible to the limit — without worrying about going over.

 Task: Given a sorted array of integers and a target, return the pair of values
 (not indices) whose sum is closest to the target. If two pairs are equally
 close, return either.

 func closestLoad(_ weights: [Int], limit: Int) -> (Int, Int)

 Hint: use converging pointers and track the closest sum you've seen so far.
 */

// MARK: Pre-defined (do not modify)

let cargo1 = [1, 3, 5, 7, 9],    limit1 = 10   // (1, 9) or (3, 7) — both sum to 10
let cargo2 = [1, 3, 8, 11, 20],  limit2 = 15   // (3, 11) → 14, closest to 15
let cargo3 = [1, 2, 5, 8, 14],   limit3 = 13   // (5, 8) → 13, exact
let cargo4 = [3, 7, 10, 15, 20], limit4 = 18   // (3, 15) → 18, exact

// MARK: Your solution (Challenge 2)

func closestLoad(_ weights: [Int], limit: Int) -> (Int, Int) {
    var left = 0
    var right = weights.count - 1
    
    // highest pair
    var val1 = 0
    var val2 = 0
    
    while left <= right {
        if weights[left] + weights[right] == limit {
            return (weights[left], weights[right])
        } else if weights[left] + weights[right] < limit {
            if weights[left] > val1 {
                val1 = weights[left]
            }
            if weights[right] > val2 {
                val2 = weights[right]
            }
            left += 1
        } else if weights[left] + weights[right] > limit {
            right -= 1
        }
    }
    
    return (val1, val2)
}

// MARK: Tests (Challenge 2) — uncomment as you go

 let r1 = closestLoad(cargo1, limit: limit1)
 assert(r1.0 + r1.1 == 10)

 let r2 = closestLoad(cargo2, limit: limit2)
 assert(r2.0 + r2.1 == 14)   // closest achievable is 14 (3+11)

 let r3 = closestLoad(cargo3, limit: limit3)
 assert(r3.0 + r3.1 == 13)

 let r4 = closestLoad(cargo4, limit: limit4)
 assert(r4.0 + r4.1 == 18)

print("Challenge 2 passed!")


// ============================================================
// MARK: - Challenge 3 (The Manifest): Three Sum to Zero
// ============================================================
/*
 Story: Each entry on the cargo manifest is a weight adjustment — positive
 means added weight, negative means removed weight. A shipment is balanced
 when three adjustments cancel each other out exactly (sum to zero).
 Find every unique balanced group of three.

 Task: Given an integer array, return all unique triplets [a, b, c] where
 a + b + c == 0. No duplicate triplets. Each triplet should be sorted ascending.

 func balancedLoads(_ adjustments: [Int]) -> [[Int]]

 Hint: sort first, then for each element run a two-pointer search over the
 remaining slice — skip over duplicate values to avoid repeating triplets.
 */

// MARK: Pre-defined (do not modify)

let manifest1 = [-1, 0, 1, 2, -1, -4]   // [[-1,-1,2], [-1,0,1]]
let manifest2 = [0, 1, 1]                // []
let manifest3 = [0, 0, 0]                // [[0,0,0]]
let manifest4 = [-2, 0, 1, 1, 2]         // [[-2,0,2], [-2,1,1]]

// MARK: Your solution (Challenge 3)



// MARK: Tests (Challenge 3) — uncomment as you go

// let t1 = balancedLoads(manifest1).sorted { $0.lexicographicallyPrecedes($1) }
// assert(t1 == [[-1,-1,2],[-1,0,1]])
//
// let t2 = balancedLoads(manifest2)
// assert(t2 == [])
//
// let t3 = balancedLoads(manifest3)
// assert(t3 == [[0,0,0]])
//
// let t4 = balancedLoads(manifest4).sorted { $0.lexicographicallyPrecedes($1) }
// assert(t4 == [[-2,0,2],[-2,1,1]])
//
// print("Challenge 3 passed!")
