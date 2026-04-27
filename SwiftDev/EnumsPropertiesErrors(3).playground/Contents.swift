import Foundation

// ============================================================
// MARK: - Challenge 1 (Easy): Enum Pattern Matching
// ============================================================
/*
 Task: You have a notification inbox represented as an array of Notification values.
 Use pattern matching and higher-order functions to query the inbox.

 Do NOT modify the Notification enum or the inbox array.
 You MAY write helper functions if you need them.

 Requirements:
 1. Extract all message bodies into a constant called messageBodies: [String]
 2. Filter alerts with priority >= 7 into a constant called urgentAlerts: [Notification]
 3. Count the number of reminders — store as reminderCount: Int
 4. Find the body of the first message sent from "Alice" — store as firstAliceMessage: String?
 */

// MARK: Pre-defined (do not modify)

enum Notification {
    case message(from: String, body: String)
    case alert(title: String, priority: Int)
    case reminder(title: String)
}

let inbox: [Notification] = [
    .message(from: "Alice", body: "Hey, are you free tomorrow?"),
    .alert(title: "Server Down", priority: 9),
    .message(from: "Bob", body: "Don't forget the meeting"),
    .reminder(title: "Buy groceries"),
    .alert(title: "Low Battery", priority: 3),
    .alert(title: "Critical Error", priority: 10),
    .reminder(title: "Call Mom"),
    .message(from: "Alice", body: "Never mind!")
]

// MARK: Your solution (Challenge 1)

let messageBodies: [String] = inbox.compactMap { notif -> String? in
    switch notif {
    case .message(let title, let body):
        return body
    default: return nil
    }
}

let urgentAlerts = inbox.filter { notif in
    switch notif {
    case .alert(let tilte, let priority):
        return priority >= 7 ? true : false
    default: return false
    }
}

var reminderCount: Int = 0
var firstAliceMessage: String = ""

inbox.forEach { notif in
    switch notif {
    case .message(let title, let body):
        if firstAliceMessage.isEmpty {
            firstAliceMessage = body
        }
    case .reminder(let title):
        reminderCount += 1
    default: break
    }
}

// MARK: Tests (Challenge 1) — uncomment as you go

 assert(messageBodies == ["Hey, are you free tomorrow?", "Don't forget the meeting", "Never mind!"])
 assert(urgentAlerts.count == 2) // "Server Down" (9) and "Critical Error" (10)
 assert(reminderCount == 2)
 assert(firstAliceMessage == "Hey, are you free tomorrow?")
 print("Challenge 1 passed!")


// ============================================================
// MARK: - Challenge 2 (Easy): Computed Properties
// ============================================================
/*
 Task: Extend the Product struct with computed properties.

 Do NOT modify the Product struct.
 You MUST use an extension to add the following:

 Requirements:
 - totalCost: Double     price * quantity
 - isInStock: Bool       true if quantity > 0
 - summary: String       formatted as "Name x[quantity] — $[totalCost]"
                         e.g. "Apples x3 — $4.47"
                         Hint: String(format: "%.2f", value) rounds to 2 decimal places
 */

// MARK: Pre-defined (do not modify)

struct Product {
    let name: String
    let price: Double
    let quantity: Int
}

let apples = Product(name: "Apples", price: 1.49, quantity: 3)
let milk   = Product(name: "Milk",   price: 2.99, quantity: 0)
let bread  = Product(name: "Bread",  price: 3.50, quantity: 2)

// MARK: Your solution (Challenge 2)

extension Product {
    var totalCost: Double {
        return self.price * Double(self.quantity)
    }
    
    var isInStock: Bool {
        return quantity > 0 ? true : false
    }
    
    var summary: String {
        let doubleString = String(format: "%.2f", self.totalCost)
        let str = "\(self.name) x\(self.quantity) — $\(doubleString)"
        return str
    }
}


