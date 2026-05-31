import Foundation

// Matrix Traversal Challenge
//
// Phrases/patterns that signal "Matrix Traversal":
// "sum / count across all cells"           → nested loop, visit every cell
// "find the row/column with the most"      → sum each row/column, track best
// "how many cells satisfy a condition"     → nested loop with a conditional count
// "grid of values, analyse the terrain"    → row-by-row or cell-by-cell traversal

// Korova City never sleeps. Ghost is a freelance data thief hired to
// crack Helix Corp's encrypted grid. Each cell holds a node value
// representing a fragment of stolen code. Before she can extract
// anything, she needs to map the terrain fast — ICE is already
// closing in.


// ============================================================
// MARK: - Challenge 1 (Full Sweep): Sum All Values in the Grid
// ============================================================
/*
 Ghost needs the total data payload across every node in the grid
 to know if the haul is worth the risk.

 Given a 2D array of integers, return the sum of all values.

 func totalPayload(_ grid: [[Int]]) -> Int

 Hint: one loop for rows, one for columns inside it.
*/

// MARK: Pre-defined (do not modify)

let gridA = [
    [3, 1, 4],
    [1, 5, 9],
    [2, 6, 5]
]
// expected: 36

// MARK: Your solution (Challenge 1)



// MARK: Tests (Challenge 1) — uncomment as you go

//assert(totalPayload(gridA) == 36)
//assert(totalPayload([[1, 2], [3, 4]]) == 10)
//assert(totalPayload([[0]]) == 0)
//print("Challenge 1 passed!")


// ============================================================
// MARK: - Challenge 2 (The Hot Zone): Highest-Sum Row
// ============================================================
/*
 The most densely packed row is where Ghost should jack in first —
 it holds the richest data. Find which row has the highest total
 value and return its index.

 Given a 2D array, return the index of the row with the highest sum.
 You can assume there is always one clear winner.

 func hotZone(_ grid: [[Int]]) -> Int

 Hint: sum each row and keep track of which index produced the best.
*/

// MARK: Pre-defined (do not modify)

let gridB = [
    [1, 2, 3],
    [9, 8, 7],
    [4, 5, 6]
]
// row sums: 6, 24, 15 — expected: 1

// MARK: Your solution (Challenge 2)



// MARK: Tests (Challenge 2) — uncomment as you go

//assert(hotZone(gridB) == 1)
//assert(hotZone([[5, 5], [1, 1], [3, 9]]) == 2)
//assert(hotZone([[1]]) == 0)
//print("Challenge 2 passed!")


// ============================================================
// MARK: - Challenge 3 (The Filter): Count Cells Above Threshold
// ============================================================
/*
 Ghost's scanner flags any node with a value above a certain
 encryption threshold — those are the high-value targets.
 Count how many cells in the grid exceed the threshold.

 Given a 2D array and a threshold, return the number of cells
 whose value is strictly greater than the threshold.

 func hotNodes(_ grid: [[Int]], threshold: Int) -> Int

 Hint: same nested loop as before, just add a condition.
*/

// MARK: Pre-defined (do not modify)

let gridC = [
    [1, 8, 3],
    [7, 2, 9],
    [4, 6, 5]
]
// cells above 5: 8, 7, 9, 6 — expected: 4

// MARK: Your solution (Challenge 3)



// MARK: Tests (Challenge 3) — uncomment as you go

//assert(hotNodes(gridC, threshold: 5) == 4)
//assert(hotNodes(gridC, threshold: 9) == 0)
//assert(hotNodes(gridC, threshold: 0) == 9)
//assert(hotNodes([[1, 1], [1, 1]], threshold: 1) == 0)  // strictly greater
//print("Challenge 3 passed!")
