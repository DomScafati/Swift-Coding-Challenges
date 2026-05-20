import Foundation

// Binary Search Challenge
//
// Phrases/patterns that signal "Binary Search":
// "sorted array"                              → binary search
// "find the index / does it exist"            → binary search
// "O(log n) lookup"                           → binary search
// "left, right, middle / cut the range"       → binary search

// Post-collapse Earth. The Syndicate controls all fuel distribution
// through orbital relay beacons scattered across the dust-choked
// Badlands. Before authorizing any fuel drop, VERA — the Syndicate's
// crumbling AI — scans a sorted registry of valid beacon IDs.
// Unauthorized beacons mean raiders. Raiders mean war.


// ============================================================
// MARK: - Challenge 1 (The Registry): Binary Search
// ============================================================
/*
 A fuel convoy is requesting a drop at beacon ID 4821. VERA must
 scan the registry — a sorted array of valid beacon IDs — and
 confirm whether that ID is registered. If it is, return its index
 so the drop can be logged. If it isn't, return -1 to trigger a
 lockdown.

 Given a sorted array of beacon IDs and a target ID, return the
 index of the target if found, or -1 if it is not in the registry.

 func scanRegistry(_ beacons: [Int], target: Int) -> Int

 Hint: track a left and right boundary. Each step, check the middle
 — if the target is smaller go left, if larger go right.
*/

// MARK: Pre-defined (do not modify)

let registry = [1042, 1879, 2304, 3187, 4821, 5903, 6710, 7788, 8891]
// expected: scanRegistry(registry, target: 4821) == 4
// expected: scanRegistry(registry, target: 9999) == -1

// MARK: Your solution (Challenge 1)

func scanRegistry(_ beacons: [Int], target: Int) -> Int {
    var left = 0
    var right = beacons.count - 1
    
    while left <= right {
        var middle = (right + left) / 2
        if beacons[middle] == target {
            return middle
        } else if beacons[middle] < target {
            left = middle + 1
        } else {
            right = middle - 1
        }
    }
    
    return -1
}

// MARK: Tests (Challenge 1) — uncomment as you go

assert(scanRegistry(registry, target: 4821) == 4)   // found in the middle
assert(scanRegistry(registry, target: 1042) == 0)   // found at the left edge
assert(scanRegistry(registry, target: 8891) == 8)   // found at the right edge
assert(scanRegistry(registry, target: 9999) == -1)  // not registered → lockdown
assert(scanRegistry(registry, target: 3000) == -1)  // between entries → lockdown
print("Challenge 1 passed!")


// ============================================================
// MARK: - Challenge 2 (The Threshold): First Match Binary Search
// ============================================================
/*
 VERA monitors a sorted array of beacon power readings across the
 Badlands. A fuel drop requires a minimum power output to lock on.
 The convoy needs the first beacon that meets or exceeds the required
 threshold — not just any qualifying beacon, the earliest one in
 the sorted list.

 Given a sorted array of power readings and a threshold, return the
 index of the first reading that is greater than or equal to the
 threshold. If no reading meets it, return -1.

 func firstOnline(_ readings: [Int], threshold: Int) -> Int

 Hint: when you find a value that qualifies, don't return immediately
 — record the index and keep narrowing left. You might find an
 earlier one.
*/

// MARK: Pre-defined (do not modify)

let powerReadings = [120, 245, 390, 410, 580, 720, 890, 940, 1100]
// expected: firstOnline(powerReadings, threshold: 400) == 3  → 410 is first >= 400
// expected: firstOnline(powerReadings, threshold: 1200) == -1 → nothing qualifies

// MARK: Your solution (Challenge 2)

func firstOnline(_ readings: [Int], threshold: Int) -> Int {
    var best = -1
    var left = 0
    var right = readings.count - 1
    
    while left <= right {
        var middle = (left + right) / 2
        var guess = readings[middle]
        
        if guess >= threshold {
            best = middle
            right = middle - 1
        } else {
            left = middle + 1
        }
    }
    
    return best
}


// MARK: Tests (Challenge 2) — uncomment as you go

assert(firstOnline(powerReadings, threshold: 400)  == 3)   // 410 is first >= 400
assert(firstOnline(powerReadings, threshold: 120)  == 0)   // first element qualifies
assert(firstOnline(powerReadings, threshold: 890)  == 6)   // exact match, left edge of candidates
assert(firstOnline(powerReadings, threshold: 1200) == -1)  // nothing meets the threshold
print("Challenge 2 passed!")
