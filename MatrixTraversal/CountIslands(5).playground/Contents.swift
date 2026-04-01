import UIKit

/*
 You’re given a 2D matrix of 1s and 0s, where:
 1 represents land
 0 represents water

 An island is formed by connecting adjacent lands horizontally or vertically (not diagonally).
 Write a function that counts how many islands exist in the matrix.
*/

let grid = [
    [1, 1, 0, 0, 0],
    [1, 1, 0, 0, 1],
    [0, 0, 0, 1, 1],
    [0, 0, 0, 0, 0],
    [1, 0, 1, 0, 1]
] // expected 5

func numIslands(_ grid: [[Int]]) -> Int {
    // Make a mutable copy since we’ll mark cells as visited
    var grid = grid
    let rows = grid.count
    let cols = grid[0].count
    var count = 0
    
    // Helper function to "sink" connected land
    func dfs(_ r: Int, _ c: Int) {
        // Check bounds and ensure current cell is land
        guard r >= 0, r < rows, c >= 0, c < cols, grid[r][c] == 1 else { return }
        
        // Mark current cell as visited (sink the island)
        grid[r][c] = 0
        
        // Explore all 4 directions
        dfs(r + 1, c) // down
        dfs(r - 1, c) // up
        dfs(r, c + 1) // right
        dfs(r, c - 1) // left
    }
    
    // Traverse every cell in the matrix
    for r in 0..<rows {
        for c in 0..<cols {
            // Found an island — start sinking it
            if grid[r][c] == 1 {
                count += 1
                dfs(r, c)
            }
        }
    }
    
    return count
}
