import Foundation

// Binary Tree Challenge
//
// Phrases/patterns that signal "Binary Tree":
// "traverse all nodes in a tree"           → recursion: visit left, visit right
// "count / sum across the whole tree"      → recurse down both branches, combine results
// "how deep / tall is the tree"            → max depth = 1 + max(left depth, right depth)
// "process every node exactly once"        → recursive traversal hits each node once

// Historian Eleanor Voss is digitising the grand genealogy of the
// Aldric dynasty — a family tree stretching back twelve generations.
// Each ancestor is a node, branching left and right into their
// descendants. Eleanor needs a few tools to analyse the archive
// before it goes live.


// MARK: - Shared types (do not modify)

class TreeNode {
    var val: Int
    var left: TreeNode?
    var right: TreeNode?
    init(_ val: Int) { self.val = val }
}

//        8
//       / \
//      3   10
//     / \    \
//    1   6    14
//       / \   /
//      4   7 13

let root = TreeNode(8)
root.left        = TreeNode(3)
root.right       = TreeNode(10)
root.left?.left  = TreeNode(1)
root.left?.right = TreeNode(6)
root.left?.right?.left  = TreeNode(4)
root.left?.right?.right = TreeNode(7)
root.right?.right       = TreeNode(14)
root.right?.right?.left = TreeNode(13)


// ============================================================
// MARK: - Challenge 1 (Counting Descendants): Count All Nodes
// ============================================================
/*
 Eleanor needs a headcount of every person in the dynasty to
 size the printed archive correctly.

 Given the root of a binary tree, return the total number of nodes.

 func countDescendants(_ root: TreeNode?) -> Int

 Hint: a nil node contributes 0. Any other node contributes 1
 plus whatever its children contribute.
*/

// MARK: Your solution (Challenge 1)



// MARK: Tests (Challenge 1) — uncomment as you go

//assert(countDescendants(root) == 9)
//assert(countDescendants(TreeNode(1)) == 1)
//assert(countDescendants(nil) == 0)
//print("Challenge 1 passed!")


// ============================================================
// MARK: - Challenge 2 (The Sum of Ages): Sum All Node Values
// ============================================================
/*
 Each node value represents the year a dynasty member was born.
 Eleanor wants the total across all members as a checksum to
 verify the dataset imported correctly.

 Given the root of a binary tree, return the sum of all node values.

 func sumOfAges(_ root: TreeNode?) -> Int

 Hint: same shape as Challenge 1 — nil returns 0, otherwise
 combine the current value with both subtrees.
*/

// MARK: Your solution (Challenge 2)



// MARK: Tests (Challenge 2) — uncomment as you go

//assert(sumOfAges(root) == 66)  // 8+3+10+1+6+4+7+14+13
//assert(sumOfAges(TreeNode(5)) == 5)
//assert(sumOfAges(nil) == 0)
//print("Challenge 2 passed!")


// ============================================================
// MARK: - Challenge 3 (The Longest Line): Maximum Depth
// ============================================================
/*
 The dynasty's longest unbroken lineage determines how many
 columns the printed family tree needs. Find the maximum depth
 — the longest path from the root down to any leaf node.

 Given the root of a binary tree, return its maximum depth.
 A single node has depth 1. A nil tree has depth 0.

 func longestLineage(_ root: TreeNode?) -> Int

 Hint: the depth of any node is 1 plus the deeper of its two
 subtrees.
*/

// MARK: Your solution (Challenge 3)



// MARK: Tests (Challenge 3) — uncomment as you go

//assert(longestLineage(root) == 4)   // 8 → 3 → 6 → 4 (or 7), or 8 → 10 → 14 → 13
//assert(longestLineage(TreeNode(1)) == 1)
//assert(longestLineage(nil) == 0)
//print("Challenge 3 passed!")
