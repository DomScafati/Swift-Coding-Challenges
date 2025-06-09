import UIKit

/*
 Prompt:
 Given a string, return a dictionary showing how many times each character appears.
 Ignore case. Ignore whitespace.
 */

func characterFrequency(_ string: String) -> [Character: Int] {
    var dict: [Character: Int] = [:]
    var newString = string.lowercased().filter { $0.isLetter }
    
    for char in newString {
        dict[char, default: 0] += 1
    }
    
    return dict
}
