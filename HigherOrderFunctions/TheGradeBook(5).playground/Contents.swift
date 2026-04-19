import UIKit

// You're a teacher. You receive a multi-line string where each line contains a student's name followed by their test score. Return a list of students who passed (score >= 70), sorted alphabetically.

// Hints — steps to think about:
// Split the string into lines the same way as the song challenge
// Filter out empty lines
// Split each line into parts and safely extract the score with Int()
// Filter by score >= 70
// Map to just the name
// Sort alphabetically with .sorted()

func passingStudents(from input: String) -> [String] {
    var tmp = input.components(separatedBy: "\n") // separate into rows
        .filter{ !$0.isEmpty } // remove empty
        .compactMap { line -> String? in
            let parts = line.components(separatedBy: " ") // separate into another smaller array

            guard parts.count == 2, let student = parts.first, let score = Int(parts[1]) else { return nil }
            
            return score > 69 ? student : nil
        }
    
    return tmp.sorted()
}

// Test 1
let gradebook1 = """
Alice 85
Bob 62
Charlie 91
Diana 70
Edward 45
"""
// expected output: ["Alice", "Charlie", "Diana"]

// Test 2
let gradebook2 = """
Tommy 95
Jake 68
Sara 72
"""
// expected output: ["Sara", "Tommy"]

// Test 3 - edge case
let gradebook3 = """
Alex 40
Brian 55
"""
// expected output: []

passingStudents(from: gradebook1)
passingStudents(from: gradebook2)
passingStudents(from: gradebook3)
