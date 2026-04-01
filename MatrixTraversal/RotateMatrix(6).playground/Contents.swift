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
func rotateMatrix(_ matrix: inout [[Int]]) {
    let n = matrix.count
    guard n > 1 else { return } // nothing to rotate if 1x1
    
    // We’ll rotate one "layer" (or ring) at a time
    var top = 0
    var bottom = n - 1
    var left = 0
    var right = n - 1
    
    // Each iteration handles one outer layer, moving inward
    while left < right && top < bottom {
        // The number of elements to rotate per side (one less than layer width)
        let offsetCount = right - left
        
        // Loop through each element in this ring (except the last one, which closes the loop)
        for i in 0..<offsetCount {
            // Save the top-left value (it will get overwritten first)
            let topLeft = matrix[top][left + i]
            
            // Move bottom-left → top-left
            matrix[top][left + i] = matrix[bottom - i][left]
            
            // Move bottom-right → bottom-left
            matrix[bottom - i][left] = matrix[bottom][right - i]
            
            // Move top-right → bottom-right
            matrix[bottom][right - i] = matrix[top + i][right]
            
            // Move saved top-left → top-right
            matrix[top + i][right] = topLeft
        }
        
        // Move inward to the next layer
        top += 1
        bottom -= 1
        left += 1
        right -= 1
    }
}
