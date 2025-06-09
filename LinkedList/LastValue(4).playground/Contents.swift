import UIKit

class LinkedNode {
    let value: Int
    let next: LinkedNode?
    
    init(value: Int, next: LinkedNode? = nil) {
        self.value = value
        self.next = next
    }
}

func lastValueInList(_ head: LinkedNode?) -> Int? {
    var returnValue: Int?
    var current = head
    
    while current != nil {
        returnValue = current!.value
        current = current?.next
    }
    
    return returnValue
}

let node4 = LinkedNode(value: 2)
let node3 = LinkedNode(value: 12, next: node4)
let node2 = LinkedNode(value: 4, next: node3)
let node1 = LinkedNode(value: 1, next: node2)

let tmp = lastValueInList(node1)
