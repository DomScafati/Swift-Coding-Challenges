import UIKit

/*
 Prompt:
 Given an sorted array of integers, return the length of the longest consecutive elements sequence.
 */


let array1: [Int] = [1,2,3,4, 9, 100] // should return 4
let array2: [Int] = [5, 3, 5, 7] // should return 1

func longestConsecutiveSequence(_ collection: [Int]) -> Int {
    var longest = 1
    var previous: Int?
    var possibleLongest = 1
    
    for num in collection {
        if let validPrevious = previous,
           validPrevious + 1 == num {
            possibleLongest += 1
            print("Possible longests incremented: \(possibleLongest)")
        } else {
            
            if possibleLongest > longest {
                longest = possibleLongest
            }
            
            possibleLongest = 1
            print("Longest:\(longest)")
        }
        
        previous = num
    }
    
    return longest
}

func longestConsecutiveSequenceUnsorted(_ collection: [Int]) -> Int{
    let orderedCollection = collection.sorted()
    var longest = 0
    
    
    
    return longest
}
//print(longestConsecutiveSequence(array1))
print(longestConsecutiveSequence(array2))
