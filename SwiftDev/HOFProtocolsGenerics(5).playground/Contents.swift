import Foundation

// ============================================================
// MARK: - Challenge 1 (Intermediate): Custom Higher-Order Function
// ============================================================
/*
 Task: Implement a generic groupBy function and use it to analyse transactions.
 
 Do NOT modify the Transaction struct or the transactions array.
 You MAY write helper functions if you need them.
 
 Requirements:
 1. Implement: func groupBy<T, K: Hashable>(_ items: [T], by key: (T) -> K) -> [K: [T]]
 Groups items into a dictionary using the provided key closure.
 
 2. Use groupBy to produce transactionsByCategory: [String: [Transaction]]
 (group transactions by their category)
 
 3. Use transactionsByCategory to produce totalByCategory: [String: Double]
 (sum of amounts for each category — hint: mapValues + reduce)
 
 4. Find the category with the highest total — store as topCategory: String
 (hint: use max(by:) on the dictionary)
 */

// MARK: Pre-defined (do not modify)

struct Transaction {
    let id: Int
    let category: String
    let amount: Double
}

let transactions: [Transaction] = [
    Transaction(id: 1, category: "Food",      amount: 12.50),
    Transaction(id: 2, category: "Transport", amount:  8.00),
    Transaction(id: 3, category: "Food",      amount: 34.00),
    Transaction(id: 4, category: "Shopping",  amount: 59.99),
    Transaction(id: 5, category: "Transport", amount: 22.50),
    Transaction(id: 6, category: "Food",      amount: 18.75),
    Transaction(id: 7, category: "Shopping",  amount: 14.00),
]

// MARK: Your solution (Challenge 1)

func groupBy<T, K: Hashable>(_ items: [T], by key: (T) -> K) -> [K: [T]] {
    var dict = [K:[T]]()
    
    for item in items {
        dict[key(item), default: []].append(item)
    }
    
    return dict
}

var transactionsByCategory: [String: [Transaction]] = groupBy(transactions, by: { $0.category})

var totalByCategory: [String: Double] {
    var dict = [String: Double]()
    
    for (category, transactions) in transactionsByCategory {
        for transaction in transactions {
            dict[category, default: 0.0] += transaction.amount
        }
    }
    
    return dict
}

//4. Find the category with the highest total — store as topCategory: String
//   (hint: use max(by:) on the dictionary)

var topCategory: String? {
    return totalByCategory.max { $0.value < $1.value }?.key
}

// MARK: Tests (Challenge 1) — uncomment as you go

assert(transactionsByCategory["Food"]?.count == 3)
assert(transactionsByCategory["Transport"]?.count == 2)
assert(totalByCategory["Food"] == 65.25)
assert(topCategory == "Shopping")
print("Challenge 1 passed!")


// ============================================================
// MARK: - Challenge 2 (Intermediate): Protocols & Generics
// ============================================================
/*
 Task: Define a Scorable protocol and use it with a generic function.
 
 Do NOT modify the pre-defined types below.
 Use extensions to add protocol conformances — do not modify the structs directly.
 
 Requirements:
 1. Define a protocol Scorable with one requirement:
 var score: Int { get }
 
 2. Add a protocol extension providing two computed properties:
 var grade: String   — "A" (90+), "B" (80–89), "C" (70–79), "D" (60–69), "F" (below 60)
 var isPassing: Bool — true if score >= 60
 
 3. Conform ExamResult and AthleteRecord to Scorable via extensions:
 ExamResult.score  → maps to marks
 AthleteRecord.score → maps to rating
 
 4. Implement a generic function:
 func topScorers<T: Scorable>(_ items: [T], n: Int) -> [T]
 Returns the top n items sorted by score descending.
 If n >= items.count, return all items sorted by score descending.
 */

// MARK: Pre-defined (do not modify)

struct ExamResult {
    let name: String
    let marks: Int
}

struct AthleteRecord {
    let athlete: String
    let rating: Int
}

let examResults: [ExamResult] = [
    ExamResult(name: "Alice", marks: 92),
    ExamResult(name: "Bob",   marks: 75),
    ExamResult(name: "Carol", marks: 88),
    ExamResult(name: "Dan",   marks: 55),
]

