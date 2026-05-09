import Foundation

// Higher Order Functions Challenge
//
// Words/phrases that signal "Higher Order Functions":
// "transform / convert each item"                      → map
// "keep only / exclude / qualifying items"             → filter
// "combine into a single value / accumulate / total"   → reduce
// "apply an operation to every element"                → map / forEach
// "produce a new collection from an existing one"      → map / compactMap / flatMap

// It's race day at the city marathon.
// Results come in as a raw timing sheet — one entry per line.
// Not everyone finishes, and you need to find the top three.

// ============================================================
// MARK: - Challenge 1 (The Podium): Top 3 Finishers
// ============================================================
/*
 Each line of the results sheet contains a runner's name followed by their
 finish time in "MM:SS" format, separated by a space. Runners who did not
 finish are recorded as "DNF" instead of a time and must be excluded.

 Return the names of the top 3 finishers in order from fastest to slowest.
 If fewer than 3 runners finished, return however many did.

 func topFinishers(from results: String) -> [String]

 Hint: use compactMap to parse and exclude DNF entries in one pass,
 then sort by time before mapping back to names.
 */

// MARK: Pre-defined (do not modify)

let results1 = """
Alice 12:34
Bob 11:58
Carol 13:05
Diana 11:45
Edward 12:01
"""
// expected: ["Diana", "Bob", "Edward"]

let results2 = """
Tommy 09:42
Jake DNF
Sara 10:15
Leo DNF
Priya 09:58
"""
// expected: ["Tommy", "Priya", "Sara"]

let results3 = """
Finn DNF
Grace DNF
Hank 14:22
"""
// expected: ["Hank"]  — fewer than 3 finishers

let results4 = """
Maya 08:05
Noah 07:55
Olivia DNF
Pete 08:30
Quinn 07:48
Rosa 09:01
"""
// expected: ["Quinn", "Noah", "Maya"]

// MARK: Your solution (Challenge 1)

func topFinishers(from results: String) -> [String] {
    
    let lines = results.components(separatedBy: "\n")
    
    let partial = lines.compactMap { string -> (String, Int)? in
        let parts = string.components(separatedBy: " ")
        
        if parts.count != 2 {
            return nil
        }
        
        let name = parts[0]
        let time = parts[1].components(separatedBy: ":")
        
        guard let minutes = Int(time[0]),
              let seconds = Int(time[1]) else {
            return nil
        }
        let totalTime = minutes * 60 + seconds
        
        return (name, totalTime)
    }
    
    let finished = partial
        .sorted{ $0.1 < $1.1 }
        .prefix(3)
        .map { (name, time) in
            return name
        }
    
    return finished
}


// MARK: Tests (Challenge 1) — uncomment as you go
 assert(topFinishers(from: results1) == ["Diana", "Bob", "Edward"])
 assert(topFinishers(from: results2) == ["Tommy", "Priya", "Sara"])
 assert(topFinishers(from: results3) == ["Hank"])
 assert(topFinishers(from: results4) == ["Quinn", "Noah", "Maya"])

 print("Challenge 1 passed!")
