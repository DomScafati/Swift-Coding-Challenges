import UIKit
/*
 Write a function that takes a 2D array (matrix) of integers and returns the sum of all elements in the matrix.
*/

func sumOfAllElements(_ matrix: [[Int]]) -> Int {
    var result = 0
    for row in matrix {
        for num in row {
            result += num
        }
    }
    
    return result
}

var matrix1 = [
    [1, 2, 3],
    [4, 5, 6],
    [7, 8, 9]
]

var matrix2 = [
    [1, 1, 2],
    [2, 3, 1]
]

var tmp = sumOfAllElements(matrix1) // should return 45
tmp = sumOfAllElements(matrix2) // should return 10
