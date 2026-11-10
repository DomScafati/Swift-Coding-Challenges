import Foundation

// Swift Dev Challenge — Operator Overloading
//
// Phrases/patterns that signal "Operator Overloading":
// "add / multiply my own type with + or *"     → static func + (lhs: T, rhs: T) -> T  (in an extension)
// "== should compare my own type"              → conform to Equatable, write static func ==
// "sort / max / > on my own type"              → conform to Comparable, write static func <
// "update the left side in place (+=)"         → static func += (lhs: inout T, rhs: T)
// "an operator that mixes two types (T * Int)" → lhs and rhs may have different types

// The kingdom of Eldmoor mints two coins: gold and silver, and ten silver
// make one gold. The royal treasurer is tired of doing coin sums on paper,
// so she wants Coins to behave like numbers in Swift: add them, compare
// them and scale them. Each challenge builds on the one before it.


// MARK: - Shared types (do not modify)

struct Coins {
    var gold: Int
    var silver: Int
}

// A Coins value is "normalized" when silver is between 0 and 9.
// Values you are given may NOT be normalized (for example 0 gold and 25
// silver is worth the same as 2 gold and 5 silver), but every Coins
// value that your operators RETURN must be normalized.


// ============================================================
// MARK: - Challenge 1 (The Counting House): + and ==
// ============================================================
/*
 The treasurer wants to add two purses together and to ask whether
 two purses hold the same amount of money.

 Write these as operators on Coins (put them in an extension):

   + : returns the combined purse. The result must be normalized: every
       10 silver is carried over into 1 gold.
   == : two Coins are equal when they are worth the same amount, even if
        they are written differently (0 gold 25 silver == 2 gold 5 silver).
        Declare the extension as `extension Coins: Equatable` so that
        Swift also gives you != for free.

 static func + (lhs: Coins, rhs: Coins) -> Coins
 static func == (lhs: Coins, rhs: Coins) -> Bool

 Hint: both operators are easiest to write if you first think of every
 purse as a single amount of silver.
*/

// MARK: Pre-defined (do not modify)
let a = Coins(gold: 1, silver: 7)      // 17 silver
let b = Coins(gold: 2, silver: 6)      // 26 silver
let c = Coins(gold: 0, silver: 25)     // 25 silver, not normalized
let d = Coins(gold: 2, silver: 5)      // 25 silver
let none = Coins(gold: 0, silver: 0)

// MARK: Your solution (Challenge 1)

extension Coins: Equatable {
    static func + (lhs: Coins, rhs: Coins) -> Coins {
        var baseSilver = lhs.silver + rhs.silver
        var baseGold = lhs.gold + rhs.gold
        var totalSilver = baseSilver + (baseGold * 10)
        
        var goldNormalized = totalSilver / 10
        var silverNormalized = totalSilver % 10
        
        return Coins(gold: goldNormalized, silver: silverNormalized)
    
    }
    
    static func == (lhs: Coins, rhs: Coins) -> Bool {
        var totalLhsSilver = lhs.silver + (lhs.gold * 10)
        var totalRhsSilver = rhs.silver + (rhs.gold * 10)
        
        return totalLhsSilver == totalRhsSilver
    }
}

// MARK: Tests (Challenge 1) — uncomment as you go

let sum = a + b                                   // 17 + 26 = 43 silver
assert(sum.gold == 4 && sum.silver == 3)
assert(sum == Coins(gold: 4, silver: 3))
assert(a + none == a)                             // adding nothing changes nothing
assert(none + none == none)
let exact = Coins(gold: 0, silver: 5) + Coins(gold: 0, silver: 5)
assert(exact.gold == 1 && exact.silver == 0)      // exactly 10 silver carries
let big = c + d                                   // 25 + 25 = 50 silver
assert(big.gold == 5 && big.silver == 0)
let tidy = c + none                               // result is normalized even though c was not
assert(tidy.gold == 2 && tidy.silver == 5)
assert(c == d)                                    // same value, written differently
assert(a != b)
print("Challenge 1 passed!")


// ============================================================
// MARK: - Challenge 2 (The Auction): <
// ============================================================
/*
 At the royal auction, bids are Coins. The treasurer wants to compare
 bids with < and also to sort them and pick the biggest.

 Make Coins conform to Comparable by writing `<`. Comparable builds on
 Equatable, which you finished in Challenge 1. Once `<` exists, Swift
 gives you >, <=, >=, sorted() and max() for free. A bid is smaller when
 it is worth less money, no matter how it is written.

 Then write a function that returns the two highest bids, the highest
 first. If there are fewer than two bids, return all of them, highest
 first. Equal bids are interchangeable, so ties do not matter.

 static func < (lhs: Coins, rhs: Coins) -> Bool
 func topTwo(_ bids: [Coins]) -> [Coins]

 Hint: once Coins is Comparable, Swift's own sorting works on it.
*/

