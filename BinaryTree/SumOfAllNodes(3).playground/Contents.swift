import UIKit

/*
 Write a function that takes the root of a binary tree and returns the sum of all the values in the tree.
 Ex.
   10
  /   \
 5     15
/  \      \
2   7      20

 10 + 5 + 15 + 2 + 7 + 20 = 59
 */

class TreeNode {
    var value: Int
    var left: TreeNode?
    var right: TreeNode?
    
    init(_ value: Int) {
        self.value = value
    }
}

func sumOfNodes(_ root: TreeNode?) -> Int {
    var result = 0
    guard let root = root else {
        return 0
    }
    
    var queue: [TreeNode] = [root]
    
    while !queue.isEmpty {
        var current = queue.removeFirst()
        result += current.value
        
        if let left = current.left {
            queue.append(left)
        }
        
        if let right = current.right {
            queue.append(right)
        }
    }
    
    return result
}

let root = TreeNode(19)
root.left = TreeNode(5)
root.right = TreeNode(100)
root.left?.left = TreeNode(2)
root.left?.right = TreeNode(2)
root.right?.right = TreeNode(70)

print(sumOfNodes(root)) // 198
