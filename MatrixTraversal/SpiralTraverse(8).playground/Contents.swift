import UIKit
/*
 matrix traversal algorithm
 Given an m x n matrix, return all elements of the matrix in spiral order
 should return 1 2 3 6 9 8 7 4 5
 */

func spiralTraverse(_ matrix: [[Int]]) -> [Int] {
    var result = [Int]()
    
    // Total number of elements to collect (m * n)
    let rowCount = matrix[0].count
    let total = rowCount * matrix.count

    // Boundaries (we shrink them inward each spiral pass)
    var left = 0                        // Leftmost column index
    var top = 0                         // Topmost row index
    var right = matrix[0].count - 1    // Rightmost column index
    var bottom = matrix.count - 1      // Bottommost row index

    // Loop until we've collected all elements
    while result.count < total {
        // 1. Traverse left → right on the current top row
        // We include both ends, so we use `through`.
        for column in stride(from: left, through: right, by: 1) {
            result.append(matrix[top][column])
        }

        // 2. Traverse top ↓ bottom on the current rightmost column
        // We start from top+1 to avoid double-visiting the top-right corner
        for row in stride(from: top + 1, through: bottom, by: 1) {
            result.append(matrix[row][right])
        }

        // 3. Traverse right → left on the current bottom row
        // Only if there's more than one row remaining.
        if top < bottom {
            // Start from right-1 to avoid repeating bottom-right corner
            for column in stride(from: right - 1, through: left, by: -1) {
                result.append(matrix[bottom][column])
            }
        }

        // 4. Traverse bottom ↑ top on the current leftmost column
        // Only if there's more than one column remaining.
        if left < right {
            // Start from bottom-1 to avoid repeating bottom-left corner
            // End at top+1 to avoid repeating the top-left corner
            for row in stride(from: bottom - 1, through: top + 1, by: -1) {
                result.append(matrix[row][left])
            }
        }

        // Move inward to the next layer of the spiral
        left += 1
        top += 1
        right -= 1
        bottom -= 1
    }

    return result
}

func traverseInSpiral(_ matrix: [[Int]]) -> [Int] {
    var returnArray = [Int]()
    
    var leftIndex = 0
    var rightIndex = matrix[0].count - 1
    var topIndex = 0
    var bottomIndex = matrix.count - 1
    
    while leftIndex <= rightIndex && topIndex <= bottomIndex {
        // go left to right
        var lrIndex = leftIndex
        while lrIndex <= rightIndex {
            returnArray.append(matrix[topIndex][lrIndex])
            lrIndex += 1
        }
        
        // go top to bottom
        var tbIndex = topIndex + 1
        while tbIndex <= bottomIndex {
            returnArray.append(matrix[tbIndex][rightIndex])
            tbIndex += 1
        }
        
        if topIndex < bottomIndex {
            // go right to left
            var rlIndex = rightIndex - 1
            while rlIndex >= leftIndex {
                returnArray.append(matrix[bottomIndex][rlIndex])
                rlIndex -= 1
            }
        }
        
        
        if leftIndex < rightIndex {
            // go bottom to top
            var btIndex = bottomIndex - 1
            while btIndex >= topIndex {
                returnArray.append(matrix[btIndex][leftIndex])
                btIndex -= 1
            }
        }
       
        
        // shrink the matrix
        leftIndex += 1
        rightIndex -= 1
        topIndex += 1
        bottomIndex -= 1
    }
    
    return returnArray
}

var matrix1 = [
    [1, 2, 3],
    [4, 5, 6],
    [7, 8, 9]
    ]

var matrix2 = [
    [1, 2, 3],
    [4, 5, 6],
    [7, 8, 9],
    [10, 11, 12]
    ]

var matrix3 = [[1,2,3]]

var tmp = spiralTraverse(matrix1)
print(tmp)
tmp = spiralTraverse(matrix2)
