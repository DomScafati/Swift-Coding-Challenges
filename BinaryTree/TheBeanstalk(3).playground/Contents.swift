import Foundation

// Binary Tree Challenge
//
// Phrases/patterns that signal "Binary Tree":
// "a node with no children"                → leaf: both left and right are nil
// "largest / smallest value in the tree"   → compare the node with the best of each subtree
// "path from the root down to a leaf"      → recurse down, carrying what is left to find
// "is there any path that ..."             → recurse down both sides, true if either works
// "for every node in the tree"             → recursive traversal hits each node once

// A giant beanstalk grows above the village. Every junction on it holds
// a number of golden beans, and every junction splits into at most two
// branches: a left one and a right one. Pip the climber is surveying
// the stalk before the harvest.


// MARK: - Shared types (do not modify)

class TreeNode {
    var val: Int
    var left: TreeNode?
    var right: TreeNode?
    init(_ val: Int) { self.val = val }
}

//          5
//        /   \
//       8     4
//      / \     \
//     2   9     6
//        /     / \
//       3     1   7

let stalk = TreeNode(5)
stalk.left        = TreeNode(8)
stalk.right       = TreeNode(4)
stalk.left?.left  = TreeNode(2)
stalk.left?.right = TreeNode(9)
stalk.left?.right?.left  = TreeNode(3)
stalk.right?.right       = TreeNode(6)
stalk.right?.right?.left  = TreeNode(1)
stalk.right?.right?.right = TreeNode(7)


// ============================================================
// MARK: - Challenge 1 (The Tips): Count the Leaves
// ============================================================
/*
 Pip wants to count only the branch tips of the stalk, not every
 junction. A tip is the very end of a branch: a junction with nothing
 growing out of it (no left child and no right child). A junction that
 still has a branch growing out of it is NOT a tip, so it is not
 counted.

 Given the root of a binary tree, return how many of its nodes are tips
 (leaves). Edge cases: a tree that is just one node with no children
 has exactly one tip (that node), and an empty tree has none.

 In the stalk drawn above, the tips are 2, 3, 1 and 7. The junctions
 5, 8, 4, 9 and 6 each have something growing out of them, so they
 don't count.

 func countTips(_ root: TreeNode?) -> Int

 Hint: decide what a tip itself returns, then let every other
 junction rely on the answers from its two branches.
*/

// MARK: Your solution (Challenge 1)

func countTips(_ root: TreeNode?) -> Int {

    guard let current = root else { return 0 }
    
    if current.left == nil && current.right == nil { return 1 }
    
    return countTips(current.left) + countTips(current.right)
}

// MARK: Tests (Challenge 1) — uncomment as you go

assert(countTips(stalk) == 4)              // tips are 2, 3, 1, 7 (the 9 has a child, so it is not a tip)
assert(countTips(stalk.left) == 2)         // left half: 2 and 3
assert(countTips(stalk.right?.right) == 2) // 6 splits into 1 and 7
assert(countTips(TreeNode(5)) == 1)        // a lone node is a leaf
assert(countTips(nil) == 0)
print("Challenge 1 passed!")


// ============================================================
// MARK: - Challenge 2 (The Richest Junction): Largest Value
// ============================================================
/*
 Pip wants to find the junction holding the most beans, so the
 harvest can start there.

 Given the root of a binary tree, return the largest value in it.
 Every value is positive. An empty tree returns 0.

 func mostBeans(_ root: TreeNode?) -> Int

 Hint: the best value in a tree is either the root's own value or
 the best value found in one of its two subtrees.
*/

// MARK: Your solution (Challenge 2)

func mostBeans(_ root: TreeNode?) -> Int {
    guard let current = root else { return 0 }
    var left = mostBeans(current.left)
    var right = mostBeans(current.right)
    return max(left, right, current.val)
}


// MARK: Tests (Challenge 2) — uncomment as you go

assert(mostBeans(stalk) == 9)              // 9 sits in the middle of the left side
assert(mostBeans(stalk.right) == 7)        // 4 → 6 → 7 is the richest on the right
assert(mostBeans(stalk.left?.left) == 2)  // a single tip
assert(mostBeans(TreeNode(5)) == 5)
assert(mostBeans(nil) == 0)
print("Challenge 2 passed!")


// ============================================================
// MARK: - Challenge 3 (The Golden Climb): Root-to-Tip Path Sum
// ============================================================
/*
 Pip is looking for a climb that starts at the root, follows branches
 downward and ends at a tip, collecting exactly `target` beans along
 the way (every junction on the climb counts, including the first
 and the last).

 Given the root of a binary tree and a target, return true if some
 root-to-leaf path has values adding up to exactly `target`.
 The climb must end at a tip: stopping at a junction that still has
 branches does not count. An empty tree has no climbs, so it is false.

 func hasGoldenClimb(_ root: TreeNode?, target: Int) -> Bool

 Hint: as you move down, think about how many beans are still
 left to find.
*/

// MARK: Your solution (Challenge 3)

func hasGoldenClimb(_ root: TreeNode?, target: Int) -> Bool {
    // Empty tree: no climb exists
    guard let current = root else { return false }

    // How many beans are still needed after taking this junction
    let remaining = target - current.val

    // A tip: the climb ends here, so it works only if nothing is left to find
    if current.left == nil && current.right == nil {
        return remaining == 0
    }

    // Not a tip: the climb works if either side can find the remaining amount
    return hasGoldenClimb(current.left, target: remaining)
        || hasGoldenClimb(current.right, target: remaining)
}

// MARK: Tests (Challenge 3) — uncomment as you go

assert(hasGoldenClimb(stalk, target: 15) == true)   // 5 + 8 + 2, the left-most climb
assert(hasGoldenClimb(stalk, target: 25) == true)   // 5 + 8 + 9 + 3
assert(hasGoldenClimb(stalk, target: 16) == true)   // 5 + 4 + 6 + 1
assert(hasGoldenClimb(stalk, target: 22) == true)   // 5 + 4 + 6 + 7, the right-most climb
assert(hasGoldenClimb(stalk, target: 13) == false)  // 5 + 8 reaches 13, but 8 is not a tip
assert(hasGoldenClimb(stalk, target: 100) == false)
assert(hasGoldenClimb(TreeNode(7), target: 7) == true)
assert(hasGoldenClimb(TreeNode(7), target: 5) == false)
assert(hasGoldenClimb(nil, target: 0) == false)
print("Challenge 3 passed!")


/*
 TIPS: here is the general pattern for working with binary trees
 
 func solve(_ root: TreeNode?) -> Result {
     // SLOT 1: base case, the answer for "nothing here"
     guard let node = root else { return BASE }

     // Ask each side for its answer (this part never changes)
     let left  = solve(node.left)
     let right = solve(node.right)

     // SLOT 2 + 3: combine this node's own contribution with the two answers
     return COMBINE(node's own value, left, right)
 }
 
 Only the BASE and the COMBINE ever change
 */
