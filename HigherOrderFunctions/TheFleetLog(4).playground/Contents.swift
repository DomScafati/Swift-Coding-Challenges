import Foundation

// Higher Order Functions Challenge
//
// Phrases/patterns that signal Higher Order Functions + String Parsing:
// "filter out...", "keep only..."                    → filter
// "transform each item..."                           → map
// "find the one with the lowest / highest..."        → min(by:) / max(by:)
// "average across all..."                            → reduce
// "remove nils and transform at the same time..."    → compactMap
// "parse a raw log line by line..."                  → components(separatedBy:) + HOFs

// A distress relay has arrived at Deep Space Station Meridian.
// It contains a raw transmission log from an inbound fleet —
// each ship broadcasting its name, status, and fuel level before docking.


// ============================================================
// MARK: - Challenge (Fleet Manifest): Parse & Query a Transmission Log
// ============================================================
/*
 Each line in the transmission log follows this exact format:
   SHIPNAME STATUS FUEL
   e.g. "Orion ACTIVE 87"

 STATUS is one of: ACTIVE, DAMAGED, OFFLINE
 FUEL is an Int (0–100)

 Implement four functions that each parse the same log and answer a different query.

 func activeShips(from log: String) -> [String]
   Return the names of all ACTIVE ships, sorted A–Z.

 func averageFuel(from log: String) -> Double
   Return the average fuel level across ALL ships regardless of status.
   Return 0.0 if the log is empty or unparseable.

 func priorityResupply(from log: String) -> String?
   Return the name of the ACTIVE ship with the lowest fuel level.
   Return nil if there are no active ships.

 func distressList(from log: String) -> [String]
   Return the names of ships that are DAMAGED or OFFLINE,
   in the order they appear in the log.

 Hint: split each line by " " — parts[0] is name, parts[1] is status, parts[2] is fuel.
 */

// MARK: Pre-defined (do not modify)

let transmissionLog = """
Orion ACTIVE 87
Pegasus DAMAGED 12
Athena ACTIVE 34
Kronos OFFLINE 0
Helios ACTIVE 61
Ares DAMAGED 45
Vega ACTIVE 9
"""

// MARK: Your solution

func activeShips(from log: String) -> [String] {
//    Return the names of all ACTIVE ships, sorted A–Z.
    let lines = log.components(separatedBy: "\n") // [String]
    let tmp = lines.compactMap { line -> String? in
        let parts = line.components(separatedBy: " ")
        if parts.count != 3 {
            return nil
        }
        let name = parts[0]
        let status = parts[1]
        
        return status == "ACTIVE" ? name : nil
    }
    return tmp.sorted { name1, name2 in
        name1 < name2
    }
}


func averageFuel(from log: String) -> Double {
//    Return the average fuel level across ALL ships regardless of status.
//    Return 0.0 if the log is empty or unparseable.
    
    let lines = log.components(separatedBy: "\n")
    let finished = lines.compactMap { line -> Double? in
        let parts = line.components(separatedBy: " ")
        let fuel = parts[2]
        return Double(fuel)
    }
    
    let count = Double(finished.count)
    let total = finished.reduce(into: 0.0) { partialResult, fuel in
        return partialResult += fuel
    }
    
    return total/count
}
func priorityResupply(from log: String) -> String? {
//    Return the name of the ACTIVE ship with the lowest fuel level.
//    Return nil if there are no active ships.
    let lines = log.components(separatedBy: "\n")
    let finished = lines.compactMap { line -> (String, Int)? in
        let parts = line.components(separatedBy: " ")
        guard parts.count == 3 else { return nil}
        let name = parts[0]
        let status = parts[1]
        guard let fuel = Int(parts[2]) else { return nil }
        if status != "ACTIVE" { return nil }
        
        return (name, fuel)
    }

    let lowestShip = finished.sorted { first, second in
        first.1 < second.1
    }
    
    return lowestShip[0].0
}


func distressList(from log: String) -> [String] {
//  Return the names of ships that are DAMAGED or OFFLINE,
//  in the order they appear in the log.
    
    let lines = log.components(separatedBy: "\n")
    let finished = lines.compactMap { line -> String? in
        let parts = line.components(separatedBy: " ")
        guard parts.count == 3 else { return nil}
        let name = parts[0]
        let status = parts[1]
        let fuel = Int(parts[2])
        
        if status == "ACTIVE" {
            return nil
        } else {
            return name
        }
    }
    return finished
}

// MARK: Tests — uncomment as you go

 assert(activeShips(from: transmissionLog) == ["Athena", "Helios", "Orion", "Vega"])
 print("activeShips passed!")

assert(abs(averageFuel(from: transmissionLog) - 35.43) < 0.1)
  // (87+12+34+0+61+45+9) / 7, rounded to 2dp
// Hint for averageFuel test: use abs(result - expected) < 0.1 if the assert is fussy about precision
 print("averageFuel passed!")

 assert(priorityResupply(from: transmissionLog) == "Vega")  // lowest fuel among ACTIVE ships (9)
 print("priorityResupply passed!")

assert(distressList(from: transmissionLog) == ["Pegasus", "Kronos", "Ares"])
 print("distressList passed!")
