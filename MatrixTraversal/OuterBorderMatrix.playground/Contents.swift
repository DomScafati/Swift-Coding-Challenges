import UIKit

/*
 Write a function that returns the outermost elements of a matrix in clockwise order, starting from the top-left corner.
 
 Input:
 [
  [1,  2,  3, 4],
  [5,  6,  7, 8],
  [9, 10, 11, 12]
 ]

 Output: [1, 2, 3, 4, 8, 12, 11, 10, 9, 5]

 */

func outerBorder(_ matrix: [[Int]]) -> [Int] {
    let totalSize = matrix[0].count * matrix.count
    var array = [Int]()
    var i = 0
    
    var leftIndex = 0
    var rightIndex = matrix[0].count - 1
    var topIndex = 0
    var bottomIndex = matrix.count - 1
    
    // you DONT want to go by total size, since we are actually excluding some values
//    while i < totalSize {
        for column in stride(from: leftIndex, through: rightIndex, by: 1) {
            // use 'column' insread of 'num', because it isn't the actual number, its the index OF the number
            array.append(matrix[topIndex][column])
        } // entrire first row
        
        
        for row in stride(from: topIndex + 1, through: bottomIndex, by: 1) {
            array.append(matrix[row][rightIndex])
        }// right row excluding what we already did (thats the +1)
        
        for column in stride(from: rightIndex - 1, through: leftIndex, by: -1) {
            array.append(matrix[bottomIndex][column])
        }// bottom row excluding wwhat we did
        
        for row in stride(from: bottomIndex - 1, through: topIndex + 1, by: -1) {
            array.append(matrix[row][leftIndex])
        }
//        i += 1
//    }
    
    return array
}

let matrixA = [
    [1, 2, 3],
    [4, 5, 6],
    [7, 8, 9]
]

let matrixB = [
    [1, 2, 3, 4],
    [5, 6, 7, 8],
    [9, 10, 11, 12],
    [13, 14, 15, 16],
]

let matrixC = [
[1,2,3],
[4,5,6]
]

let tmp = outerBorder(matrixA) // should exclude 5
let tmp2 = outerBorder(matrixB) // should exclude 6,7,10,11
let tmp3 = outerBorder(matrixC) // should include all values
