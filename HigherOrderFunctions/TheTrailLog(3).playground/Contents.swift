import Foundation

// Higher Order Functions Challenge
//
// Words/phrases that signal "Higher Order Functions":
// "transform / convert each item"
// "keep only / exclude / qualifying items"
// "combine into a single value / accumulate / total"
// "apply an operation to every element"
// "produce a new collection from an existing one"

// You're building a feature for a hiking app.
// Hikers log their trails, and your job is to process that data.

// ============================================================
// MARK: - Challenge 1: Convert Distances
// ============================================================
/*
 Story: The app originally stored all trail distances in miles.
 A new update requires everything to be displayed in kilometres.

 Task: Given an array of distances in miles, return a new array
 with every distance converted to kilometres.

 Note: 1 mile = 1.60934 km. Round each result to 2 decimal places.

 Requirements:
 1. Implement: func toKilometres(_ miles: [Double]) -> [Double]
    - Produce a new array by applying the conversion to each element
    - Round each result to 2 decimal places using:
      (value * 100).rounded() / 100
 */

// MARK: Pre-defined (do not modify)

let trailDistancesMiles: [Double] = [1.2, 3.5, 0.8, 5.0, 2.3]

// MARK: Your solution (Challenge 1)

func toKilometres(_ miles: [Double]) -> [Double] {
    let kilometerConversion = 1.60934
    
    let new = miles.compactMap { trailDistance in
        let converted = trailDistance * 1.60934
        return (converted * 100).rounded() / 100
    }
    
    return new
}

// MARK: Tests (Challenge 1) — uncomment as you go

let km = toKilometres(trailDistancesMiles)
assert(km == [1.93, 5.63, 1.29, 8.05, 3.7])
print("Challenge 1 passed!")


// ============================================================
// MARK: - Challenge 2: Qualifying Trails
// ============================================================
/*
 Story: A "challenging hikes" section of the app should only show trails
 that meet both of the following criteria:
   - Distance is at least 3.0 miles
   - Elevation gain is at least 400 metres

 Task: Given an array of Trail values, return only the trails that
 qualify for the challenging hikes section.

 Requirements:
 1. Implement: func challengingTrails(_ trails: [Trail]) -> [Trail]
    - Keep only trails where distance >= 3.0 AND elevationGain >= 400
 */

// MARK: Pre-defined (do not modify)

struct Trail {
    let name: String
    let distanceMiles: Double
    let elevationGain: Int   // metres
}

let trailCatalogue: [Trail] = [
    Trail(name: "Sunrise Loop",    distanceMiles: 1.2, elevationGain: 180),
    Trail(name: "Ridge Run",       distanceMiles: 4.1, elevationGain: 620),
    Trail(name: "Valley Stroll",   distanceMiles: 2.8, elevationGain: 95),
    Trail(name: "Summit Push",     distanceMiles: 5.3, elevationGain: 980),
    Trail(name: "Forest Path",     distanceMiles: 3.0, elevationGain: 390),
    Trail(name: "Cliffside Climb", distanceMiles: 3.7, elevationGain: 410)
]

// MARK: Your solution (Challenge 2)

func challengingTrails(_ trails: [Trail]) -> [Trail] {
    let new = trails.filter { trail in
        if trail.distanceMiles >= 3.0 && trail.elevationGain >= 400 {
            return true
        }
        return false
    }
    return new
}

// MARK: Tests (Challenge 2) — uncomment as you go

let hardTrails = challengingTrails(trailCatalogue)
assert(hardTrails.count == 3)
assert(hardTrails.map { $0.name } == ["Ridge Run", "Summit Push", "Cliffside Climb"])
print("Challenge 2 passed!")


// ============================================================
// MARK: - Challenge 3: Total Elevation for a Hiker
// ============================================================
/*
 Story: The app tracks a "lifetime elevation" badge — the total metres
 climbed across all completed hikes. Given a hiker's list of completed
 trail names, calculate their total elevation gain.

 Task: Given a hiker's completed trail names and the full trail catalogue,
 return the total elevation gain across all matched trails.
 Ignore any name that doesn't match a trail in the catalogue.

 Requirements:
 1. Implement: func totalElevation(for completedNames: [String], in catalogue: [Trail]) -> Int
    - Accumulate the elevation gain for each completed trail
    - Skip names not found in the catalogue
 */

// MARK: Pre-defined (do not modify)

// trailCatalogue defined above

let completedHikes: [String] = ["Ridge Run", "Sunrise Loop", "Summit Push", "Ghost Trail"]

// MARK: Your solution (Challenge 3)

func totalElevation(for completedNames: [String], in catalogue: [Trail]) -> Int {
    
    let new: Int = catalogue.reduce(0) { partialResult, trail in
        if completedNames.contains(trail.name) {
            return partialResult + trail.elevationGain
        }
        return partialResult
    }
    
    return new
}


// MARK: Tests (Challenge 3) — uncomment as you go

assert(totalElevation(for: completedHikes, in: trailCatalogue) == 1780) // 620 + 180 + 980
assert(totalElevation(for: ["Ghost Trail"], in: trailCatalogue) == 0)   // no match
assert(totalElevation(for: [], in: trailCatalogue) == 0)                // empty input
print("Challenge 3 passed!")
