import Foundation

// Stacks Challenge
//
// Phrases/patterns that signal "Stack":
// "last in, first out"                     → stack: push to add, pop to remove
// "reverse the order of a sequence"        → push everything, then pop it all
// "validate opening and closing pairs"     → push opens, pop and match on closes
// "undo / backtrack to the last state"     → stack stores previous states

// The starship Nebula-7 runs on a stack-based command processor.
// Every operation — from navigation to life support — is queued
// and executed in strict last-in, first-out order. One wrong
// command and the ship tumbles into the void.


// ============================================================
// MARK: - Challenge 1 (Boot Sequence): Implement a Stack
// ============================================================
/*
 Before any mission commands can run, the processor needs its
 core data structure. Build a generic Stack that the rest of
 the challenges will use.

 Implement a generic struct Stack<T> with:
   - mutating func push(_ value: T)  — add to the top
   - mutating func pop() -> T?       — remove and return the top, nil if empty
   - func peek() -> T?               — return the top without removing, nil if empty
   - var isEmpty: Bool               — true if the stack has no elements

 Hint: a private array where you always add and remove from the same end
 is all you need.
*/

// MARK: Your solution (Challenge 1)



// MARK: Tests (Challenge 1) — uncomment as you go

//var stack = Stack<Int>()
//assert(stack.isEmpty == true)
//stack.push(1)
//stack.push(2)
//stack.push(3)
//assert(stack.peek() == 3)
//assert(stack.pop() == 3)
//assert(stack.pop() == 2)
//assert(stack.isEmpty == false)
//assert(stack.pop() == 1)
//assert(stack.isEmpty == true)
//assert(stack.pop() == nil)
//print("Challenge 1 passed!")


// ============================================================
// MARK: - Challenge 2 (Reverse Thrust): Reverse a Sequence
// ============================================================
/*
 The navigation log recorded a sequence of thruster pulses in
 the wrong order. The flight computer needs them reversed before
 replaying them.

 Given an array of integers, return a new array with the elements
 in reverse order. Use your Stack from Challenge 1 — push
 everything in, then pop it all out.

 func reverseSequence(_ commands: [Int]) -> [Int]

 Hint: what order does a stack return elements compared to how
 you put them in?
*/

// MARK: Pre-defined (do not modify)

let thrusterLog = [1, 2, 3, 4, 5]
// expected: [5, 4, 3, 2, 1]

// MARK: Your solution (Challenge 2)



// MARK: Tests (Challenge 2) — uncomment as you go

//assert(reverseSequence(thrusterLog) == [5, 4, 3, 2, 1])
//assert(reverseSequence([7]) == [7])
//assert(reverseSequence([]) == [])
//print("Challenge 2 passed!")


// ============================================================
// MARK: - Challenge 3 (System Check): Validate Balanced Brackets
// ============================================================
/*
 Every command block on the Nebula-7 is wrapped in brackets.
 Before execution, the system checks that every opening bracket
 has a matching closing bracket in the right order.

 Given a string of brackets, return true if every opening bracket
 is correctly closed. The valid pairs are: () [] {}

 func systemCheck(_ commands: String) -> Bool

 Hint: push every opening bracket. When you see a closing bracket,
 pop the stack and check if it matches.
*/

// MARK: Pre-defined (do not modify)

let validCommand   = "{[()]}"   // expected: true
let invalidCommand = "{[(])}"   // expected: false
let emptyCommand   = ""         // expected: true

// MARK: Your solution (Challenge 3)



// MARK: Tests (Challenge 3) — uncomment as you go

//assert(systemCheck(validCommand)   == true)
//assert(systemCheck(invalidCommand) == false)
//assert(systemCheck(emptyCommand)   == true)
//assert(systemCheck("((()))") == true)
//assert(systemCheck("(]")     == false)
//assert(systemCheck("([)")    == false)
//print("Challenge 3 passed!")
