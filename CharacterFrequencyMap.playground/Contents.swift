import UIKit

/*
 Prompt:
 Given a string, return a dictionary showing how many times each character appears.
 Ignore case. Ignore whitespace.
 */

func characterFrequency(_ string: String) -> [Character: Int] {
    var dict = [Character: Int]()
    
    for char in string {
        dict[char, default: 0] += 1
    }
    
    return dict
}

func reverseString(string: String) -> String {
    var newString = ""
    var index = string.index(before: string.endIndex)
    
    while true {
        newString.append(string[index])
        if index == string.startIndex {
            break
        }
        index = string.index(before: index)
    }
    
    return newString
}