let athletes: [AthleteRecord] = [
    AthleteRecord(athlete: "Finn",  rating: 91),
    AthleteRecord(athlete: "Grace", rating: 67),
    AthleteRecord(athlete: "Hank",  rating: 83),
]

// MARK: Your solution (Challenge 2)

protocol Scorable {
    var score:Int { get }
}

extension Scorable {
    var grade: String {
        switch score {
        case 90...100: return "A"
        case 80...89: return "B"
        case 70...79: return "C"
        case 60...69: return "D"
        default: return "F"
        }
    }
    
    var isPassing: Bool {
        if score >= 60 {
            return true
        } else {
            return false
        }
    }
}

extension ExamResult: Scorable {
    var score: Int {
        return marks
    }
}

extension AthleteRecord: Scorable {
    var score: Int {
        return rating
    }
}

func topScorers<T: Scorable>(_ items: [T], n: Int) -> [T] {
    var sorted = items.sorted(by: { $0.score > $1.score } )
    var newArray = [T]()
    
    for item in sorted.prefix(n) {
        newArray.append(item)
    }
    
    return newArray
}

// MARK: Tests (Challenge 2) — uncomment as you go

assert(examResults[0].grade == "A")       // 92
assert(examResults[1].grade == "C")       // 75
assert(examResults[3].isPassing == false) // 55
assert(athletes[1].grade == "D")          // 67
assert(athletes[1].isPassing == true)     // 67 >= 60

let topTwo = topScorers(examResults, n: 2)
assert(topTwo.map(\.name) == ["Alice", "Carol"])

let topAthletes = topScorers(athletes, n: 10) // n > count, return all sorted
assert(topAthletes.map(\.athlete) == ["Finn", "Hank", "Grace"])
print("Challenge 2 passed!")


// ============================================================
// MARK: - Challenge 3 (Intermediate): Generic Stack
// ============================================================
/*
 Task: Implement a generic Stack<T> data structure.
 
 Requirements:
 1. Implement a struct Stack<T> with:
 mutating func push(_ element: T)
 mutating func pop() -> T?    — removes and returns the top element; nil if empty
 func peek() -> T?            — returns the top element without removing; nil if empty
 var isEmpty: Bool
 var count: Int
 
 2. Conform Stack to CustomStringConvertible.
 List elements from bottom to top, marking the last with "(top)":
 "[1, 2, 3 (top)]"  — 3 is on top
 "[]"               — empty stack
 
 3. Conform Stack to Sequence so it can be used in a for-in loop (bottom-to-top).
 Hint: if your internal storage is an array, its iterator already does the job.
 */

// MARK: Your solution (Challenge 3)

struct Stack<T>: CustomStringConvertible {
    var description: String {
        if collection.isEmpty { return "[]" }
        let ordered = Array(collection.reversed())
        let parts = ordered.enumerated().map { (i, item) -> String in
            i == ordered.count - 1 ? "\(item) (top)" : "\(item)"
        }
        return "[\(parts.joined(separator: ", "))]"
    }
    
    var collection: [T] = []
    var isEmpty: Bool {
        return collection.isEmpty
    }
    var count: Int {
        return collection.count
    }
    
    mutating func push(_ element: T)  {
        collection.insert(element, at: 0)
    }
    
    mutating func pop() -> T? {
        let topElement = collection.first
        collection.removeFirst()
        return topElement
    }
    
    func peek() -> T? {
        return collection.first
    }
}


// MARK: Tests (Challenge 3) — uncomment as you go

 var stack = Stack<Int>()
 assert(stack.isEmpty)
 stack.push(1)
 stack.push(2)
 stack.push(3)
 assert(stack.count == 3)
 assert(stack.peek() == 3)
 assert(stack.pop () == 3)
 assert(stack.count == 2)
 assert(stack.description == "[1, 2 (top)]")
//
// var strStack = Stack<String>()
// strStack.push("a")
// strStack.push("b")
// assert(strStack.description == "[a, b (top)]")
//
// let doubled = stack.map { $0 * 2 }  // uses Sequence, iterates bottom-to-top
// assert(doubled == [2, 4])
 print("Challenge 3 passed!")
