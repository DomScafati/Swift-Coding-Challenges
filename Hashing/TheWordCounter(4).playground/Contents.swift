import UIKit

// MARK: - The Word Counter
//
// You're building a text analysis tool. Given an array of words from a
// document, return a dictionary showing how many times each word appears.
// Then, return only the words that appear more than once — sorted alphabetically.
//
// Rules:
// - Treat all words as lowercased (so "The" and "the" count as the same word)
// - Return only duplicates (count >= 2), sorted A-Z

// MARK: - Your function

func duplicateWords(in words: [String]) -> [String] {
    var finalSet = Set<String>()
    var dict = [String: Int]()
    // place each word in a hash
    // increment the value at key
    // add any word where value > 1 to an array
    // sort that array
    for word in words {
        dict[word, default: 0] += 1
        if dict[word]! > 1 { // this will never be nil
            finalSet.insert(word)
        }
    }

    return finalSet.sorted()
}

// MARK: - Test Cases

// Test 1
let words1 = ["the", "cat", "sat", "on", "the", "mat", "the", "cat"]
// Expected: ["cat", "the"]

// Test 2
let words2 = ["Swift", "is", "swift", "and", "swift", "is", "great"]
// Expected: ["is", "swift"]

// Test 3 — no duplicates
let words3 = ["one", "two", "three"]
// Expected: []

// Test 4 — all duplicates
let words4 = ["go", "go", "go", "stop", "stop"]
// Expected: ["go", "stop"]

duplicateWords(in: words1)
duplicateWords(in: words2)
duplicateWords(in: words3)
duplicateWords(in: words4)

