import Foundation

// Higher Order Functions Challenge
//
// Words/phrases that signal "Higher Order Functions":
// "transform / convert each item"                      → map
// "keep only / exclude / qualifying items"             → filter
// "combine into a single value / accumulate / total"   → reduce
// "apply an operation to every element"                → map / forEach
// "produce a new collection from an existing one"      → map / compactMap / flatMap
// "flatten nested collections into one"                → flatMap

// The colony ship Eos is drifting after a reactor failure.
// Rescue crews intercept the ship's cryo manifest — transmitted
// in fragmented bursts due to damaged comms. You need to find
// the three crew members in the deepest cryo sleep so rescue
// teams can prioritize revival order.

// ============================================================
// MARK: - Challenge 1 (The Drift): Deepest Sleepers
// ============================================================
/*
 The manifest arrives as a single string. Each line is a transmission
 burst containing one or more crew entries separated by "|". Each entry
 is formatted as "Name:ROLE:TEMP" where TEMP is the cryo temperature
 in Kelvin. Corrupted entries show "ERR" instead of a temp and must
 be excluded.
 
 Return the names of the 3 crew members with the lowest cryo
 temperatures (deepest in cryo sleep), ordered coldest to warmest.
 If fewer than 3 valid entries exist, return however many there are.
 
 func deepestSleepers(from manifest: String) -> [String]
 
 Hint: use flatMap to unpack each burst line into individual entries,
 then compactMap to parse and exclude corrupted ones, then sort by temp
 before mapping back to names.
 */

// MARK: Pre-defined (do not modify)

let manifest1 = """
Zara:PILOT:183|Finn:ENGINEER:201
Orin:MEDIC:177|Sable:PILOT:ERR
Lyra:ENGINEER:195
"""
// expected: ["Orin", "Zara", "Lyra"]

let manifest2 = """
Dex:MEDIC:ERR|Cass:PILOT:210
Wren:ENGINEER:186|Atlas:MEDIC:204
Nova:PILOT:191
"""
// expected: ["Wren", "Nova", "Atlas"]

let manifest3 = """
Rex:PILOT:ERR|Sol:ENGINEER:ERR
Mira:MEDIC:220
"""
// expected: ["Mira"]

let manifest4 = """
Juno:ENGINEER:175|Cy:PILOT:169
Asha:MEDIC:192|Blaze:ENGINEER:ERR|Kael:PILOT:183
Vera:MEDIC:178|Pip:ENGINEER:190
"""
// expected: ["Cy", "Juno", "Vera"]

// MARK: Your solution (Challenge 1)

func deepestSleepers(from manifest: String) -> [String] {
    let bursts = manifest.components(separatedBy: "\n")
    let crewMembers = bursts.flatMap { burst in
        return burst.components(separatedBy: "|")
    }
    
    let finished = crewMembers.compactMap { member -> (String, Int)? in
        let parts = member.components(separatedBy: ":")
        if parts.count != 3 { return nil }
        
        let name = parts[0]
        let job = parts[1] // not needed
        guard let temp = Int(parts[2]) else { return nil }
        
        return (name, temp)
    }
    
    let top3 = finished
        .sorted(by: { member1, member2 in
            member1.1 < member2.1
        })
        .prefix(3)
        .map{$0.0}
    
    return top3
}

// MARK: Tests (Challenge 1) — uncomment as you go
print(deepestSleepers(from: manifest1))
 assert(deepestSleepers(from: manifest1) == ["Orin", "Zara", "Lyra"])
 assert(deepestSleepers(from: manifest2) == ["Wren", "Nova", "Atlas"])
 assert(deepestSleepers(from: manifest3) == ["Mira"])
 assert(deepestSleepers(from: manifest4) == ["Cy", "Juno", "Vera"])

print("Challenge 1 passed!")
