import UIKit

var greeting = "Hello, playground"
let firstChar = greeting[greeting.startIndex] // H

let secondIndex = greeting.index(after: greeting.startIndex)
let secondChar = greeting[secondIndex]// E

let i = greeting.index(greeting.startIndex, offsetBy: 3)
let char = greeting[i]// L

func reverseString(string: String) -> String {
    var newString = ""
    
    var i = string.count - 1
    while i >= 0 {
        var index = string.index(string.startIndex, offsetBy: i)
        var char = string[index]
        newString += "\(char)"
        
        i -= 1
    }
    
    return newString
}

print(reverseString(string: greeting))

func findSubstring(string: String, target: String) -> Bool {
    
    var foundSubstring = ""
    
    if string.lowercased().contains(target.lowercased()) {
        return true
    }
    
    return false
}

print(findSubstring(string: "I am John Fart", target: "FaRt"))


