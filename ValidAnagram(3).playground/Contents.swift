import UIKit
/*
 Write a function to determine if two strings are anagrams of each other.
 Two strings are anagrams if they contain the same characters in the same counts, but in any order.
 */
var string1 = "Hello"
var string2 = "olleH"
var string3 = "sad"
var string4 = "sda"
var string5 = "yui"
var string6 = "i"

func isValidAnagram(_ string1: String, _ string2: String) -> Bool {
    let cleanedString1 = string1.lowercased().sorted()
    let cleanedString2 = string2.lowercased().sorted()
    if cleanedString1 == cleanedString2 {
        return true
    }
    return false
}