// MARK: Tests (Challenge 2) — uncomment as you go

 assert(apples.totalCost == 4.47)
 assert(milk.isInStock == false)
 assert(bread.isInStock == true)
 assert(apples.summary == "Apples x3 — $4.47")
 assert(bread.summary == "Bread x2 — $7.00")
 print("Challenge 2 passed!")


// ============================================================
// MARK: - Challenge 3 (Intermediate): Custom Errors & Throwing Functions
// ============================================================
/*
 Task: Implement a simple bank account system with error handling.

 Do NOT modify BankAccount or BankError.
 You MUST implement the three throwing functions described below as free functions (not methods).

 Requirements:

 func deposit(amount: Double, into account: inout BankAccount) throws
   - Throws BankError.invalidAmount if amount <= 0
   - Otherwise adds amount to account.balance

 func withdraw(amount: Double, from account: inout BankAccount) throws
   - Throws BankError.invalidAmount if amount <= 0
   - Throws BankError.insufficientFunds if amount > account.balance
   - Otherwise subtracts amount from account.balance

 func transfer(amount: Double, from source: inout BankAccount, to destination: inout BankAccount) throws
   - Throws BankError.invalidAmount if amount <= 0
   - Throws BankError.insufficientFunds if source cannot cover the amount
   - Otherwise moves the amount from source to destination
   - Hint: you've already written the building blocks for this one
 */

// MARK: Pre-defined (do not modify)

struct BankAccount {
    let owner: String
    var balance: Double
}

enum BankError: Error {
    case insufficientFunds
    case invalidAmount
}

// MARK: Your solution (Challenge 3)
func deposit(amount: Double, into account: inout BankAccount) throws {
//    - Throws BankError.invalidAmount if amount <= 0
//    - Otherwise adds amount to account.balance
    if amount <= 0 {
        throw BankError.invalidAmount
    }
    
    account.balance += amount
}


func withdraw(amount: Double, from account: inout BankAccount) throws {
    //  - Throws BankError.invalidAmount if amount <= 0
    //  - Throws BankError.insufficientFunds if amount > account.balance
    //  - Otherwise subtracts amount from account.balance
    if amount <= 0 {
        throw BankError.invalidAmount
    } else if amount > account.balance {
        throw BankError.insufficientFunds
    }
    
    account.balance -= amount
}

func transfer(amount: Double, from source: inout BankAccount, to destination: inout BankAccount) throws {
//    - Throws BankError.invalidAmount if amount <= 0
//    - Throws BankError.insufficientFunds if source cannot cover the amount
//    - Otherwise moves the amount from source to destination
//    - Hint: you've already written the building blocks for this one
    if amount <= 0 {
        throw BankError.invalidAmount
    } else if source.balance < amount{
        throw BankError.insufficientFunds
    }
    
    source.balance -= amount
    destination.balance += amount
}

// MARK: Tests (Challenge 3) — uncomment as you go

 var savings  = BankAccount(owner: "Dom", balance: 100.0)
 var checking = BankAccount(owner: "Dom", balance: 50.0)

 try deposit(amount: 50.0, into: &savings)
 assert(savings.balance == 150.0)

 try withdraw(amount: 30.0, from: &checking)
 assert(checking.balance == 20.0)

 try transfer(amount: 100.0, from: &savings, to: &checking)
 assert(savings.balance == 50.0)
 assert(checking.balance == 120.0)

 do {
     try withdraw(amount: 999.0, from: &savings)
     assert(false, "Should have thrown")
 } catch BankError.insufficientFunds {
     print("Caught insufficientFunds — correct!")
 } catch {
     assert(false, "Wrong error type thrown")
 }

 do {
     try deposit(amount: -10.0, into: &savings)
     assert(false, "Should have thrown")
 } catch BankError.invalidAmount {
     print("Caught invalidAmount — correct!")
 } catch {
     assert(false, "Wrong error type thrown")
 }

 print("Challenge 3 passed!")
