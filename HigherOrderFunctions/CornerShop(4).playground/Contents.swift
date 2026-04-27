import UIKit

// MARK: - Corner Shop
//
// You run a small corner shop and receive a daily log of inventory commands.
// Process the log and return your final stock levels as a dictionary.
//
// Each line in the command string is one of the following:
//
//   STOCK item n   — add n units of item to stock (creates it if it doesn't exist)
//   SELL item n    — remove n units of item from stock
//   DOUBLE item    — double the current stock of an item
//   REMOVE item    — remove the item from inventory entirely
//
// Rules:
// - Start with an empty inventory
// - Process commands top to bottom
// - Ignore empty or unrecognized lines
// - Stock can go negative (you can sell more than you have)

// MARK: - Your function

func finalInventory(from commands: String) -> [String: Int] {
    var validCommands = Set(["STOCK", "SELL", "DOUBLE", "REMOVE"])
    var inventory = [String:Int]()
    // separate into rows
    commands.components(separatedBy: "\n")
        .filter { !$0.isEmpty }
        .forEach { row in
            // separate theose rows into parts
        let parts = row.components(separatedBy: " ")
            // remove any parts where parts[0] is not a valid command
            if (2...3).contains(parts.count) &&
                validCommands.contains(parts[0]) {
                
                let command = parts[0]
                let item = parts[1]
                let amount = Int(parts.last ?? "") ?? 0

                switch command {
                case "STOCK":
                    inventory[item, default: 0] += amount
                case "SELL":
                    inventory[item, default: 0] -= amount
                case "DOUBLE":
                    inventory[item, default: 0] *= 2
                case "REMOVE":
                    inventory[item] = nil
                default: break
                }
        }
    }
    
    return inventory
}

// MARK: - Test Cases

// Test 1
let log1 = """
STOCK apples 50
STOCK bananas 30
SELL apples 20
DOUBLE bananas
"""
// Expected: ["apples": 30, "bananas": 60]

// Test 2
let log2 = """
STOCK milk 10
STOCK eggs 24
SELL eggs 6
REMOVE milk
STOCK bread 15
"""
// Expected: ["eggs": 18, "bread": 15]

// Test 3 — edge case: garbage lines mixed in
let log3 = """
STOCK water 100
SELL water 40
RESTOCK water
UNKNOWN item
"""
// Expected: ["water": 60]

finalInventory(from: log1)
finalInventory(from: log2)
finalInventory(from: log3)
