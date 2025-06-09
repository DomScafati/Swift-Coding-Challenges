import UIKit
/*
 Write a function that takes a square matrix (same number of rows and columns) and returns the sum of its two diagonals (primary and secondary).
 If a number is shared by both diagonals (like the center of a 3x3), only count it once.
 
 EXAMPLE:
 Input:
 [
  [1, 2, 3],
  [4, 5, 6],
  [7, 8, 9]
 ]

 Primary diagonal: 1 + 5 + 9 = 15
 Secondary diagonal: 3 + 5 + 7 = 15
 → But 5 is shared → Total: 15 + 15 - 5 = 25

 Output: 25
 */

func diagonalSum(_ matrix: [[Int]]) -> Int {
    let n = matrix.count
    var sum = 0

    for i in 0..<n {
        sum += matrix[i][i] // primary diagonal
        sum += matrix[i][n - i - 1] // secondary diagonal
    }

    // If n is odd, subtract the middle element once (it's counted twice)
    if n % 2 == 1 {
        sum -= matrix[n / 2][n / 2]
    }

    return sum
}

let matrixA = [
    [1, 2, 3],
    [4, 5, 6],
    [7, 8, 9]
]

print(diagonalSum(matrixA)) // 25 ✅
