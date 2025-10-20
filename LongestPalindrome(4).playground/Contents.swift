import UIKit
/*
 Write a Swift function called longestPalindrome(_:) that takes a single string and returns the longest palindromic substring contained within it.
 */

func longestPalindrome(_ s: String) -> String {
    // Convert the input string to an array of characters for easier indexing
    let chars = Array(s)

    // Variables to track the starting index and max length of the longest palindrome
    var start = 0
    var maxLength = 0

    // This helper function expands from the center outward as long as characters match
    func expandAroundCenter(left: Int, right: Int) {
        var l = left
        var r = right

        // Expand while we're within bounds and characters are equal
        while l >= 0 && r < chars.count && chars[l] == chars[r] {
            // Update maxLength and start index if a longer palindrome is found
            if r - l + 1 > maxLength {
                start = l
                maxLength = r - l + 1
            }
            // Move outward from the center
            l -= 1
            r += 1
        }
    }

    // Loop through each character as a potential center
    for i in 0..<chars.count {
        // Consider odd-length palindromes (center at i)
        expandAroundCenter(left: i, right: i)

        // Consider even-length palindromes (center between i and i + 1)
        expandAroundCenter(left: i, right: i + 1)
    }

    // Extract the longest palindrome substring from the original string
    // Use start and maxLength to slice the character array and convert back to String
    return String(chars[start..<start + maxLength])
}

print(longestPalindrome("babad"))       // "bab" or "aba"
longestPalindrome("cbbd")        // "bb"
longestPalindrome("a")           // "a"
longestPalindrome("forgeeksskeegfor") // "geeksskeeg"
longestPalindrome("abcda")       // "a"
