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
    var sum: Int = 0
    var current = head
    
    var i = 0
    while current != nil {
        i += 1
        print("iteration \(i)")
        sum += current?.value ?? 0
        current = current?.next
    }
    
    return sum
}
let node3 = ListNode(value: 1)
let node2 = ListNode(value: 1, next: node3)
let node1 = ListNode(value: 1, next: node2)

let total = sumList(node1)
print(total)
