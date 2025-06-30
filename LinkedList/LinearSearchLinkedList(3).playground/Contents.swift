import UIKit

/*
 Prompt:Write a function that checks whether a given value exists in a linked list. Return true if found, otherwise false.
 
 This is just like looping through an array and checking if a value matches — except you're using .next to move through the list instead of an index.
 */


class LinkedNode {
    var value: Int
    var next: LinkedNode?
    
    init(value: Int, next: LinkedNode? = nil) {
        self.value = value
        self.next = next
    }
}

func containsValue(head: LinkedNode?, _ target: Int) -> Bool {
    var current = head
    
    while current != nil {
        if current?.value == target {
            return true
        }
        current = current?.next
    }
    
    return false
}

let node4 = LinkedNode(value: 7)
let node3 = LinkedNode(value: 5, next: node4)
let node2 = LinkedNode(value: 3, next: node3)
let node1 = LinkedNode(value: 1, next: node2)

print(containsValue(head: node1, 5))  // true
print(containsValue(head: node1, 9))  // false
print(containsValue(head: nil, 3))    // false (empty list)
