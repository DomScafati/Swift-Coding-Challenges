import UIKit

// You receive a multi-line string where each line contains a player's username and their score. Return a dictionary where the key is the username and the value is their highest score, in case they appear more than once.
// 💡 Hints:
// Split and filter empty lines
// Parse each line into name and score
// For each entry, check if the name already exists in your dictionary
// Keep whichever score is higher with max()
func highScores(from input: String) -> [String: Int] {
    var result = [String: Int]()
    
    let lines = input.components(separatedBy: "\n")
        .filter { !$0.isEmpty }
    
    for line in lines {
        let parts = line.components(separatedBy: " ")
        guard parts.count == 2,
              let name = parts.first,
              let score = Int(parts[1]) else { continue }
        
        result[name] = max(result[name] ?? score, score)
    }
    
    return result
}

let dict = [Int: Int]()
dict[1, default: 0]

let scores1 = """
Alice 120
Bob 95
Alice 140
Charlie 80
Bob 110
"""
// expected output: ["Alice": 140, "Bob": 110, "Charlie": 80]

let scores2 = """
Tommy 200
Jake 150
Tommy 180
"""
// expected output: ["Tommy": 200, "Jake": 150]
highScores(from: scores1)
highScores(from: scores2)
