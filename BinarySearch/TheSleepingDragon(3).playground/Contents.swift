import Foundation

// Binary Search Challenge
//
// Phrases/patterns that signal "Binary Search":
// "sorted array"                              → binary search
// "find the index / does it exist"            → binary search
// "O(log n) lookup"                           → binary search
// "left, right, middle / cut the range"       → binary search
// "first / last item that meets a condition"  → binary search, keep narrowing after a hit

// Deep under Mount Cinder, the dragon Ashgrave sleeps on a hoard so vast
// it fills three caverns. Every treasure has been stacked by value, lowest
// to highest. You've snuck in with a bag, a lantern, and a very short
// window before she wakes. Walking the whole pile is out of the question.
// You need to find what you want without touching most of it.

// MARK: Pre-defined (do not modify)

// Each number is the value of one treasure, sorted lowest to highest.
// Different treasures can share the same value.
let hoard = [5, 12, 12, 20, 35, 35, 35, 48, 60, 75, 90, 90, 120]


// ============================================================
// MARK: - Challenge 1 (The Locked Chest): Does It Exist
// ============================================================
/*
 A fence in the village has offered a fortune for a treasure worth exactly
 a certain amount, and you only want to risk the trip if the hoard really
 holds one.

 Given the sorted hoard and a value, return true if at least one treasure
 is worth exactly that value, otherwise false.

 func hasTreasure(worth value: Int, in hoard: [Int]) -> Bool

 Hint: look at the middle treasure and throw away the half that can't
 contain the value.
 */

// MARK: Your solution (Challenge 1)
func hasTreasure(worth value: Int, in hoard: [Int]) -> Bool {
    var left = 0
    var right = hoard.count - 1
    
    while left <= right {
        var middle = (left + right)/2
        
        if hoard[middle] == value {
            return true
        } else if hoard[middle] > value {
            right = middle - 1
        } else {
            left = middle + 1
        }
    }
    
    return false
}



// MARK: Tests (Challenge 1) — uncomment as you go
 assert(hasTreasure(worth: 48, in: hoard) == true)
 assert(hasTreasure(worth: 5, in: hoard) == true)     // first treasure
 assert(hasTreasure(worth: 120, in: hoard) == true)   // last treasure
 assert(hasTreasure(worth: 50, in: hoard) == false)   // between two treasures
 assert(hasTreasure(worth: 1, in: hoard) == false)    // below everything
 assert(hasTreasure(worth: 200, in: hoard) == false)  // above everything
 assert(hasTreasure(worth: 10, in: []) == false)
 print("Challenge 1 passed!")


// ============================================================
// MARK: - Challenge 2 (The Weight Limit): Last One That Fits
// ============================================================
/*
 Your bag is cursed. It rips apart if you put in anything worth more than
 a certain limit. You want to grab the single most valuable treasure that
 is still worth no more than the limit. If several treasures share that
 value, take the last one in the pile, since it sits closest to the
 top and is the easiest to reach.

 Return the index of that treasure, or -1 if every treasure is worth more
 than the limit.

 func priciestWithin(limit: Int, in hoard: [Int]) -> Int

 Hint: when a treasure is within the limit, remember its index but keep
 searching to the right, because a better one might be further along.
 */

// MARK: Your solution (Challenge 2)

func priciestWithin(limit: Int, in hoard: [Int]) -> Int {
    var best = -1
    var left = 0
    var right = hoard.count - 1
    while left <= right {
        var middle = (left + right)/2
        var guess = hoard[middle]
        
        if guess <= limit {
            best = middle
            left = middle + 1
        } else {
            right = middle - 1
        }
    }
    return best
}

// MARK: Tests (Challenge 2) — uncomment as you go
 assert(priciestWithin(limit: 50, in: hoard) == 7)    // 48
 assert(priciestWithin(limit: 35, in: hoard) == 6)    // the last of three 35s
 assert(priciestWithin(limit: 89, in: hoard) == 9)    // 75
 assert(priciestWithin(limit: 90, in: hoard) == 11)   // the last of two 90s
 assert(priciestWithin(limit: 120, in: hoard) == 12)  // everything fits
 assert(priciestWithin(limit: 1000, in: hoard) == 12)
 assert(priciestWithin(limit: 4, in: hoard) == -1)    // nothing fits
 print("Challenge 2 passed!")


// ============================================================
// MARK: - Challenge 3 (The Hidden Niche): Where Does It Go
// ============================================================
/*
 You've swiped a prize from somewhere else in the mountain, and you want
 to slip it into Ashgrave's hoard so the pile stays sorted and she never
 notices anything is out of place. You need to know which position it
 belongs in.

 Given the sorted hoard and the value of your new treasure, return the
 index where it should be inserted so the hoard stays sorted. If the hoard
 already holds treasures of the same value, your treasure goes in front
 of them. If it is worth more than everything, the index is the number
 of treasures in the hoard.

 func insertionIndex(for value: Int, in hoard: [Int]) -> Int

 Hint: the answer is the first position holding a treasure that is not
 worth less than yours.
 */

// MARK: Your solution (Challenge 3)

func insertionIndex(for value: Int, in hoard: [Int]) -> Int {
    var position = hoard.count
    var left = 0
    var right = hoard.count - 1
    
    while left <= right {
        var middle = (left + right) / 2
        
        if hoard[middle] >= value {
            position = middle
            right = middle - 1
        } else {
            left = middle + 1
        }
    }
    
    return position
}



// MARK: Tests (Challenge 3) — uncomment as you go
 assert(insertionIndex(for: 1, in: hoard) == 0)      // cheaper than everything
 assert(insertionIndex(for: 5, in: hoard) == 0)      // same as the first, goes in front
 assert(insertionIndex(for: 6, in: hoard) == 1)
 assert(insertionIndex(for: 12, in: hoard) == 1)     // in front of the two 12s
 assert(insertionIndex(for: 13, in: hoard) == 3)     // right before the 20
 assert(insertionIndex(for: 35, in: hoard) == 4)     // in front of the three 35s
 assert(insertionIndex(for: 50, in: hoard) == 8)     // between 48 and 60
 assert(insertionIndex(for: 90, in: hoard) == 10)
 assert(insertionIndex(for: 120, in: hoard) == 12)
 assert(insertionIndex(for: 121, in: hoard) == 13)   // worth more than everything
 assert(insertionIndex(for: 1000, in: hoard) == 13)
 assert(insertionIndex(for: 7, in: []) == 0)
 print("Challenge 3 passed!")


// ============================================================
// MARK: Archived: your attempt at the old Challenge 3 (Counting Copies)
// ============================================================
// func copies(of value: Int, in hoard: [Int]) -> Int {
//     var total = 0
//     var left = 0
//     var right = hoard.count - 1
//
//     while left <= right {
//         var middle = (left + right) / 2
//
//         if hoard[middle] >= value {
//             total += 1
//             right = middle - 1
//         } else {
//             left = middle + 1
//         }
//     }
//
//     return total
// }