// MARK: Pre-defined (do not modify)
let bids = [
    Coins(gold: 1, silver: 2),     // 12 silver
    Coins(gold: 0, silver: 25),    // 25 silver
    Coins(gold: 3, silver: 0),     // 30 silver
    Coins(gold: 2, silver: 4),     // 24 silver
    Coins(gold: 0, silver: 9),     // 9 silver
]

// MARK: Your solution (Challenge 2)

extension Coins: Comparable {
    static func < (lhs: Coins, rhs: Coins) -> Bool {
        var totalLhsSilver = lhs.silver + (lhs.gold * 10)
        var totalRhsSilver = rhs.silver + (rhs.gold * 10)
        
        if lhs == rhs { return false }
        
        if totalLhsSilver < totalRhsSilver { return true } else { return false }
    }
}

func topTwo(_ bids: [Coins]) -> [Coins] {
    if bids.count < 2 { return bids }
    var sorted = bids.sorted(by: >)
    
    return [sorted[0], sorted[1]]
}

// MARK: Tests (Challenge 2) — uncomment as you go

assert(Coins(gold: 2, silver: 4) < Coins(gold: 0, silver: 25))    // 24 < 25: more gold, but still worth less
assert(Coins(gold: 2, silver: 0) > Coins(gold: 1, silver: 9))     // 20 > 19, > comes for free
assert(!(Coins(gold: 0, silver: 25) < Coins(gold: 2, silver: 5))) // equal value is not less
assert(bids.max() == Coins(gold: 3, silver: 0))                   // max() comes for free
assert(bids.min() == Coins(gold: 0, silver: 9))
topTwo(bids)
assert(topTwo(bids) == [Coins(gold: 3, silver: 0), Coins(gold: 0, silver: 25)])
assert(topTwo([Coins(gold: 1, silver: 0)]) == [Coins(gold: 1, silver: 0)])   // only one bid
assert(topTwo([]) == [])
print("Challenge 2 passed!")


// ============================================================
// MARK: - Challenge 3 (The Tithe): * and +=
// ============================================================
/*
 Every village owes the crown a tithe: a fixed amount of Coins for each
 member of each household. The treasurer needs to scale a purse by a
 whole number and to add into a running total.

 Write two more operators on Coins:

   * : Coins * Int, the purse repeated that many times. The Int is never
       negative. The result must be normalized.
   += : adds the right purse into the left one, which is changed in
        place. The result must be normalized.

 Then write a function that returns the total tithe a list of households
 owes, using the operators you just wrote. Households with no members
 owe nothing, and no households means a total of zero Coins.

 static func * (lhs: Coins, rhs: Int) -> Coins
 static func += (lhs: inout Coins, rhs: Coins)
 func totalTithe(_ households: [Household], perMember: Coins) -> Coins

 Hint: `+=` is allowed to reuse the `+` you already wrote.
*/

// MARK: Pre-defined (do not modify)
struct Household {
    let name: String
    let members: Int
}

let village = [
    Household(name: "Ashby", members: 3),
    Household(name: "Brook", members: 1),
    Household(name: "Cress", members: 4),
    Household(name: "Dale", members: 0),
]
let tithePerMember = Coins(gold: 1, silver: 4)    // 14 silver

// MARK: Your solution (Challenge 3)

extension Coins {
    static func * (lhs: Coins, rhs: Int) -> Coins {
        var baseTotalLhsSilver = lhs.silver + (lhs.gold * 10)
        var multipliedSilver = baseTotalLhsSilver * rhs
        
        var goldFromSilver = multipliedSilver / 10
        var remainingSilver = multipliedSilver % 10
        return Coins(gold: goldFromSilver,
                     silver: remainingSilver)
    }
    
    static func += (lhs: inout Coins, rhs: Coins) {
        lhs = lhs + rhs
    }
}

func totalTithe(_ households: [Household], perMember: Coins) -> Coins {
    var totalCoins: Coins = Coins(gold: 0, silver: 0)
    households.forEach { home in
        var homeTotal = perMember * home.members
        totalCoins += homeTotal
    }
    
    return totalCoins
}


// MARK: Tests (Challenge 3) — uncomment as you go

let triple = tithePerMember * 3                   // 42 silver
assert(triple.gold == 4 && triple.silver == 2)
let nothing = tithePerMember * 0
assert(nothing.gold == 0 && nothing.silver == 0)
let once = tithePerMember * 1
assert(once.gold == 1 && once.silver == 4)
let doubled = Coins(gold: 0, silver: 25) * 2      // not-normalized input, 50 silver
assert(doubled.gold == 5 && doubled.silver == 0)

var purse = Coins(gold: 1, silver: 8)             // 18 silver
purse += Coins(gold: 0, silver: 5)                // + 5 = 23 silver
assert(purse.gold == 2 && purse.silver == 3)

let owed = totalTithe(village, perMember: tithePerMember)   // 8 members * 14 = 112 silver
assert(owed.gold == 11 && owed.silver == 2)
let empty = totalTithe([], perMember: tithePerMember)
assert(empty.gold == 0 && empty.silver == 0)
print("Challenge 3 passed!")
