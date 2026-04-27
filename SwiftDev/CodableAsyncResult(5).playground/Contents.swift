import Foundation
import PlaygroundSupport

PlaygroundPage.current.needsIndefiniteExecution = true

// ============================================================
// MARK: - Challenge 1 (Intermediate): Codable & JSON Decoding
// ============================================================
/*
 Task: Decode a JSON payload into Swift structs.

 Do NOT modify jsonData.

 Requirements:
 1. Define a struct Address: Codable with these properties:
      street: String
      city: String
      postalCode: String
    The JSON uses snake_case — add a CodingKeys enum to map:
      "postal_code" → postalCode
      (street and city match exactly, still include them in CodingKeys)

 2. Define a struct UserProfile: Codable with these properties:
      userId: Int
      fullName: String
      email: String
      isPremium: Bool
      address: Address
    Add a CodingKeys enum to map:
      "user_id"    → userId
      "full_name"  → fullName
      "is_premium" → isPremium
      (email and address match exactly, still include them in CodingKeys)

 3. Decode jsonData into a constant called profile: UserProfile.
    Use try! JSONDecoder().decode(UserProfile.self, from: jsonData)
 */

// MARK: Pre-defined (do not modify)

let jsonData = Data("""
{
  "user_id": 7,
  "full_name": "Maya Chen",
  "email": "maya@example.com",
  "is_premium": true,
  "address": {
    "street": "42 Maple Ave",
    "city": "Toronto",
    "postal_code": "M5V 2T6"
  }
}
""".utf8)

// MARK: Your solution (Challenge 1)



// MARK: Tests (Challenge 1) — uncomment as you go

// assert(profile.userId == 7)
// assert(profile.fullName == "Maya Chen")
// assert(profile.isPremium == true)
// assert(profile.address.city == "Toronto")
// assert(profile.address.postalCode == "M5V 2T6")
// print("Challenge 1 passed!")


// ============================================================
// MARK: - Challenge 2 (Intermediate): async/await
// ============================================================
/*
 Task: Fetch two pieces of data in parallel and combine them.

 Do NOT modify the pre-defined functions or struct.

 Requirements:
 1. Implement: func loadPlayerSummary(id: Int) async -> PlayerSummary
    - Fetch name and score at the same time using async let (not one after the other)
    - Compute rank: "Gold" if score >= 90, "Silver" if score >= 70, otherwise "Bronze"
    - Return a PlayerSummary with name, score, and rank

 Note — async let syntax:
   async let a = someAsyncFunc()
   async let b = otherAsyncFunc()
   let (x, y) = await (a, b)   // kicks off both, then waits for both to finish
 */

// MARK: Pre-defined (do not modify)

struct PlayerSummary {
    let name: String
    let score: Int
    let rank: String
}

func fetchPlayerName(id: Int) async -> String {
    try? await Task.sleep(nanoseconds: 100_000_000)
    return [1: "Aria", 2: "Leo", 3: "Zoe"][id] ?? "Unknown"
}

func fetchPlayerScore(id: Int) async -> Int {
    try? await Task.sleep(nanoseconds: 100_000_000)
    return [1: 94, 2: 72, 3: 55][id] ?? 0
}

// MARK: Your solution (Challenge 2)



// MARK: Tests (Challenge 2) — uncomment as you go

// Task {
//     let s1 = await loadPlayerSummary(id: 1)
//     assert(s1.name == "Aria")
//     assert(s1.score == 94)
//     assert(s1.rank == "Gold")
//
//     let s2 = await loadPlayerSummary(id: 2)
//     assert(s2.rank == "Silver")
//
//     let s3 = await loadPlayerSummary(id: 3)
//     assert(s3.rank == "Bronze")
//
//     print("Challenge 2 passed!")
// }


// ============================================================
// MARK: - Challenge 3 (Intermediate): Result Type
// ============================================================
/*
 Task: Use Swift's Result type to handle success and failure without throwing functions.

 Result<Success, Failure: Error> is an enum with two cases:
   .success(value)  — wraps a successful outcome
   .failure(error)  — wraps an error

 Do NOT modify the pre-defined types or data.

 Requirements:
 1. Implement: func findOrder(id: Int) -> Result<Order, AppError>
    - Search the orders array for an order matching the id
    - Return .success(order) if found, .failure(.notFound) if not

 2. Implement: func applyDiscount(_ order: Order) -> Result<Order, AppError>
    - If order.total <= 0, return .failure(.invalidOrder)
    - Otherwise return .success with a new Order where total is reduced by 10%
    - Hint: create a new Order(id: order.id, total: order.total * 0.9)

 3. Implement: func processOrder(id: Int) -> Result<Order, AppError>
    - Chain findOrder and applyDiscount using flatMap:
        findOrder(id: id).flatMap { order in applyDiscount(order) }
    - Return the final Result
 */

// MARK: Pre-defined (do not modify)

struct Order {
    let id: Int
    let total: Double
}

enum AppError: Error, Equatable {
    case notFound
    case invalidOrder
}

let orders: [Order] = [
    Order(id: 1, total: 49.99),
    Order(id: 2, total: 120.00),
    Order(id: 3, total: 0.0),
]

// MARK: Your solution (Challenge 3)



// MARK: Tests (Challenge 3) — uncomment as you go

// let result1 = processOrder(id: 1)
// if case .success(let order) = result1 {
//     assert(abs(order.total - 44.991) < 0.01)  // 49.99 * 0.9
// } else {
//     assert(false, "Expected success for order 1")
// }
//
// let result2 = processOrder(id: 99)
// if case .failure(let error) = result2 {
//     assert(error == .notFound)
// } else {
//     assert(false, "Expected .notFound for missing order")
// }
//
// let result3 = processOrder(id: 3)
// if case .failure(let error) = result3 {
//     assert(error == .invalidOrder)
// } else {
//     assert(false, "Expected .invalidOrder for zero total")
// }
//
// print("Challenge 3 passed!")
