import Foundation

// Two Pointers Challenge
//
// Phrases/patterns that signal "Two Pointers":
// "find two items that together equal / sum to..."    → converging pointers from both ends
// "sorted array, check if a pair exists..."           → left moves right if sum too small, right moves left if sum too large
// "reads the same forwards and backwards"             → palindrome check, one pointer at each end, move inward
// "reverse / mirror the order"                        → swap from both ends inward
// "common elements across two sorted lists"           → one pointer per list, advance the smaller one

// In the 41st millennium, the Adeptus Mechanicus has made planetfall
// on the feral world of Vaxis IV — a planet teeming with bioluminescent
// creatures the locals call Wyrd-Beasts. Part Pokémon, part weapon,
// these creatures bond with warriors and fight alongside them. The
// tech-priests, ever practical, have begun cataloguing everything.


// ============================================================
// MARK: - Challenge 1 (The Reversal Log): Reverse an Array
// ============================================================
/*
 A field scribe logged an entire squad's Wyrd-Beast roster in reverse
 order — strongest first, weakest last. The Magos needs it flipped:
 weakest first so the weakest beasts get processed for augmentation
 first.

 Given an array of beast names, return a new array with the order
 reversed. Do not use .reversed() — use two pointers to swap elements
 from both ends inward until the pointers meet.

 func reverseRoster(_ beasts: [String]) -> [String]

 Hint: make a mutable copy, then swap beasts[left] and beasts[right]
 while left < right.
*/

// MARK: Pre-defined (do not modify)

let squadRoster = ["Volthorn", "Grathix", "Skelemaw", "Pyre", "Duskfang"]
// expected: ["Duskfang", "Pyre", "Skelemaw", "Grathix", "Volthorn"]

// MARK: Your solution (Challenge 1)

func reverseRoster(_ beasts: [String]) -> [String] {
    var arrayCopy = beasts
    var left = 0
    var right = beasts.count - 1
    
    while left <= right {
        arrayCopy[left] = beasts[right]
        arrayCopy[right] = beasts[left]
        left += 1
        right -= 1
    }
    
    return arrayCopy
}


// MARK: Tests (Challenge 1) — uncomment as you go

assert(reverseRoster(squadRoster) == ["Duskfang", "Pyre", "Skelemaw", "Grathix", "Volthorn"])
assert(reverseRoster(["Axx", "Bxx"]) == ["Bxx", "Axx"])  // two elements
assert(reverseRoster(["Solo"]) == ["Solo"])               // single element, unchanged
assert(reverseRoster([]) == [])                           // empty roster
print("Challenge 1 passed!")


// ============================================================
// MARK: - Challenge 2 (The Shared Bloodline): Intersection of Two Sorted Arrays
// ============================================================
/*
 Two rival clans — the Iron Talons and the Ash Covenant — each
 maintain a sorted list of registered Wyrd-Beast IDs. The Magos
 suspects some beasts share a bloodline ancestor and appear in
 both rosters. Find which IDs are common to both.

 Given two sorted arrays of beast IDs, return a new sorted array
 containing only the IDs that appear in both. Use one pointer per
 array — advance the pointer that points to the smaller value, and
 record a match when both pointers point to the same value.

 func sharedBloodline(_ rosterA: [Int], _ rosterB: [Int]) -> [Int]

 Hint: when the values match, record it and advance both pointers.
 When they don't, advance whichever pointer holds the smaller value.
*/

// MARK: Pre-defined (do not modify)

let ironTalons  = [102, 205, 340, 418, 519, 674, 801]
let ashCovenant = [101, 205, 312, 418, 600, 674, 900]
// shared: 205, 418, 674
// expected: [205, 418, 674]

// MARK: Your solution (Challenge 2)

func sharedBloodline(_ rosterA: [Int], _ rosterB: [Int]) -> [Int] {
    var a = 0
    var b = 0
    var array = [Int]()
    
    while a < rosterA.count && b < rosterB.count {
        if rosterA[a] == rosterB[b] {
            array.append(rosterA[a])
            a += 1
            b += 1
        } else if rosterA[a] < rosterB[b]{
            a += 1
        } else {
            b += 1
        }
    }
    
    return array
}

// MARK: Tests (Challenge 2) — uncomment as you go

assert(sharedBloodline(ironTalons, ashCovenant) == [205, 418, 674])
assert(sharedBloodline([1, 2, 3], [4, 5, 6]) == [])          // no overlap
assert(sharedBloodline([1, 2, 3], [1, 2, 3]) == [1, 2, 3])   // identical rosters
assert(sharedBloodline([], [1, 2, 3]) == [])                  // one empty roster
print("Challenge 2 passed!")
