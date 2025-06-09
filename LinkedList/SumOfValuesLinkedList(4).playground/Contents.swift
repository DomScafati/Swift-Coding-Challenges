import UIKit
/*
 Write a function that returns the sum of all values in a singly linked list.
 */

class ListNode {
    var value: Int
    var next: ListNode?
    
    init(value: Int, next: ListNode? = nil) {
        self.value = value
        self.next = next
    }
}

func sumList(_ head: ListNode?) -> Int {
    var sum = 0
    
    // Use a temporary pointer to traverse the list
    var current = head

    // Loop until current is nil (we reach the end of the list)
    while current != nil {
        sum += current!.value          // Add current node’s value
        current = current!.next      // Move to the next node
    }

    return sum
}

let node1 = ListNode(value: 1, next: node2)
let node2 = ListNode(value: 1, next: node3)
let node3 = ListNode(value: 1)

let total = sumList(node1)
print(total)
