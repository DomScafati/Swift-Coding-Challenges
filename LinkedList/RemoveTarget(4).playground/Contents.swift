import UIKit

// Given the head of a singly linked list, walk through each element
class Node {
    var value: Int
    var next: Node?
    
    init(value: Int, _ next: Node? = nil) {
        self.value = value
        self.next = next
    }
}

func walkThroughList(_ head: Node?) {
    var current = head
    var next: Node?
    
    while current != nil {
        print(current?.value)

        next = current?.next
        current = next
    }
}

let node7 = Node(value: 7)
let node6 = Node(value: 6, node7)
let node5 = Node(value: 5, node6)
let node4 = Node(value: 4, node5)
let node3 = Node(value: 3, node4)
let node2 = Node(value: 2, node3)
let node1 = Node(value: 1, node2)

walkThroughList(node1)
