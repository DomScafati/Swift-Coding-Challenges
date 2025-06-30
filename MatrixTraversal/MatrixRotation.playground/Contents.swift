import UIKit

/*
 Write a function that rotates a square matrix 90 degrees clockwise in place.
 The number of rows will ALWAYS equal the number of collumns

 */

func rotateMatrix( matrix: inout [[Int]]) {

    
    // Define edges
    var left = 0
    var right = matrix[0].count - 1
    var top = 0
    var bottom = matrix.count - 1
    
    var newMatrix = Array(repeating: Array(repeating: 0, count: matrix[0].count), count: matrix.count)

    var lastNum = matrix[1][0]
    
    while top <= bottom {
        // FIRST, add every element to a dictionary with the value and the index
        var tmpNum = 0
        for col in stride(from: left, through: right, by: 1) {
            tmpNum = matrix[top][col]
            newMatrix[top][col] = lastNum
            lastNum = tmpNum
            
            print("row: \(top), column: \(col)")
//            newArray.append(matrix[top][col])
        }
        
        for row in stride(from: top + 1, through: bottom, by: 1) {
            tmpNum = matrix[row][right]
            newMatrix[row][right] = lastNum
            lastNum = tmpNum

        }
        
        for col in stride(from: right - 1, through: left, by: -1) {
            tmpNum = matrix[bottom][col]
            newMatrix[bottom][col] = lastNum
            lastNum = tmpNum
        }
        
        for row in stride(from: bottom - 1, through: top + 1, by: -1) {
            tmpNum = matrix[row][left]
            newMatrix[row][left] = lastNum
            lastNum = tmpNum
        }
        // Shrink
        left += 1
        right -= 1
        top += 1
        bottom -= 1
    }
    
    print(newMatrix)
}

var matrix1 = [
    [1, 2, 3],
    [4, 5, 6],
    [7, 8, 9]
]
rotateMatrix(matrix: &matrix1)
// matrix1 should now be:
// [
//  [7, 4, 1],
//  [8, 5, 2],
//  [9, 6, 3]
// ]

var matrix2 = [
    [5, 1],
    [9, 3]
]
// After rotation:
// [
//  [9, 5],
//  [3, 1]
// ]
