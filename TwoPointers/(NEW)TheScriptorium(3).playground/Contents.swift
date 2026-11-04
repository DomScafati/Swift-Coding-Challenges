import Foundation

// Two Pointers Challenge
//
// Phrases/patterns that signal "Two Pointers":
// "sort / group two kinds of values in place"           → converging pointers, swap the misplaced pair and move inward
// "find two items that together equal / sum to..."      → converging pointers from both ends
// "count the pairs that..."                             → converging pointers, move based on the sum
// "merge two sorted sequences"                          → one pointer per array, always take the smaller value
// "sorted array, check if a pair exists..."             → left moves right if sum too small, right moves left if sum too large

// Deep in the abbey of Saint Ormund, the scriptorium is a mess of
// manuscripts, ledgers and rival record books. The head scribe has
// asked you to get everything in order before the bishop arrives
// for his inspection.

// ============================================================
// MARK: - Challenge 1 (The Page Sort): Blanks Before Written
// ============================================================
/*
 A pile of manuscript pages has been stacked in no particular order.
 Each page is marked 0 if it is blank and 1 if it has writing on it.
 The bishop wants every blank page at the front of the pile and every
 written page at the back. You have no room for a second pile, so do
 it in place — no new arrays and no built-in sorting.

 Given an array of 0s and 1s, rearrange it so all the 0s come first,
 followed by all the 1s.

 func sortPages(_ pages: inout [Int])

 Hint: put a pointer at each end. Skip past pages that are already in
 the right place, and swap when both pointers are on a misplaced page.
 */

// MARK: Pre-defined (do not modify)

var pileA = [1, 0, 1, 0, 0, 1]     // [0, 0, 0, 1, 1, 1]
var pileB = [1, 1, 0, 0]           // [0, 0, 1, 1]
var pileC = [0, 0, 1]              // [0, 0, 1] — already in order
var pileD = [1, 1, 1]              // [1, 1, 1] — nothing to move
var pileE: [Int] = []              // []

// MARK: Your solution (Challenge 1)



// MARK: Tests (Challenge 1) — uncomment as you go

// sortPages(&pileA)
// assert(pileA == [0, 0, 0, 1, 1, 1])
//
// sortPages(&pileB)
// assert(pileB == [0, 0, 1, 1])
//
// sortPages(&pileC)
// assert(pileC == [0, 0, 1])
//
// sortPages(&pileD)
// assert(pileD == [1, 1, 1])
//
// sortPages(&pileE)
// assert(pileE == [])
//
// print("Challenge 1 passed!")


// ============================================================
// MARK: - Challenge 2 (The Tithe Book): Count Balanced Pairs
// ============================================================
/*
 The abbey collects its tithe in coins, and the tithe book lists every
 coin value in ascending order. No value appears twice. The bishop
 wants to know how many different pairs of coins add up to exactly
 the tithe amount he is owed. A coin cannot be paired with itself.

 Given a sorted array of distinct coin values and a tithe amount,
 return the number of pairs of coins whose values sum to exactly the
 tithe.

 func countBalancedPairs(_ coins: [Int], tithe: Int) -> Int

 Hint: start with a pointer at each end. If the sum is too small move
 the left one in, if it is too large move the right one in, and when
 you find a match count it and move both.
 */

// MARK: Pre-defined (do not modify)

let titheCoins = [2, 5, 8, 11, 14, 17, 20]
// expected: countBalancedPairs(titheCoins, tithe: 25) == 3   → 5 + 20, 8 + 17, 11 + 14
// expected: countBalancedPairs(titheCoins, tithe: 22) == 3   → 2 + 20, 5 + 17, 8 + 14

// MARK: Your solution (Challenge 2)



// MARK: Tests (Challenge 2) — uncomment as you go

// assert(countBalancedPairs(titheCoins, tithe: 25) == 3)    // 5 + 20, 8 + 17, 11 + 14
// assert(countBalancedPairs(titheCoins, tithe: 22) == 3)    // 11 + 11 does not count, a coin can't pair with itself
// assert(countBalancedPairs(titheCoins, tithe: 16) == 2)    // 2 + 14, 5 + 11
// assert(countBalancedPairs(titheCoins, tithe: 100) == 0)   // nothing is large enough
// assert(countBalancedPairs([5], tithe: 10) == 0)           // a single coin has no partner
// assert(countBalancedPairs([], tithe: 10) == 0)
// print("Challenge 2 passed!")


// ============================================================
// MARK: - Challenge 3 (The Rival Ledgers): Merge Two Sorted Lists
// ============================================================
/*
 The abbey keeps two record books, one in the north cloister and one
 in the south. Each lists the catalogue numbers of its manuscripts in
 ascending order, and the books overlap, so a number may appear in
 both. The bishop wants a single master list, still in ascending
 order, with every entry kept (duplicates included).

 Given two sorted arrays of catalogue numbers, return one sorted array
 containing every number from both.

 func mergeLedgers(_ north: [Int], _ south: [Int]) -> [Int]

 Hint: keep a pointer in each array and take whichever front value is
 smaller. Once one array runs out, the rest of the other goes straight in.
 */

// MARK: Pre-defined (do not modify)

let northLedger = [102, 215, 318, 450, 777]
let southLedger = [98, 215, 400, 451, 900, 1200]
// expected: mergeLedgers(northLedger, southLedger) == [98, 102, 215, 215, 318, 400, 450, 451, 777, 900, 1200]

// MARK: Your solution (Challenge 3)



// MARK: Tests (Challenge 3) — uncomment as you go

// assert(mergeLedgers(northLedger, southLedger) == [98, 102, 215, 215, 318, 400, 450, 451, 777, 900, 1200])
// assert(mergeLedgers([1, 2, 3], [4, 5, 6]) == [1, 2, 3, 4, 5, 6])   // north entirely first
// assert(mergeLedgers([4, 5, 6], [1, 2, 3]) == [1, 2, 3, 4, 5, 6])   // south entirely first
// assert(mergeLedgers([], southLedger) == southLedger)               // north book is empty
// assert(mergeLedgers(northLedger, []) == northLedger)               // south book is empty
// assert(mergeLedgers([], []) == [])
// print("Challenge 3 passed!")
