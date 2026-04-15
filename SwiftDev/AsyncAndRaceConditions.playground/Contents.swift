import PlaygroundSupport
import SwiftUI
import UIKit
import Foundation

// Runs one task that waits 1 second between prints.
// This is simple async work, but not a race-condition example,
// because only one task is touching its own local values.
func delayedTimer() async {
    for i in 1...5 {
        try? await Task.sleep(for: .seconds(1))
        print(i)
    }
    print("Printing done")
}

// Runs one task with a random delay.
// This can help simulate unpredictable network timing,
// but by itself it still does not create a race condition.
// A race needs multiple tasks overlapping while touching shared state.
func delayedTimerRandom() async {
    let rng = Int.random(in: 1...10)
    for _ in 1...5 {
        try? await Task.sleep(for: .seconds(rng))
    }
}

// Uses a task group to run several async tasks at the same time.
// This creates concurrency, but not automatically a race condition.
// These child tasks do not share mutable state, so they are overlapping safely.
func raceCondition() async {
    await withTaskGroup(of: Void.self) { group in
        for _ in 1...5 {
            group.addTask {
                await delayedTimerRandom()
            }
        }
    }
}

// This is the intentionally unsafe example.
// Problem:
// - many child tasks run at the same time
// - they all mutate the same UnsafeCache instance
// - UnsafeCache is a plain class with mutable shared state
//
// Result:
// - this can create a real shared-state race
// - dictionary mutation from multiple concurrent tasks is unsafe
//
// Note:
// - @unchecked Sendable on UnsafeCache only suppresses compiler protection
// - it does NOT make the code actually safe
func timerA() async {
    let unsafeCache = UnsafeCache<String>()
    await withTaskGroup(of: Void.self) { group in
        for i in 1...10 {
            group.addTask {
                unsafeCache.add("value: \(i)", for: "key: \(i)")
            }
        }
    }
    print(unsafeCache.dump())
}

// This is a safer *structure* even though it still uses UnsafeCache.
// Why it is safer:
// - the first task group is awaited completely
// - only after it finishes does the second task group begin
// - that means there is no overlap between the two groups
//
// Important:
// - this avoids concurrent access here because the work is serialized
// - but UnsafeCache itself is still not thread-safe in general
// - if two callers used the same UnsafeCache concurrently elsewhere, it would still be unsafe
func timerB() async {
    let unsafeCache = UnsafeCache<String>()

    await withTaskGroup(of: Void.self) { group in
        group.addTask {
            unsafeCache.add("A", for: "1")
        }
    }

    await withTaskGroup(of: Void.self) { group in
        group.addTask {
            unsafeCache.add("B", for: "2")
        }
    }

    print(unsafeCache.dump())
}

// Intentionally unsafe shared mutable storage.
// Problems:
// - class instances are reference types, so many tasks can share one instance
// - box is mutable shared state
// - there is no actor isolation, lock, or serialization protecting it
//
// @unchecked Sendable tells Swift:
// "trust me, I know this can cross concurrency boundaries safely"
//
// In this example that trust is false, and that is the point:
// this class is useful for demonstrating what unsafe shared mutation looks like.
final class UnsafeCache<T>: @unchecked Sendable {
    private var box: [String: T] = [:]
    
    func get(for key: String) -> T? {
        guard let value = self.box[key] else {
            return nil
        }
        return value
    }
    
    func add(_ value: T, for key: String) {
        self.box[key] = value
    }
    
    func clear() {
        self.box = [:]
    }
    
    func remove(for key: String) {
        self.box.removeValue(forKey: key)
    }
    
    func dump() -> [String: T] {
        return self.box
    }
}

// Safe cache using actor isolation.
// What this solves:
// - only one task can access actor-isolated state at a time
// - reads and writes to box are serialized by the actor
// - this prevents data races on the dictionary
//
// Important:
// - actor safety prevents shared-state data races
// - it does NOT automatically solve higher-level logic issues
//   like stale network responses or "which write should win"
actor Cache<T> {
    private var box: [String: T] = [:]
    
    func get(for key: String) -> T? {
        guard let value = self.box[key] else {
            return nil
        }
        return value
    }
    
    func add(_ value: T, for key: String) {
        self.box[key] = value
    }
    
    func clear() {
        self.box = [:]
    }
    
    func remove(for key: String) {
        self.box.removeValue(forKey: key)
    }
    
    func dump() -> [String: T] {
        return self.box
    }
}

// Starts one async example from the Playground.
// Note:
// - your original code called timer(), but there is no timer() function
// - timerA() is the unsafe concurrent-mutation example
// - timerB() is the serialized-groups example
Task {
    await timerA()
}
