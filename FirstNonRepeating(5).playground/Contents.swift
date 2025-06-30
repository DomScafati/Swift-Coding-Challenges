import UIKit
/*
 Prompt
 Write a function that takes a string and returns the first non-repeating character in it. If all characters repeat, return nil.

 Ignore casing ("A" == "a"), but return the original case in the result.
 */

func firstNonRepeatingCharacter(_ str: String) -> Character? {
    var counts: [Character: Int] = [:]

    // First pass: count lowercased characters
    for char in str {
        let lower = Character(char.lowercased())
        counts[lower, default: 0] += 1
    }

    // Second pass: find first character whose lowercase form appears only once
    for char in str {
        let lower = Character(char.lowercased())
        if counts[lower] == 1 {
            return char // Return with original case
        }
    }

    return nil
}

let s1 = "hello" // should return h
let s2 = "hhhh" // should return nil
let s3 = "nnlliio" // should return o

print(firstNonRepeatingCharacter(s1))
print(firstNonRepeatingCharacter(s2))
print(firstNonRepeatingCharacter(s3))

