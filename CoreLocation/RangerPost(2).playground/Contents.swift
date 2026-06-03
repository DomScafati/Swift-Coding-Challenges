import Foundation
import CoreLocation

// CoreLocation Challenge
//
// Phrases/patterns that signal "CoreLocation":
// "find the nearest..."                        → CLLocation.distance(from:), sort by distance
// "within X meters / kilometers of..."         → CLLocation.distance(from:) with a threshold
// "filter locations in range..."               → distance comparison against a radius
// "coordinates, latitude, longitude..."        → CLLocationCoordinate2D, CLLocation
// "how far apart are these two points?"        → CLLocation.distance(from:) returns meters
// "track position / user's current location"  → CLLocationManager + CLLocationManagerDelegate

// You're a park ranger at a remote wilderness post.
// Animal tracking collars ping GPS coordinates throughout the day,
// and your job is to make sense of that raw location data before
// deciding where to deploy your team.

// ============================================================
// MARK: - Challenge 1 (Closest Sighting): Nearest Animal
// ============================================================
/*
 Story: Five collar pings just came in from animals across the park.
 You're standing at your ranger post and need to know which animal
 is closest so you can check on it first.

 Task: Given your current location and an array of sighting locations,
 return the CLLocation that is nearest to you.

 Implement: func nearestSighting(from post: CLLocation, sightings: [CLLocation]) -> CLLocation?

 Hint: CLLocation has a method called distance(from:) that returns
 the distance in meters between two locations — use it to compare.
 */

// MARK: Pre-defined (do not modify)

let rangerPost = CLLocation(latitude: 37.8651, longitude: -119.5383)    // Yosemite Valley

let sightings: [CLLocation] = [
    CLLocation(latitude: 37.8955, longitude: -119.5500),    // bear — ~3.4 km north
    CLLocation(latitude: 37.8300, longitude: -119.4900),    // deer — ~7.2 km southeast
    CLLocation(latitude: 37.8700, longitude: -119.5400),    // fox — ~0.6 km north
    CLLocation(latitude: 37.9100, longitude: -119.6000),    // mountain lion — ~8.1 km northwest
    CLLocation(latitude: 37.8680, longitude: -119.5350),    // coyote — ~0.3 km northeast
]

// MARK: Your solution (Challenge 1)

func nearestSighting(from post: CLLocation, sightings: [CLLocation]) -> CLLocation? {
    guard let sighting = sightings.first else {
        return nil
    }
    
    var closestDistance: Double = post.distance(from: sighting) // assuming this won't be nil
    var closestLocation = sightings[0]
    
    sightings.forEach { location in
        var currentDistance = post.distance(from: location)
        if currentDistance < closestDistance {
            closestDistance = currentDistance
            closestLocation = location
        }
    }
    return closestLocation
    
}

// MARK: Tests (Challenge 1) — uncomment as you go

 let closest = nearestSighting(from: rangerPost, sightings: sightings)
 assert(closest != nil)
assert(closest?.coordinate.latitude == 37.8680)   // coyote is nearest at ~0.3 km
 assert(nearestSighting(from: rangerPost, sightings: []) == nil)
 print("Challenge 1 passed!")


// ============================================================
// MARK: - Challenge 2 (Safe Radius): Sightings Within Range
// ============================================================
/*
 Story: A storm is moving in and you can only safely check on animals
 within a certain radius of your post before you need to shelter.
 You need a list of every sighting that falls within that range.

 Task: Given your post location, an array of sightings, and a radius
 in meters, return all sightings within that radius (inclusive).

 Implement: func sightingsInRange(from post: CLLocation, sightings: [CLLocation], radius: Double) -> [CLLocation]

 Hint: Return the results in the same order they appear in the input array.
 */

// MARK: Pre-defined (do not modify)

// Use the same rangerPost and sightings defined above.
// Distances from rangerPost (approximate):
//   bear          ~3,400 m
//   deer          ~7,200 m
//   fox             ~600 m
//   mountain lion ~8,100 m
//   coyote          ~300 m

// MARK: Your solution (Challenge 2)

func sightingsInRange(from post: CLLocation, sightings: [CLLocation], radius: Double) -> [CLLocation] {

    var array = [CLLocation]()
    
    sightings.forEach { location in
        if location.distance(from: post) <= radius {
            array.append(location)

        }
    }
    
    return array
}

// MARK: Tests (Challenge 2) — uncomment as you go

let nearby = sightingsInRange(from: rangerPost, sightings: sightings, radius: 1000)
 assert(nearby.count == 2)                              // fox and coyote are within 1 km
 assert(nearby[0].coordinate.latitude == 37.8700)      // fox comes first (input order)
 assert(nearby[1].coordinate.latitude == 37.8680)      // coyote comes second

 let wide = sightingsInRange(from: rangerPost, sightings: sightings, radius: 10_000)
 assert(wide.count == 5)                               // all five within 10 km

 let tight = sightingsInRange(from: rangerPost, sightings: sightings, radius: 100)
assert(tight.count == 0)                              // nothing within 100 m
print("Challenge 2 passed!")


// ============================================================
// MARK: - Challenge 3 (Dispatch Order): Sort by Distance
// ============================================================
/*
 Story: The storm cleared and you're ready to do your rounds.
 To plan the most efficient route, you want the full sightings list
 ordered from closest to farthest so you can work your way out
 from the post.

 Task: Given your post location and an array of sightings, return
 the array sorted by distance from the post, nearest first.

 Implement: func sightingsByDistance(from post: CLLocation, sightings: [CLLocation]) -> [CLLocation]

 Hint: Swift's sorted(by:) takes a closure where you compare two
 elements — call distance(from:) on each and compare the results.
 */

// MARK: Pre-defined (do not modify)

// Use the same rangerPost and sightings defined above.
// Expected order closest → farthest:
//   coyote (~300 m), fox (~600 m), bear (~3,400 m), deer (~7,200 m), mountain lion (~8,100 m)

// MARK: Your solution (Challenge 3)



// MARK: Tests (Challenge 3) — uncomment as you go

// let ordered = sightingsByDistance(from: rangerPost, sightings: sightings)
// assert(ordered.count == 5)
// assert(ordered[0].coordinate.latitude == 37.8680)   // coyote — nearest
// assert(ordered[1].coordinate.latitude == 37.8700)   // fox
// assert(ordered[2].coordinate.latitude == 37.8955)   // bear
// assert(ordered[3].coordinate.latitude == 37.8300)   // deer
// assert(ordered[4].coordinate.latitude == 37.9100)   // mountain lion — farthest
// assert(sightingsByDistance(from: rangerPost, sightings: []).isEmpty)
// print("Challenge 3 passed!")
