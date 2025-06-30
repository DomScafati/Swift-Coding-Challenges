import UIKit
/*
 🧠 Challenge: Reverse a Singly Linked List
 Write a function that reverses a singly linked list.
 Return the new head of the reversed list.
 
 Input:  1 → 2 → 3 → 4 → nil
 Output: 4 → 3 → 2 → 1 → nil
 
 */

class LinkedNode {
    var value: Int
    var next: LinkedNode?
    
    init(value: Int, next: LinkedNode? = nil) {
        self.value = value
        self.next = next
    }
}

func reverseList(_ head: LinkedNode?) -> LinkedNode? {
    var prev: LinkedNode? = nil
    var current = head
    while current != nil {
        let next = current?.next     // Step 1: Save next node
        current?.next = prev         // Step 2: Reverse current’s pointer
        prev = current               // Step 3: Move prev forward
        current = next               // Step 4: Move current forward
    }
    
    return prev
}

let node4 = LinkedNode(value: 4)
let node3 = LinkedNode(value: 3, next: node4)
let node2 = LinkedNode(value: 2, next: node3)
let node1 = LinkedNode(value: 1, next: node2)

if let reversed = reverseList(node1) {
    var current = reversed
    while true {
        print(current.value)
        if let next = current.next {
            current = next
        } else {
            break
        }
    }
}
// Expected Output: 4, 3, 2, 1
