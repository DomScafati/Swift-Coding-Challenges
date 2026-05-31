import Foundation

// Swift Dev Challenge
//
// Four connected challenges — all set inside NestCore, a smart home
// control system. Lights, locks, and thermostats report their state
// to a central hub. Each challenge builds on the same shared types,
// so the concepts stay connected rather than isolated.
//
// Topics:
//   Challenge 1 — Enums + associated values
//   Challenge 2 — Protocol extensions
//   Challenge 3 — Generics
//   Challenge 4 — Closures + capture lists


// MARK: - Shared types (do not modify)

enum DeviceState {
    case on
    case off
    case dimmed(level: Int)     // level: 1–100
    case error(reason: String)
}

// ============================================================
// MARK: - Challenge 1 (The Signal): Enums + Associated Values
// ============================================================
/*
 Every device in the system reports a DeviceState. The hub needs
 to turn any state into a human-readable string for the dashboard.

 Write a function that switches over a DeviceState exhaustively
 and returns a description string for each case:
   .on             → "On"
   .off            → "Off"
   .dimmed(40)     → "Dimmed to 40%"
   .error("surge") → "Error: surge"

 func describe(_ state: DeviceState) -> String

 Hint: associated values are unpacked inline in the case — you
 don't need a separate let binding outside the switch.
*/

// MARK: Your solution (Challenge 1)

func describe(_ state: DeviceState) -> String {
    switch state {
    case .on:
        return "On"
    case .off:
        return "Off"
    case .dimmed(let level):
        return "Dimmed to \(level)%"
    case .error(let reason):
        return "Error: \(reason)"
    }
}


// MARK: Tests (Challenge 1) — uncomment as you go

assert(describe(.on) == "On")
assert(describe(.off) == "Off")
assert(describe(.dimmed(level: 40)) == "Dimmed to 40%")
assert(describe(.error(reason: "surge")) == "Error: surge")
print("Challenge 1 passed!")


// ============================================================
// MARK: - Challenge 2 (The Blueprint): Protocol Extensions
// ============================================================
/*
 Every device in the hub conforms to SmartDevice. Rather than
 making each device implement its own statusSummary, add a
 protocol extension that provides it for free.

 Step 1: Extend SmartDevice so that any conforming type
 automatically gets a computed property:

   var statusSummary: String { "\(name): \(describe(state))" }

 This uses describe() from Challenge 1 — solve that one first.

 Hint: the extension goes on the protocol, not on each struct.
 That's what gives all conforming types the property for free.
*/


// MARK: Pre-defined (do not modify)

protocol SmartDevice {
    var name: String { get }
    var state: DeviceState { get }
}

struct Light: SmartDevice {
    let name: String
    let state: DeviceState
}

struct Thermostat: SmartDevice {
    let name: String
    let state: DeviceState
}

// MARK: Your solution (Challenge 2)

// Step 1 — Protocol extension with statusSummary

extension SmartDevice {
    var statusSummary: String {
        return "\(name): \(describe(state))"
    }
}

// MARK: Tests (Challenge 2) — uncomment as you go

let hallLight = Light(name: "Hall Light", state: .dimmed(level: 60))
let boilerRoom = Thermostat(name: "Boiler Room", state: .error(reason: "overheating"))
assert(hallLight.statusSummary == "Hall Light: Dimmed to 60%")
assert(boilerRoom.statusSummary == "Boiler Room: Error: overheating")
print("Challenge 2 passed!")


// ============================================================
// MARK: - Challenge 3 (The Log): Generics
// ============================================================
/*
 The hub keeps a rolling event log for any type of event — device
 state changes, error codes, log strings. It should work for any
 type, so it needs to be generic.

 Implement a generic struct EventLog<T> with:
   - A private [T] array to store events
   - A capacity: Int set at init — the log never grows beyond it
   - mutating func append(_ event: T)
       Adds the event. If already at capacity, drop the oldest
       before appending the new one.
   - func latest(_ count: Int) -> [T]
       Returns the last `count` events in order (oldest first).
       If count > events stored, return everything you have.

 Hint: dropping the oldest means removing from the front of
 the array — index 0.
*/

// MARK: Your solution (Challenge 3)

struct EventLog<T> {
    private var eventLog: [T]
    var capacity: Int
    
    init(eventLog: [T] = [], capacity: Int) {
        self.eventLog = eventLog
        self.capacity = capacity
    }
    
    mutating func append(_ event: T) {
        if eventLog.count < capacity {
            eventLog.append(event)
        } else {
            eventLog.removeFirst()
            eventLog.append(event)
        }
    }
    
    func latest(_ count: Int) -> [T] {
        return Array(eventLog.suffix(count))
    }
}

// MARK: Tests (Challenge 3) — uncomment as you go

var log = EventLog<String>(capacity: 3)
log.append("lights on")
log.append("door locked")
log.append("thermostat set")
log.append("alarm triggered")          // pushes "lights on" out
assert(log.latest(3) == ["door locked", "thermostat set", "alarm triggered"])
assert(log.latest(1) == ["alarm triggered"])
assert(log.latest(10) == ["door locked", "thermostat set", "alarm triggered"]) // capped at what's stored
print("Challenge 3 passed!")


// ============================================================
// MARK: - Challenge 4 (The Monitor): Closures + Capture Lists
// ============================================================
/*
 DeviceMonitor holds an optional closure — onStateChange — that
 gets called whenever a device updates. Dashboard listens to it.

 Both classes are fully pre-defined. Your solution goes in the
 extension below.

 Step 1: In DeviceMonitor, implement update(device:to:) so it
 calls onStateChange with the device name and new state,
 but only if a closure has been assigned.

 Step 2: In Dashboard, implement subscribe(to:) so it assigns
 a closure to monitor.onStateChange. That closure should call
 self.displayUpdate(device:state:) — but use [weak self] to
 avoid a retain cycle between Dashboard and DeviceMonitor.

 Hint for Step 1: optional closures can be called with ?(args)
 — the same optional chaining you'd use on any optional.

 Hint for Step 2: [weak self] makes self optional inside the
 closure. Use guard let or self?.method() to safely call through.
*/

// MARK: Pre-defined — fill in the marked function bodies only

class DeviceMonitor {
    var onStateChange: ((String, DeviceState) -> Void)?

    func update(device: String, to state: DeviceState) {
        // Your solution (Step 1)
        onStateChange?(device, state)
    }
}

class Dashboard {
    var currentStatus: String = "No update"

    func subscribe(to monitor: DeviceMonitor) {
        // Your solution (Step 2)
        monitor.onStateChange = { str, state in
            self.displayUpdate(device: str, state: state)
            
        }
    }

    func displayUpdate(device: String, state: DeviceState) {
        currentStatus = "\(device) → \(describe(state))"
    }
}

// MARK: Tests (Challenge 4) — uncomment as you go

let monitor = DeviceMonitor()
let dashboard = Dashboard()
dashboard.subscribe(to: monitor)
monitor.update(device: "Front Door", to: .on)
assert(dashboard.currentStatus == "Front Door → On")
monitor.update(device: "Lounge Light", to: .dimmed(level: 75))
assert(dashboard.currentStatus == "Lounge Light → Dimmed to 75%")
print("Challenge 4 passed!")
