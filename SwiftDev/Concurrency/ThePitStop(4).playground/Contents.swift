import Foundation

// Swift Dev Challenge
//
// Topic: Modern Swift Concurrency
//
// Three fundamentals:
//   Challenge 1 — async/await         basic async function + calling with await
//   Challenge 2 — async let           running async work in parallel
//   Challenge 3 — Actor               protecting shared mutable state

// Race day at the Monaco Grand Prix. The pit wall is coordinating
// tyre strategy, pulling telemetry from multiple sources at once,
// and tracking crew actions — all without stepping on each other.


// ============================================================
// MARK: - Challenge 1 (The Telemetry): async / await
// ============================================================
/*
 The pit wall needs to fetch the current tyre temperature from
 the car's sensor before making a strategy call.

 Step 1: Mark fetchTyreTemp as async and have it return an Int.
         Simulate the sensor delay with:
         try? await Task.sleep(for: .seconds(0))

 Step 2: Call fetchTyreTemp from inside the Task block below
         and print the result.

 func fetchTyreTemp() async -> Int

 Hint: a function that does async work needs a keyword before
 its return type. Calling it needs a keyword before the function name.
*/

// MARK: Pre-defined (do not modify)

let tyreTemp = 98  // degrees celsius, pre-set sensor reading

// MARK: Your solution (Challenge 1)

func fetchTyreTemp(_ delay: Int = 3) async -> Int {
    try? await Task.sleep(for: .seconds(delay))
    return tyreTemp
}

// MARK: Tests (Challenge 1) — uncomment as you go

Task {
    let temp = await fetchTyreTemp()
    assert(temp == 98)
    print("Challenge 1 passed!")
}


// ============================================================
// MARK: - Challenge 2 (Both Ends): async let
// ============================================================
/*
 The pit wall needs front AND rear tyre temperatures at the same
 time. Fetching them one after the other wastes time — they should
 be fetched in parallel.

 Both async functions are pre-defined below. Use async let to
 kick both off simultaneously, then await both results together
 and print the combined reading.

 Hint: async let starts the work immediately without waiting.
       You collect the results later when you actually need them.
*/

// MARK: Pre-defined (do not modify)

func fetchFrontTemp() async -> Int {
    try? await Task.sleep(for: .seconds(0))
    return 95
}

func fetchRearTemp() async -> Int {
    try? await Task.sleep(for: .seconds(0))
    return 102
}

// MARK: Your solution (Challenge 2)

// Write your async let code inside the Task block below

Task {
    async let front = fetchFrontTemp()
    async let rear = fetchRearTemp()
    
    let (frontTemp, rearTemp) = await (front, rear)

     assert(frontTemp == 95)
     assert(rearTemp == 102)
     print("Challenge 2 passed!")
}


// ============================================================
// MARK: - Challenge 3 (The Crew): Actor
// ============================================================
/*
 Multiple crew members are logging tyre changes simultaneously.
 If they all write to a plain class at the same time, you get a
 data race. An actor prevents that.

 Create an actor called CrewLog with:
   - A private var tyresChanged: Int starting at 0
   - func logChange() that increments tyresChanged by 1
   - func total() -> Int that returns the current count

 Hint: an actor looks a lot like a class. Accessing its methods
 from outside requires await.
*/

// MARK: Your solution (Challenge 3)
actor CrewLog {
    private var tyresChanged: Int = 0
    
    func logChange() {
        tyresChanged += 1
    }
    
    func total() -> Int {
        return tyresChanged
    }
}


// MARK: Tests (Challenge 3) — uncomment as you go

Task {
    let log = CrewLog()
    await log.logChange()
    await log.logChange()
    await log.logChange()
    let count = await log.total()
    assert(count == 3)
    print("Challenge 3 passed!")
}
