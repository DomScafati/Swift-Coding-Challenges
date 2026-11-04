import Foundation

// Higher Order Functions Challenge
//
// Words/phrases that signal "Higher Order Functions":
// "transform / convert each item"                      → map
// "keep only / exclude / qualifying items"             → filter
// "combine into a single value / accumulate / total"   → reduce
// "convert text to numbers, skip the ones that fail"   → compactMap
// "produce a new collection from an existing one"      → map / compactMap / flatMap
// "flatten nested collections into one"                → flatMap

// Night falls over the Ravenmoor freight yard. The 6 a.m. goods train
// leaves in a few hours, and the dispatcher has been handed raw logs
// from three different systems: the old manifest printer, the new
// weighbridge scales, and the platform board. Every log is one long
// string, and none of them agree on how to write things down.

// ============================================================
// MARK: - Challenge 1 (The Manifest): Total Tonnes of a Cargo
// ============================================================
/*
 The manifest printer produces one line per wagon, with four fields
 separated by commas: the wagon ID, the cargo, the weight in tonnes,
 and the status.

     W101,coal,40,OK

 Some weights could not be read by the printer and show up as "?".
 Those wagons can't be counted. An empty manifest has no wagons.

 Return the combined weight, in tonnes, of every wagon carrying the
 given cargo. If no wagon carries it, return 0.

 func totalTonnes(of cargo: String, in manifest: String) -> Int

 Hint: split the text into lines, then each line into fields. Casting
 the weight to an Int can fail, and compactMap throws away failures.
 */

// MARK: Pre-defined (do not modify)

let manifest = """
W101,coal,40,OK
W102,grain,25,OK
W103,coal,38,DELAYED
W104,timber,?,OK
W105,grain,30,OK
W106,coal,?,FAULT
W107,coal,42,OK
W108,timber,18,OK
"""
// expected: totalTonnes(of: "coal", in: manifest) == 120   → 40 + 38 + 42, W106 is unreadable

// MARK: Your solution (Challenge 1)

func totalTonnes(of cargo: String, in manifest: String) -> Int {
    var total = 0
    guard !manifest.isEmpty else { return total }
    
    manifest.components(separatedBy: "\n").map { line in
        var fixed = line.components(separatedBy: ",")
        var id = fixed[0]
        var type = fixed[1]
        var status = fixed[3]
        
        if type == cargo,
           let weight = Int(fixed[2]) {
            total += weight
        }
    }
    
    return total
}


// MARK: Tests (Challenge 1) — uncomment as you go

 assert(totalTonnes(of: "coal", in: manifest) == 120)     // W106 is skipped
 assert(totalTonnes(of: "grain", in: manifest) == 55)     // 25 + 30
 assert(totalTonnes(of: "timber", in: manifest) == 18)    // W104 is skipped
 assert(totalTonnes(of: "iron", in: manifest) == 0)       // nobody carries iron
 assert(totalTonnes(of: "coal", in: "") == 0)             // empty manifest
 print("Challenge 1 passed!")


// ============================================================
// MARK: - Challenge 2 (The Weighbridge): Overweight Wagons
// ============================================================
/*
 The weighbridge scales write each reading as a line of key=value
 pairs separated by spaces. The order of the pairs is always the same:

     wagon=W101 weight=52 limit=50

 A wagon is overweight if its weight is strictly greater than its
 limit. Weights the scales failed to read are written as "?", and
 those wagons are skipped.

 Return the IDs of every overweight wagon, in the same order they
 appear in the readings.

 func overweightWagons(in readings: String) -> [String]

 Hint: split each line on spaces, then split each piece on "=" to
 separate the key from its value.
 */

// MARK: Pre-defined (do not modify)

let readings = """
wagon=W101 weight=52 limit=50
wagon=W102 weight=44 limit=50
wagon=W103 weight=? limit=50
wagon=W104 weight=61 limit=60
wagon=W105 weight=30 limit=30
wagon=W106 weight=47 limit=45
"""
// expected: overweightWagons(in: readings) == ["W101", "W104", "W106"]

// MARK: Your solution (Challenge 2)

func overweightWagons(in readings: String) -> [String] {
    var overweightWagons = [String]()
    
    var lines: [String] = readings.components(separatedBy: "\n")
    var fields: [[String]] = lines.map { line in
        return line.components(separatedBy: " ")
    }
    var fullSeparated: [[[String]]] = fields.map { line in
        return line.map { part in
            part.components(separatedBy: "=")
        }
    }
    
    fullSeparated.forEach { line in
        guard line.count == 3,
              let weight = Int(line[1][1]),
              let limit = Int(line[2][1]),
              weight > limit
        else { return }
        overweightWagons.append(line[0][1])
    }
        
    return overweightWagons
}

// MARK: Tests (Challenge 2) — uncomment as you go

 assert(overweightWagons(in: readings) == ["W101", "W104", "W106"])
 assert(overweightWagons(in: "wagon=W201 weight=30 limit=30") == [])        // equal to the limit is fine
 assert(overweightWagons(in: "wagon=W202 weight=? limit=10") == [])         // unreadable weight
 assert(overweightWagons(in: "wagon=W203 weight=11 limit=10") == ["W203"])  // a single overweight wagon
 assert(overweightWagons(in: "") == [])
 print("Challenge 2 passed!")


// ============================================================
// MARK: - Challenge 3 (The Platform Board): Wagons From Platform N
// ============================================================
/*
 The platform board lists which wagons are waiting on each platform.
 Each line has the platform number, a colon, and then the wagon IDs
 separated by spaces. A platform with nothing on it has no IDs after
 the colon.

     Platform 3: W104 W105 W106
     Platform 4:

 The night shift is only responsible for platforms from a certain
 number upwards.

 Return the IDs of every wagon waiting on a platform numbered
 `minPlatform` or higher, in the order they appear on the board.

 func wagons(onBoard board: String, fromPlatform minPlatform: Int) -> [String]

 Hint: each line gives you a platform number and a list of IDs, and
 flatMap can turn a list of lists into one list.
 */

// MARK: Pre-defined (do not modify)

let board = """
Platform 1: W101 W102
Platform 2: W103
Platform 3: W104 W105 W106
Platform 4:
Platform 5: W107 W108
Platform 10: W109
"""
// expected: wagons(onBoard: board, fromPlatform: 3) == ["W104", "W105", "W106", "W107", "W108", "W109"]

// MARK: Your solution (Challenge 3)



// MARK: Tests (Challenge 3) — uncomment as you go

// assert(wagons(onBoard: board, fromPlatform: 3) == ["W104", "W105", "W106", "W107", "W108", "W109"])
// assert(wagons(onBoard: board, fromPlatform: 1) == ["W101", "W102", "W103", "W104", "W105", "W106", "W107", "W108", "W109"])
// assert(wagons(onBoard: board, fromPlatform: 6) == ["W109"])    // platform 10 counts as higher than 6
// assert(wagons(onBoard: board, fromPlatform: 4) == ["W107", "W108", "W109"])   // empty platform 4 adds nothing
// assert(wagons(onBoard: board, fromPlatform: 11) == [])
// print("Challenge 3 passed!")
