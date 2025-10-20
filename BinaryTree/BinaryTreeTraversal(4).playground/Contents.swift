import UIKit

/*
 traversing a binary tree
 this is a level order or breadth-first search, meaning it goes level by level.
 */

// Define a tree node class
class TreeNode {
    var value: Int
    var left: TreeNode?
    var right: TreeNode?
    
    init(_ value: Int) {
        self.value = value
    }
}

func levelOrderTraversal(_ root: TreeNode?) {
    // ensure the tree isn't empty
    guard let root = root else {
        return
    }
    
    // use FIFO array to keep order of tree and its associated nodes
    var stack: [TreeNode] = [root]
    
    // continue looping until there are no more nodes
    while !stack.isEmpty {
        // remove first node from stack
        let current = stack.removeFirst()
        print(current.value)
        
        // add the left child to the stack if it exists
        if let leftChild = current.left {
            stack.append(leftChild)
        }
        
        // same with right
        if let rightChild = current.right {
            stack.append(rightChild)
        }
    }
}

// MARK: - Example usage

// Build a small sample tree
let root = TreeNode(10)
root.left = TreeNode(5)
root.right = TreeNode(15)
root.left?.left = TreeNode(2)
root.left?.right = TreeNode(7)
root.right?.right = TreeNode(20)

// Run the traversal
levelOrderTraversal(root)
