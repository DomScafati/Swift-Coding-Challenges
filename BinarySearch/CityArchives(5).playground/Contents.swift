import Foundation

//   Binar Search Challenge
//
//   Words/phrases that signal "Binary Search" directly:
//   "sorted array / list"
//   "find the first / last / leftmost / rightmost"
//   "minimum X that satisfies Y" or "maximum X that satisfies Y"
//   "find the position to insert"

// You're a city archivist managing historical census records for city districts.
// Population records are always stored in sorted order — binary search is how you navigate them.

// ============================================================
// MARK: - Challenge 1: First District At or Above Threshold
// ============================================================
/*
 Story: A district planner asks you to locate the first district whose population
 meets or exceeds a minimum threshold — that's where infrastructure planning begins.

 Task: Given a sorted array of district populations and a minimum population,
 return the index of the first district with population >= minPop.
 Return nil if no district qualifies.

 Requirements:
 1. Implement: func firstDistrictAtOrAbove(_ populations: [Int], _ minPop: Int) -> Int?
    - Use binary search — no linear scans
    - This is a lower bound search: find the leftmost index where populations[i] >= minPop
    - Return nil if all populations fall below minPop

 Hint: When populations[mid] >= minPop, record mid as a candidate and keep searching LEFT.
       When populations[mid] < minPop, search RIGHT.
 */

// MARK: Pre-defined (do not modify)

let districtPops: [Int] = [1200, 3400, 5600, 7800, 9000, 12000, 15000]

// MARK: Your solution (Challenge 1)

func firstDistrictAtOrAbove(_ populations: [Int], _ minPop: Int) -> Int? {
    var result:Int? = nil
    var left = 0
    var right = populations.count - 1
    
    while left <= right {
        var mid = (left + right)/2

        if populations[mid] >= minPop {
            result = mid
            right = mid - 1
        } else {
            left = mid + 1
        }
    }
    
    return result
}


// MARK: Tests (Challenge 1) — uncomment as you go

assert(firstDistrictAtOrAbove(districtPops, 5600) == 2)    // exact match at index 2
assert(firstDistrictAtOrAbove(districtPops, 6000) == 3)    // 7800 is first one above 6000
assert(firstDistrictAtOrAbove(districtPops, 1200) == 0)    // all qualify, first is index 0
assert(firstDistrictAtOrAbove(districtPops, 20000) == nil) // none qualify
print("Challenge 1 passed!")


// ============================================================
// MARK: - Challenge 2: Count Districts in a Population Band
// ============================================================
/*
 Story: A funding committee allocates grants only to districts within a specific
 population band. They need a count of qualifying districts to determine the budget.

 Task: Given a sorted array of district populations and bounds [low, high],
 return how many districts have a population in that range (inclusive).

 Requirements:
 1. Implement: func countDistrictsInRange(_ populations: [Int], _ low: Int, _ high: Int) -> Int
    - Use exactly two binary searches — no filter, no linear scan:
        • Lower bound: leftmost index where populations[i] >= low
        • Upper bound: rightmost index where populations[i] <= high
    - Count = upperBound - lowerBound + 1, or 0 if the bounds don't overlap

 Hint: For the upper bound, when populations[mid] <= high, record mid and search RIGHT.
       When populations[mid] > high, search LEFT.
 */

// MARK: Pre-defined (do not modify)

// districtPops defined above — [1200, 3400, 5600, 7800, 9000, 12000, 15000]

// MARK: Your solution (Challenge 2)

func countDistrictsInRange(_ populations: [Int], _ low: Int, _ high: Int) -> Int {
    var left = 0
    var right = populations.count - 1
    var lowerResult: Int = 0
    var upperResult:Int = 0
    
    while left <= right {
        var middle = (left + right)/2
        
        if populations[middle] >= low {
            lowerResult = middle
            right = middle - 1
        } else {
            left = middle + 1
        }
    }
    
    left = 0
    right = populations.count - 1
    
    while left <= right {
        var middle = (left + right)/2
        
        if populations[middle] <= high {
            upperResult = middle
            left = middle + 1
        } else {
            right = middle - 1
        }
            
    }
    
    return upperResult - lowerResult + 1
}

// MARK: Tests (Challenge 2) — uncomment as you go

assert(countDistrictsInRange(districtPops, 3400, 9000)  == 4) // indices 1–4: 3400, 5600, 7800, 9000
assert(countDistrictsInRange(districtPops, 5000, 8000)  == 2) // 5600, 7800
assert(countDistrictsInRange(districtPops, 1200, 15000) == 7) // all districts
print("Challenge 2 passed!")


// ============================================================
// MARK: - Challenge 3: Corrupted Record — Minimum in Rotated Array
// ============================================================
/*
 Story: One district's data export was corrupted during a system migration —
 the sorted records wrapped around at an unknown pivot
 (e.g. [7800, 9000, 12000, 1200, 3400] instead of [1200, 3400, 7800, 9000, 12000]).
 You need to find the smallest population to verify where the rotation happened.

 Task: Given a rotated sorted array with no duplicates, return the minimum value.

 Requirements:
 1. Implement: func minimumInRotated(_ populations: [Int]) -> Int
    - The array was originally sorted ascending, then rotated at some unknown pivot
    - Use binary search — O(log n), no linear scan
    - The array is guaranteed non-empty and contains no duplicates

 Key insight: Compare populations[mid] to populations[right]:
   - If populations[mid] > populations[right]: the minimum is somewhere in the RIGHT half
   - If populations[mid] < populations[right]: the minimum is in the LEFT half (mid could be it)
 When left == right, you've found the minimum.
 */

// MARK: Pre-defined (do not modify)

let corruptedPops: [Int] = [7800, 9000, 12000, 15000, 1200, 3400, 5600]

// MARK: Your solution (Challenge 3)



// MARK: Tests (Challenge 3) — uncomment as you go

//assert(minimumInRotated(corruptedPops) == 1200)
//assert(minimumInRotated([3400, 5600, 7800, 1200]) == 1200)   // rotation near end
//assert(minimumInRotated([1200, 3400, 5600, 7800]) == 1200)   // no rotation (pivot at 0)
//assert(minimumInRotated([5600]) == 5600)                     // single element
//print("Challenge 3 passed!")
