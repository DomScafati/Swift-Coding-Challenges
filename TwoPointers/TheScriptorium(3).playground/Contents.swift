import Foundation

// Two Pointers Challenge
//
// Phrases/patterns that signal "Two Pointers":
// "reverse / mirror in place"                           → converging pointers, swap the ends and move inward
// "find two items that together equal / sum to..."      → converging pointers from both ends
// "count the pairs that..."                             → converging pointers, move based on the sum
// "remove duplicates / compress in place"               → slow/fast pointers, slow marks the next write position, fast scans ahead

// Deep in the abbey of Saint Ormund, the scriptorium is a mess of
// shelves, ledgers and half-finished manuscripts. The head scribe has
// asked you to tidy up before the bishop arrives for his inspection.

// ============================================================
// MARK: - Challenge 1 (The Shelf): Flip the Order
// ============================================================
/*
 The books on the scriptorium shelf were put back in the wrong order,
 and the bishop wants them in exact reverse. Each book has a catalogue
 number. You have no room for a second shelf, so do it in place — no
 new arrays and no built-in reversing.

 Given an array of catalogue numbers, reverse its order in place.

 func flipShelf(_ books: inout [Int])

 Hint: put a pointer at each end, swap the two books, then move both
 pointers inward until they meet.
 */

// MARK: Pre-defined (do not modify)

var shelfA = [1, 2, 3, 4, 5]       // [5, 4, 3, 2, 1]
var shelfB = [10, 20, 30, 40]      // [40, 30, 20, 10]
var shelfC = [7]                   // [7]
var shelfD: [Int] = []             // []

// MARK: Your solution (Challenge 1)



// MARK: Tests (Challenge 1) — uncomment as you go

// flipShelf(&shelfA)
// assert(shelfA == [5, 4, 3, 2, 1])
//
// flipShelf(&shelfB)
// assert(shelfB == [40, 30, 20, 10])
//
// flipShelf(&shelfC)
// assert(shelfC == [7])
//
// flipShelf(&shelfD)
// assert(shelfD == [])
//
// print("Challenge 1 passed!")


// ============================================================
// MARK: - Challenge 2 (The Tithe Book): Count Balanced Pairs
// ============================================================
/*
 The abbey collects its tithe in coins, and the tithe book lists every
 coin value in ascending order. No value appears twice. The bishop
 wants to know how many different pairs of coins add up to exactly
 the tithe amount he is owed.

 Given a sorted array of distinct coin values and a tithe amount,
 return the number of pairs of coins whose values sum to exactly the
 tithe. A coin cannot be paired with itself.

 func countBalancedPairs(_ coins: [Int], tithe: Int) -> Int

 Hint: start with a pointer at each end. If the sum is too small move
 the left one in, if it is too large move the right one in, and when
 you find a match count it and move both.
 */

// MARK: Pre-defined (do not modify)

let titheCoins = [1, 3, 4, 6, 7, 9, 12]
// expected: countBalancedPairs(titheCoins, tithe: 13) == 3   → 1 + 12, 4 + 9, 6 + 7
// expected: countBalancedPairs(titheCoins, tithe: 8) == 1    → 1 + 7

// MARK: Your solution (Challenge 2)

func countBalancedPairs(_ coins: [Int], tithe: Int) -> Int {
    var left = 0
    var right = coins.count - 1
    var count = 0
    
    while left < right {
        var guess = coins[left] + coins[right]
        if guess == tithe {
            count += 1
            left += 1
        } else if guess < tithe {
            left += 1
        } else {
            right -= 1
        }
    }
    
    return count
}


// MARK: Tests (Challenge 2) — uncomment as you go

 assert(countBalancedPairs(titheCoins, tithe: 13) == 3)    // 1 + 12, 4 + 9, 6 + 7
 assert(countBalancedPairs(titheCoins, tithe: 8) == 1)     // 1 + 7 only
 assert(countBalancedPairs(titheCoins, tithe: 100) == 0)   // nothing is large enough
 assert(countBalancedPairs([5], tithe: 10) == 0)           // a single coin cannot pair with itself
 assert(countBalancedPairs([], tithe: 10) == 0)
 print("Challenge 2 passed!")


// ============================================================
// MARK: - Challenge 3 (The Page Records): Remove Duplicates
// ============================================================
/*
 The abbey's page records list the page numbers of every manuscript
 in ascending order, but a careless monk copied some entries more than
 once. The bishop wants each page number to appear only once. Do it
 in place — no new arrays.

 Given a sorted array of page numbers, rearrange it so the unique
 numbers sit at the front in their original order, and return how many
 unique numbers there are. Whatever is left after those unique numbers
 does not matter.

 func tidyPages(_ pages: inout [Int]) -> Int

 Hint: use a slow pointer that tracks where the next unique number
 should land, and a fast pointer that scans ahead looking for a number
 that differs from the last one you kept.
 */

// MARK: Pre-defined (do not modify)

var pagesA = [1, 1, 2, 2, 2, 3, 5, 5]   // unique: [1, 2, 3, 5]  → 4
var pagesB = [4, 4, 4, 4]               // unique: [4]           → 1
var pagesC = [7, 8, 9]                  // unique: [7, 8, 9]     → 3
var pagesD: [Int] = []                  // nothing to tidy       → 0

// MARK: Your solution (Challenge 3)

func tidyPages(_ pages: inout [Int]) -> Int {
    if pages.isEmpty { return 0 }

    var slow = 0   // position of the last unique number kept

    for fast in 1..<pages.count {
        if pages[fast] != pages[slow] {   // found a new number
            slow += 1
            pages[slow] = pages[fast]     // place it right after the last unique one
        }
    }

    return slow + 1   // slow is an index, so the count is one more
}

// MARK: Tests (Challenge 3) — uncomment as you go

// let uniqueA = tidyPages(&pagesA)
// assert(uniqueA == 4)
// assert(Array(pagesA[0..<uniqueA]) == [1, 2, 3, 5])
//
// let uniqueB = tidyPages(&pagesB)
// assert(uniqueB == 1)
// assert(Array(pagesB[0..<uniqueB]) == [4])
//
// let uniqueC = tidyPages(&pagesC)
// assert(uniqueC == 3)
// assert(Array(pagesC[0..<uniqueC]) == [7, 8, 9])
//
// assert(tidyPages(&pagesD) == 0)
//
// print("Challenge 3 passed!")
