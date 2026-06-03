import Foundation

// Concurrency Challenge
//
// Phrases/patterns that signal "TaskGroup / async-await":
// "fetch / load multiple items at the same time"      → withTaskGroup
// "run these in parallel and collect results"         → withTaskGroup
// "wait for all of them to finish"                    → TaskGroup iteration / await
// "launch N async tasks and gather their output"      → withTaskGroup
// "do these concurrently, then process the results"   → withTaskGroup

// You're the night-shift operator at a hilltop observatory.
// A bank of radio telescopes scans for signals from deep space.
// Instead of querying each telescope one at a time, you dispatch
// them all at once and collect whatever comes back.

// ============================================================
// MARK: - Challenge 1 (Signal Sweep): Collect All Readings
// ============================================================
/*
 Each telescope has an ID and can be queried for its current signal
 reading. The readings take a moment to arrive — simulate this with
 the async helper below. Your job is to dispatch all telescope IDs
 concurrently using a TaskGroup and gather every reading into a
 single array.

 The order of results in the returned array does not need to match
 the order of the input IDs.

 Implement:
     func sweepAll(telescopeIDs: [Int]) async -> [Double]

 Hint: use `withTaskGroup(of: Double.self)` and add one child task per ID.
 */

// MARK: Pre-defined (do not modify)

func fetchReading(for telescopeID: Int) async -> Double {
    // Simulates a short async delay per telescope
    try? await Task.sleep(nanoseconds: UInt64(10_000_000 * (telescopeID % 4 + 1)))
    return Double(telescopeID) * 1.5
}

let allIDs = [1, 2, 3, 4, 5]   // expected readings: 1.5, 3.0, 4.5, 6.0, 7.5

// MARK: Your solution (Challenge 1)

func sweepAll(telescopeIDs: [Int]) async -> [Double] {
    var results = [Double]()

    await withTaskGroup(of: Double.self) { group in
            telescopeIDs.forEach { id in
                group.addTask {
                   return await fetchReading(for: id)
                }
            }
        

        for await result in group {
            results.append(result)
        }
        
    }
    
    return results
}

// MARK: Tests (Challenge 1) — uncomment as you go

Task {
    let results = await sweepAll(telescopeIDs: allIDs)
    assert(results.sorted() == [1.5, 3.0, 4.5, 6.0, 7.5], "Expected all five readings")
    print("Challenge 1 passed!")
}


// ============================================================
// MARK: - Challenge 2 (Strong Signals): Filter While Collecting
// ============================================================
/*
 The observatory only logs telescopes whose reading clears a minimum
 threshold — weak signals are noise. Query all telescopes concurrently
 the same way as before, but this time only keep readings that are
 strictly greater than the given threshold.

 Return the passing readings as an array (any order is fine).

 Implement:
     func sweepStrong(telescopeIDs: [Int], threshold: Double) async -> [Double]

 Hint: inside the group, you can decide what to add to your results
 array — you don't have to keep every value the task returns.
 */

// MARK: Pre-defined (do not modify)

let mixedIDs = [1, 2, 3, 4, 5, 6]
// readings:   1.5, 3.0, 4.5, 6.0, 7.5, 9.0
// threshold 4.0 → keep: 4.5, 6.0, 7.5, 9.0

// MARK: Your solution (Challenge 2)
func sweepStrong(telescopeIDs: [Int], threshold: Double) async -> [Double] {
    var array = [Double]()
    await withTaskGroup(of: Double.self) { group in
        for id in telescopeIDs {
            group.addTask {
                return await fetchReading(for: id)
            }
        }
        
        for await tmp in group {
            if tmp >= threshold {
                array.append(tmp)
            }
        }
    }
    return array
}

// MARK: Tests (Challenge 2) — uncomment as you go

Task {
    let strong = await sweepStrong(telescopeIDs: mixedIDs, threshold: 4.0)
    assert(strong.sorted() == [4.5, 6.0, 7.5, 9.0], "Expected readings above 4.0")
    print("Challenge 2 passed!")
}
