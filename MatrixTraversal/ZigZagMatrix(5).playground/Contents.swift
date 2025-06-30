import UIKit

func zigZagTraversal(_ matrix: [[Int]]) -> [Int] {
    var result = [Int]()
    
    let left = 0
    let right = matrix[0].count - 1
    var top = 0
    let bottom = matrix.count - 1
    
    while top <= bottom {
        if top % 2 == 0 {
            // Even row → left to right
            var col = 0
            while col <= right {
                result.append(matrix[top][col])
                col += 1
            }
        } else {
            // Odd row → right to left
            var col = right
            while col >= left {
                result.append(matrix[top][col])
                col -= 1
            }
        }
        
        top += 1
    }
    
    return result
}

let matrix1 = [
    [1, 2, 3],
    [4, 5, 6],
    [7, 8, 9]
]

let matrix2 = [
    [1, 2, 3, 4],
    [5, 6, 7, 8]
]

let matrix3 = [
    [10, 20, 30]
]

let matrix4 = [
    [11],
    [22],
    [33]
]

print(zigZagTraversal(matrix1))
