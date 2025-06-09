import UIKit

/*
 Write a function that takes a matrix of integers and counts how many "peaks" exist.

 A peak is defined as an element that is strictly greater than all of its adjacent neighbors (up, down, left, right).
 
 FIRST loop through each row
 THEN WHILE looping, check the value of each element around the current index AND IF it is a peak
 THEN put it in a dictionary witha  bool value determining if it is peak or not
 
 [
 1, 2, 3,
 4, 5, 6,
 7, 8, 9,
 ]
 */



func findPeakNumbers(array: [[Int]]) -> Int {
    var totalPeaks = 0
    
    // capturing the index and value of surrounding numbers
    
    var topIndex = 0
    var bottomIndex = array.count - 1
    var i = 0
    while topIndex <= bottomIndex {
        
        var leftIndex = 0
        var rightIndex = array[0].count - 1

        while leftIndex <= rightIndex {
            // check boundaries for a value existing at all
            var surroundingValues = [Int]()
            
            if leftIndex > 0 {
                surroundingValues.append(array[topIndex][leftIndex - 1])
            }
            
            if leftIndex < array[0].count - 1 {
                surroundingValues.append(array[topIndex][leftIndex + 1])
            }
            
            if topIndex > 0 {
                surroundingValues.append(array[topIndex - 1][leftIndex])
            }
            
            if topIndex < array.count - 1 {
                surroundingValues.append(array[topIndex + 1][leftIndex])
            }
            print("row \(topIndex) column \(leftIndex): surrounding values: \(surroundingValues)")
            
            if isGreaterThanList(array: surroundingValues, currentNum: array[topIndex][leftIndex]) {
                totalPeaks += 1
            }
            leftIndex += 1
        }
        
        
        topIndex += 1
    }
    
    
    
    return totalPeaks
}

func isGreaterThanList(array: [Int], currentNum: Int) -> Bool {
    for num in array {
        if num > currentNum {
            return false
        }
    }
    return true
}

let matrix1 = [
    [1, 2, 3],
    [5, 6, 1],
    [0, 4, 9]
]
// Peaks: 3 (top-right), 6 (center), 9 (bottom-right)
// ✅ Expected Output: 3

let matrix2 = [
    [9, 8],
    [7, 6]
]
// Peak: 9 (top-left)
// ✅ Expected Output: 1

let matrix3 = [
    [1, 2, 1],
    [2, 1, 2],
    [1, 2, 1]
]
// No peaks: all values are surrounded by equal or higher numbers
// ✅ Expected Output: 0
// Chat got this incorrect, 2 is a peak number by the definition above, should return 4.


print(findPeakNumbers(array: matrix1))
print(findPeakNumbers(array: matrix2))
print(findPeakNumbers(array: matrix3))


