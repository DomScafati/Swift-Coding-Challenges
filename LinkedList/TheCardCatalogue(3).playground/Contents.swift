import Foundation

// Linked List Challenge
//
// Phrases/patterns that signal "Linked List":
// "traverse a chain of nodes"              → follow .next until nil
// "find the middle of a sequence"          → slow/fast pointer
// "reverse the order of a chain"           → rewire .next pointers as you walk
// "process each node once"                 → single traversal with a current pointer

// The Ashford Library keeps its oldest records in a linked card
// catalogue — each card points to the next in the chain. The head
// librarian needs a few quick tools to query and manage the
// collection before the digital system arrives.


// MARK: - Shared types (do not modify)

class ListNode {
    var val: Int
    var next: ListNode?
    init(_ val: Int) { self.val = val }
}

// Builds a linked list from an array — [1, 2, 3] → 1 → 2 → 3
func makeList(_ vals: [Int]) -> ListNode? {
    guard !vals.isEmpty else { return nil }
    let head = ListNode(vals[0])
    var current = head
    for i in 1..<vals.count {
        current.next = ListNode(vals[i])
        current = current.next!
    }
    return head
}

// Converts a linked list back to an array for easy assertion
func listToArray(_ head: ListNode?) -> [Int] {
    var result = [Int]()
    var current = head
    while let node = current {
        result.append(node.val)
        current = node.next
    }
    return result
}


// ============================================================
// MARK: - Challenge 1 (The Count): Traverse and Count Nodes
// ============================================================
/*
 The head librarian needs to know how many cards are in the
 catalogue chain so she can order the right number of binders.

 Given the head of a linked list, return the total number of nodes.

 func countCards(_ head: ListNode?) -> Int

 Hint: keep a running count as you follow .next to nil.
*/

// MARK: Pre-defined (do not modify)

let catalogueA = makeList([4, 7, 2, 9, 1])
// expected: 5

// MARK: Your solution (Challenge 1)



// MARK: Tests (Challenge 1) — uncomment as you go

//assert(countCards(catalogueA) == 5)
//assert(countCards(makeList([1])) == 1)
//assert(countCards(nil) == 0)
//print("Challenge 1 passed!")


// ============================================================
// MARK: - Challenge 2 (The Middle Card): Find the Middle Node
// ============================================================
/*
 To split the catalogue in two for reorganisation, the librarian
 needs the middle card. For an even-length chain, return the
 second of the two middle nodes.

 Given the head of a linked list, return the value of the middle node.

 func middleCard(_ head: ListNode?) -> Int

 Hint: try moving two pointers through the list at different speeds.
*/

// MARK: Pre-defined (do not modify)

let catalogueB = makeList([3, 6, 9, 12, 15])
// expected: 9  (middle of 5 nodes)

let catalogueC = makeList([1, 2, 3, 4])
// expected: 3  (second of the two middle nodes)

// MARK: Your solution (Challenge 2)



// MARK: Tests (Challenge 2) — uncomment as you go

//assert(middleCard(catalogueB) == 9)
//assert(middleCard(catalogueC) == 3)
//assert(middleCard(makeList([5])) == 5)
//print("Challenge 2 passed!")


// ============================================================
// MARK: - Challenge 3 (Reverse the Shelf): Reverse a Linked List
// ============================================================
/*
 The archive room cards were shelved in the wrong order. The
 librarian needs the chain reversed so the last card comes first.

 Given the head of a linked list, return the head of the reversed list.

 func reverseShelf(_ head: ListNode?) -> ListNode?

 Hint: as you walk forward, think about what each node's .next
 needs to point to in the reversed version.
*/

// MARK: Pre-defined (do not modify)

let catalogueD = makeList([1, 2, 3, 4, 5])
// expected: [5, 4, 3, 2, 1]

// MARK: Your solution (Challenge 3)



// MARK: Tests (Challenge 3) — uncomment as you go

//assert(listToArray(reverseShelf(catalogueD)) == [5, 4, 3, 2, 1])
//assert(listToArray(reverseShelf(makeList([1, 2]))) == [2, 1])
//assert(listToArray(reverseShelf(makeList([7]))) == [7])
//assert(reverseShelf(nil) == nil)
//print("Challenge 3 passed!")
