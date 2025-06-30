import UIKit
/*
 Write a function that returns the total number of nodes in a singly linked list.
 */
class LinkedNode {
    let value: Int
    let next: LinkedNode?
    
    init(value: Int, next: LinkedNode? = nil) {
        self.value = value
        self.next = next
    }
}

func numberOfNodes(_ head: LinkedNode) -> Int {
    var sum = 0
    var current = head
    
    while current != nil {
        sum += 1
        current = current.next!
    }
    
    return sum
}


let node4 = LinkedNode(value: 1)
let node3 = LinkedNode(value: 1, next: node4)
let node2 = LinkedNode(value: 1, next: node3)
let node1 = LinkedNode(value: 1, next: node2)

let tmp = numberOfNodes(node1)
print(tmp)
