import Foundation

// Dictionary Challenge
//
// Words/phrases that signal "Dictionary":
// "count occurrences / frequency"
// "group by / categorize"
// "find the most/least common"
// "map one thing to another"

// You're working the counter at The Daily Grind, a busy café.
// Every order is logged, and at end of day you crunch the numbers.

// ============================================================
// MARK: - Challenge 1: Order Frequency Count
// ============================================================
/*
 Story: At closing time, you have a list of every drink ordered today.
 You want to know how many times each drink was ordered.

 Task: Given an array of drink names, return a dictionary mapping
 each drink to the number of times it was ordered.

 Requirements:
 1. Implement: func orderFrequency(_ orders: [String]) -> [String: Int]
    - Each key is a drink name, each value is its order count
    - Use dictionary subscript with a default value: dict[key, default: 0] += 1

 Hint: Loop through the array and increment the count for each drink.
 */

// MARK: Pre-defined (do not modify)

let todaysOrders: [String] = [
    "latte", "espresso", "latte", "cappuccino",
    "espresso", "latte", "cappuccino", "espresso",
    "matcha", "latte"
]

// MARK: Your solution (Challenge 1)

func orderFrequency(_ orders: [String]) -> [String: Int] {
    var dict = [String: Int]()
    
    for order in orders {
        dict[order, default: 0] += 1
    }
    
    return dict
}

// MARK: Tests (Challenge 1) — uncomment as you go

let freq = orderFrequency(todaysOrders)
assert(freq["latte"]      == 4)
assert(freq["espresso"]   == 3)
assert(freq["cappuccino"] == 2)
assert(freq["matcha"]     == 1)
assert(freq["tea"]        == nil)
print("Challenge 1 passed!")


// ============================================================
// MARK: - Challenge 2: Most Popular Drink
// ============================================================
/*
 Story: The manager wants to know which drink to feature on tomorrow's
 specials board — whichever sold the most today.

 Task: Given a frequency dictionary, return the drink name with the
 highest count. Return nil if the dictionary is empty.

 Requirements:
 1. Implement: func mostPopular(_ frequency: [String: Int]) -> String?
    - Use max(by:) on the dictionary to find the highest-count entry
    - Return just the drink name (the key), not the count
    - Return nil if the dictionary is empty

 Hint: max(by:) on a dictionary gives you a key-value pair. Access .key on the result.
 */

// MARK: Pre-defined (do not modify)

// todaysOrders defined above

// MARK: Your solution (Challenge 2)

func mostPopular(_ frequency: [String: Int]) -> String? {
    if frequency.isEmpty { return nil }
    
    var highest = ("", 0)
    
    for (key, value) in frequency {
        if value > highest.1 {
            highest.0 = key
            highest.1 = value
        }
    }
    return highest.0
}

// MARK: Tests (Challenge 2) — uncomment as you go

assert(mostPopular(orderFrequency(todaysOrders)) == "latte")
assert(mostPopular([:]) == nil)
print("Challenge 2 passed!")

// ============================================================
// MARK: - Challenge 3: Group Orders by Table
// ============================================================
/*
 Story: The café runs a table service section where each order is tagged
 with a table number. At the end of the night you want a per-table
 summary — useful for splitting bills or spotting trends.

 Task: Given an array of (table, drink) tuples, return a dictionary
 mapping each table number to the list of drinks ordered there,
 in the order they were placed.

 Requirements:
 1. Implement: func groupByTable(_ orders: [(table: Int, drink: String)]) -> [Int: [String]]
    - Each key is a table number, each value is an ordered list of drinks
    - Preserve the original order of drinks within each table
    - Use dict[key, default: []] to safely append without unwrapping

 Hint: Loop through orders, appending each drink to the correct table's array.
 */

// MARK: Pre-defined (do not modify)

let tableOrders: [(table: Int, drink: String)] = [
    (1, "latte"),      (2, "espresso"), (1, "cappuccino"),
    (3, "matcha"),     (2, "latte"),    (1, "espresso"),
    (3, "cappuccino"), (2, "matcha")
]

// MARK: Your solution (Challenge 3)

func groupByTable(_ orders: [(table: Int, drink: String)]) -> [Int: [String]] {
    var dict = [Int: [String]]()
    for (table, drink) in orders {
        dict[table, default: []].append(drink)
    }
    
    return dict
}

// MARK: Tests (Challenge 3) — uncomment as you go

let grouped = groupByTable(tableOrders)
assert(grouped[1] == ["latte", "cappuccino", "espresso"])
assert(grouped[2] == ["espresso", "latte", "matcha"])
assert(grouped[3] == ["matcha", "cappuccino"])
assert(grouped[4] == nil)
print("Challenge 3 passed!")
