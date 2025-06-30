import UIKit
/*
 NOTE: INCOMPLETE
prompt:
Given an n x n 2D matrix of integers, rotate the matrix in-place by 90 degrees clockwise.
 
 example:
 Input:
 [
  [1, 2, 3],
  [4, 5, 6],
  [7, 8, 9]
 ]

 Output:
 [
  [7, 4, 1],
  [8, 5, 2],
  [9, 6, 3]
 ]
 
 */

var matrix1 = [
    [1, 2, 3], [4, 5, 6], [7, 8, 9]
]

func rotateMatrix(_ matrix: [[Int]]) -> [[Int]] {
    var newMatrix = [[Int]]()

    // find the edges
    var leftIndex = 0
    var rightIndex = matrix.first!.count - 1
    var topIndex = 0
    var bottomIndex = matrix.count - 1
    
    var totalElements =  matrix.first!.count * matrix.count
    
    while newMatrix.count < totalElements {
        
        for collumn in stride(from: leftIndex, through: rightIndex, by: 1) {
            newMatrix.app
        }
        tmp1 += 1
        leftIndex += 1
        rightIndex -= 1
        topIndex += 1
        bottomIndex += 1
    }
    
    return newMatrix
}

var tmp = rotateMatrix(matrix1)
