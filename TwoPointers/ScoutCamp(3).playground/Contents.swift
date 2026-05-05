import Foundation

// Two Pointers Challenge
//
// Phrases/patterns that signal "Two Pointers":
// "find two items that together equal / sum to..."    → converging pointers from both ends
// "sorted array, check if a pair exists..."           → left moves right if sum too small, right moves left if sum too large
// "reads the same forwards and backwards"             → palindrome check, one pointer at each end, move inward
// "verify / validate from both ends"                  → converging pointers
// "compare the first and last, then move inward"      → converging pointers

// You're a scout leader preparing for the annual camping trip.
// Supplies arrive pre-sorted by weight, and trail markers need
// validation before the troop heads out into the wilderness.

// ============================================================
// MARK: - Challenge 1 (Pack Check): Pair with Target Weight
// ============================================================
/*
 Story: Each scout carries a pack with a strict weight limit (in grams).
 Supplies are laid out in sorted order by weight. Before loading up,
 you need to check whether any two supplies together hit the pack's
 exact weight limit — not over, not under.

 Task: Given a sorted array of supply weights and a target weight,
 return true if any two different supplies sum to exactly the target.

 Requirements:
 1. Implement: func canFillPack(_ weights: [Int], target: Int) -> Bool
    - Use two pointers: one starting at the left end, one at the right end
    - If the sum equals the target, return true
    - If the sum is too small, advance the left pointer
    - If the sum is too large, move the right pointer back
    - The two pointers must never be at the same index
    - Return false if no valid pair is found
 */

// MARK: Pre-defined (do not modify)

let suppliesA: [Int] = [120, 200, 350, 500, 780, 900]   // 200 + 500 = 700, 120 + 780 = 900
let suppliesB: [Int] = [100, 250, 400, 600]              // 400 + 600 = 1000, 100 + 250 = 350
let suppliesC: [Int] = [300]                             // only one item — no pair possible

// MARK: Your solution (Challenge 1)

func canFillPack(_ weights: [Int], target: Int) -> Bool {
    var left = 0
    var right = weights.count - 1
    
    while left <= right {
        let combined = weights[left] + weights[right]
        if combined == target {
            return true
        } else if combined < target {
            left += 1
        } else {
            right -= 1
        }
    }
    
    return false
}

// MARK: Tests (Challenge 1) — uncomment as you go

 assert(canFillPack(suppliesA, target: 700) == true)   // 200 + 500
 assert(canFillPack(suppliesA, target: 900) == true)   // 120 + 780
 assert(canFillPack(suppliesA, target: 500) == false)  // no valid pair
 assert(canFillPack(suppliesB, target: 1000) == true)  // 400 + 600
 assert(canFillPack(suppliesB, target: 350) == true)   // 100 + 250
 assert(canFillPack(suppliesC, target: 300) == false)  // single element, no pair
 print("Challenge 1 passed!")


// ============================================================
// MARK: - Challenge 2 (Trail Markers): Palindrome Validation
// ============================================================
/*
 Story: Each trail section has a short marker code painted on a rock.
 A valid marker reads the same forwards and backwards — the scouts use
 this as a quick field check to confirm they have a genuine marker.
 Markers may contain spaces or hyphens as separators, and the check
 is case-insensitive.

 Task: Given a marker code string, return true if it is a palindrome
 when ignoring spaces, hyphens, and letter casing.

 Requirements:
 1. Implement: func isValidMarker(_ code: String) -> Bool
    - Build a cleaned version of the input: keep only letters and digits,
      all converted to lowercase
    - Use two pointers — one at the start, one at the end of the cleaned string
    - Move both pointers inward, comparing the characters at each position
    - Return false as soon as a mismatch is found
    - Return true if all characters match (an empty string is considered valid)
 */

// MARK: Pre-defined (do not modify)

let markerA = "racecar"                         // palindrome
let markerB = "NORTH-HTRON"                     // palindrome after removing hyphens and lowercasing
let markerC = "A man a plan a canal Panama"     // classic palindrome after cleaning
let markerD = "Scout Troop"                     // not a palindrome
let markerE = ""                                // empty — counts as valid

// MARK: Your solution (Challenge 2)

func isValidMarker(_ code: String) -> Bool {
    var cleanedString = code.replacingOccurrences(of: " ", with: "", options: .numeric).lowercased()
    var characterArray = Array(cleanedString)
    var left = 0
    var right = characterArray.count - 1
    
    while left <= right {
        if characterArray[left] == characterArray[right] {
            left += 1
            right -= 1
        } else {
            return false
        }
    }
    return true
}

// MARK: Tests (Challenge 2) — uncomment as you go

 assert(isValidMarker(markerA) == true)
 assert(isValidMarker(markerB) == true)
 assert(isValidMarker(markerC) == true)
 assert(isValidMarker(markerD) == false)
 assert(isValidMarker(markerE) == true)
 print("Challenge 2 passed!")
