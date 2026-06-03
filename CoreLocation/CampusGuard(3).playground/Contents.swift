import Foundation
import CoreLocation

// CoreLocation Challenge
//
// Phrases/patterns that signal "CLLocationManager / Delegate / Geofencing":
// "start tracking the user's location"             → CLLocationManager + startUpdatingLocation()
// "ask the user for location permission"           → requestWhenInUseAuthorization() or requestAlwaysAuthorization()
// "respond when location updates come in"          → CLLocationManagerDelegate: didUpdateLocations
// "handle a location error"                        → CLLocationManagerDelegate: didFailWithError
// "react when authorization status changes"        → CLLocationManagerDelegate: didChangeAuthorization
// "alert me when the user enters/exits an area"   → CLCircularRegion + startMonitoring(for:)
// "define a boundary around a point"               → CLCircularRegion(center:radius:identifier:)

// You're building the location layer for a corporate campus security app.
// Guards need live position tracking, permission handling, and automatic
// alerts when someone enters or exits a restricted zone.

// ============================================================
// MARK: - Challenge 1 (Badge In): LocationManager Setup
// ============================================================
/*
 Story: Before anything works, the app needs a properly wired
 CLLocationManager — one that has a delegate, asks for permission,
 and is ready to start delivering updates.

 Task: Implement a class called LocationTracker that:
   - Conforms to CLLocationManagerDelegate
   - Holds a CLLocationManager as a property called `manager`
   - In its initializer, sets itself as the manager's delegate
     and calls requestWhenInUseAuthorization()
   - Has a method startTracking() that calls startUpdatingLocation()
   - Has a method stopTracking() that calls stopUpdatingLocation()

 Hint: Your class must inherit from NSObject AND conform to CLLocationManagerDelegate —
 nearly all Apple delegate protocols require this because they're built on Objective-C
 foundations. The declaration looks like: class LocationTracker: NSObject, CLLocationManagerDelegate
 */

// MARK: Your solution (Challenge 1)

class LocationTracker: CLLocationManagerDelegate {
    
    var hash: Int
    var superclass: AnyClass?
    var description: String

    var manager: CLLocationManager = CLLocationManager()
    
    init(hash: Int, superclass: AnyClass? = nil, description: String) {
        self.hash = hash
        self.superclass = superclass
        self.description = description
        
        self.manager.delegate = self
        self.manager.requestWhenInUseAuthorization()
    }
    
    func startTacking() {
        manager.startUpdatingLocation()
    }
    
    func stopTracking() {
        manager.stopUpdatingLocation()
    }
    
    func isEqual(_ object: Any?) -> Bool { return false}

    func `self`() -> Self { return self}
    
    func perform(_ aSelector: Selector!) -> Unmanaged<AnyObject>! { return nil }

    func perform(_ aSelector: Selector!, with object: Any!) -> Unmanaged<AnyObject>! { return nil }

    func perform(_ aSelector: Selector!, with object1: Any!, with object2: Any!) -> Unmanaged<AnyObject>! { return nil }

    func isProxy() -> Bool { return false }

    func isKind(of aClass: AnyClass) -> Bool { return type(of: self) == aClass }

    func isMember(of aClass: AnyClass) -> Bool { return type(of: self) == aClass }

    func conforms(to aProtocol: Protocol) -> Bool { return false }

    func responds(to aSelector: Selector!) -> Bool { return false }
    
}

// MARK: Tests (Challenge 1) — uncomment as you go

let tracker = LocationTracker(hash: 0, description: "test")
assert(tracker.manager.delegate != nil, "delegate must be set in init")
print("Challenge 1 passed!")


// ============================================================
// MARK: - Challenge 2 (Night Shift): Delegate Methods
// ============================================================
/*
 Story: Location events start firing — position updates, failures,
 and permission changes all need to be handled so the app behaves
 correctly in every situation.

 Task: Extend your LocationTracker with three delegate methods:
   - didUpdateLocations: print the most recent location's coordinate
   - didFailWithError: print the error and call stopTracking()
   - didChangeAuthorization: if status is .denied or .restricted,
     call stopTracking(); if .authorizedWhenInUse or .authorizedAlways,
     call startTracking()

 Hint: locations.last gives you the most recent CLLocation in
 didUpdateLocations — its coordinate property holds lat and lon.
 */

// MARK: Your solution (Challenge 2)
// Extend LocationTracker below (or add the methods directly to the class above)

extension LocationTracker {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let lastLocation = locations.last else {
            return
        }
        
        print(lastLocation)
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: any Error) {
        print(error)
        stopTracking()
    }
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        switch manager.authorizationStatus {
        case .denied, .restricted:
            stopTracking()
        case .authorizedWhenInUse, .authorizedAlways:
            startTacking()
        default: break
        }
    }
}

// MARK: Tests (Challenge 2) — uncomment as you go

// No assert-based test here — verify by reading your method signatures
// and confirming each case is handled. A reviewer will read this code,
// not run it.
 print("Challenge 2 done — review your delegate methods.")


// ============================================================
// MARK: - Challenge 3 (Restricted Zone): Geofencing
// ============================================================
/*
 Story: The server room is off-limits after hours. You need to define
 a circular boundary around it and start monitoring so the app fires
 an alert whenever someone enters or exits that zone.

 Task: Add to LocationTracker:
   - A method monitorZone(center: CLLocationCoordinate2D, radius: Double, id: String)
     that creates a CLCircularRegion and calls startMonitoring(for:) on the manager
   - didEnterRegion: print "Entered zone: \(region.identifier)"
   - didExitRegion: print "Exited zone: \(region.identifier)"

 Hint: CLCircularRegion is initialized with
 CLCircularRegion(center:radius:identifier:) — radius is in meters.
 */

// MARK: Pre-defined (do not modify)

let serverRoomCoordinate = CLLocationCoordinate2D(latitude: 37.3317, longitude: -122.0307)
let serverRoomRadius: Double = 50   // 50 meter boundary
let serverRoomID = "server-room"

// MARK: Your solution (Challenge 3)
// Add monitorZone and the two region delegate methods to LocationTracker

extension LocationTracker {
    func monitorZone(center: CLLocationCoordinate2D, radius: Double, id: String) {
        let region = CLCircularRegion(
            center: center,
            radius: radius,
            identifier: id
        )
        
        manager.startMonitoring(for: region)
    }
    
    func locationManager(_ manager: CLLocationManager, didEnterRegion region: CLRegion) {
           print("Entered zone: \(region.identifier)")
    }
    
    func locationManager(_ manager: CLLocationManager, didExitRegion region: CLRegion) {
        print("Exited zone: \(region.identifier)")
    }
}

// MARK: Tests (Challenge 3) — uncomment as you go

 let guardTracker = LocationTracker(hash: 0, description: "test")
 guardTracker.monitorZone(center: serverRoomCoordinate, radius: serverRoomRadius, id: serverRoomID)
 let regions = guardTracker.manager.monitoredRegions
 assert(regions.count == 1, "one region should be monitored")
 let region = regions.first as? CLCircularRegion
 assert(region?.identifier == "server-room")
 assert(region?.radius == 50)
 print("Challenge 3 passed!")
