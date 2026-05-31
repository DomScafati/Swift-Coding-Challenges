import Foundation

// Hashing / Dictionary Challenge
//
// Phrases/patterns that signal "Dictionary":
// "how many times does X appear"         → frequency map
// "find the most/least common"           → frequency map + max/min
// "have you seen this value before"      → set or dict for O(1) lookup
// "do these two collections match"       → compare frequency maps
// "does any pair sum to a target"        → store seen values, check complement

// Opening weekend at the Crestwood Multiplex. The box office is
// tracking bookings, comparing screenings, and trying to keep
// up with the Saturday night rush.


// ============================================================
// MARK: - Challenge 1 (Top Billing): Most Frequent Element
// ============================================================
/*
 The box office wants to know which film sold the most tickets
 today. Each booking logs a film title — find the one that
 appears most often.

 Given an array of film titles, return the title that appears
 the most times. You can assume there is always one clear winner.

 func topBilling(_ bookings: [String]) -> String
*/

// MARK: Pre-defined (do not modify)

let bookings = [
    "Dune", "Wicked", "Dune", "Mufasa", "Wicked",
    "Dune", "Mufasa", "Wicked", "Dune", "Wicked"
]
// Dune: 4, Wicked: 4, Mufasa: 2 — wait, let's recount
// Dune: index 0,2,5,8 = 4    Wicked: index 1,4,7,9 = 4    Mufasa: index 3,6 = 2
// expected: "Dune" (first to reach the highest count)

// MARK: Your solution (Challenge 1)

func topBilling(_ bookings: [String]) -> String {
    var dict = [String: Int]()
    var highest = ("", 0)
    
    for name in bookings {
        dict[name, default: 0] += 1
        
        // force unwrapping is okay since i'm always instantiating a value above
        if dict[name]! > highest.1 {
            highest.0 = name
            highest.1 = dict[name]!
        }
    }
    
    return highest.0
}

// MARK: Tests (Challenge 1) — uncomment as you go

assert(topBilling(bookings) == "Dune")
assert(topBilling(["A", "B", "B", "C"]) == "B")
assert(topBilling(["X"]) == "X")
print("Challenge 1 passed!")


// ============================================================
// MARK: - Challenge 2 (Same Cast): Matching Frequency Maps
// ============================================================
/*
 Two rival screenings are being compared. The studio wants to
 know if both screenings had exactly the same cast — same actors,
 same number of appearances each, but possibly listed in a
 different order.

 Given two arrays of actor names, return true if they contain
 the same names with the same frequencies, regardless of order.

 func sameCast(_ a: [String], _ b: [String]) -> Bool
*/

// MARK: Pre-defined (do not modify)

let castA = ["Pugh", "Chalamet", "Zendaya", "Pugh"]
let castB = ["Zendaya", "Pugh", "Chalamet", "Pugh"]
// same names, same counts → true

let castC = ["Pugh", "Pugh", "Zendaya"]
let castD = ["Pugh", "Zendaya", "Zendaya"]
// different counts → false

// MARK: Your solution (Challenge 2)

func sameCast(_ a: [String], _ b: [String]) -> Bool {
    var dictA = [String: Int]() // name, count
    var dictB = [String: Int]() // name, count

    for name in a {
        dictA[name, default: 0] += 1
    }
    
    for name in b {
        dictB[name, default: 0] += 1
    }
    
    for (name, count) in dictA {
        if dictB[name] != count {
            return false
        }
    }
    
    return true
}


// MARK: Tests (Challenge 2) — uncomment as you go

assert(sameCast(castA, castB) == true)
assert(sameCast(castC, castD) == false)
assert(sameCast([], []) == true)
assert(sameCast(["A"], ["B"]) == false)
print("Challenge 2 passed!")


// ============================================================
// MARK: - Challenge 3 (Split the Bill): Two Sum
// ============================================================
/*
 Two friends are splitting the cost of concessions. Given a list
 of item prices and a target total, return true if any two items
 add up to exactly the target.

 Each item can only be used once, and the two items must be
 at different positions in the array.

 func splitBill(_ prices: [Int], target: Int) -> Bool

 Hint: as you walk through the array, ask "have I already seen
 the number that would pair with this one?" A dictionary lets
 you answer that in O(1).
*/

// MARK: Pre-defined (do not modify)

let prices = [3, 8, 5, 2, 9, 1]
// expected: splitBill(prices, target: 10) == true  → 1 + 9 or 8 + 2

// MARK: Your solution (Challenge 3)

func splitBill(_ prices: [Int], target: Int) -> Bool {
    var dict = [Int: Int]() // the num and its pair
    
    var i = 0
    while i < prices.count {
        var current = prices[i]
        dict[current, default: 0] // no pair by default

        var j = 0
        while j < prices.count {
            var pair = prices[j]
            if j != i { // choose when to skip the same index
                if current + pair == target {
                    return true
                }
            }
            j += 1
        }
        i += 1
    }
    return false
}

// This version of splitBill is not my own solution
func splitBillAlternate(_ prices: [Int], target: Int) -> Bool {
    var seen = Set<Int>()
    for price in prices {
        if seen.contains(target - price) { return true }
        seen.insert(price)
    }
    return false
}

// MARK: Tests (Challenge 3) — uncomment as you go

assert(splitBill(prices, target: 10) == true)   // 1 + 9
assert(splitBill(prices, target: 4)  == true)   // 3 + 1
assert(splitBill(prices, target: 20) == false)  // no pair
assert(splitBill([5, 5], target: 10) == true)   // same value, different positions
assert(splitBill([5], target: 10)    == false)  // only one item
print("Challenge 3 passed!")
