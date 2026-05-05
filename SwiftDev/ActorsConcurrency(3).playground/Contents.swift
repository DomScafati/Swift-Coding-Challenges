import Foundation
import PlaygroundSupport

PlaygroundPage.current.needsIndefiniteExecution = true

// ============================================================
// MARK: - Challenge 1 (Easy): Defining and Using an Actor
// ============================================================
/*
 Task: Implement a thread-safe counter using an actor.

 Actors protect their stored properties from concurrent access —
 any read or mutation from outside the actor requires await.

 Do NOT modify the test Task below.

 Requirements:
 Define an actor called Counter with:
   - A private(set) var value: Int starting at 0
   - A method increment() that adds 1 to value
   - A method reset() that sets value back to 0
 */

// MARK: Pre-defined (do not modify)

// (No pre-defined types — you define the actor below)

// MARK: Your solution (Challenge 1)

actor Counter {
    private(set) var value: Int = 0
    
    func increment() {
        self.value += 1
    }
    
    func reset() {
        self.value = 0
    }
}


// MARK: Tests (Challenge 1) — uncomment as you go

Task {
    let counter = Counter()
    await counter.increment()
    await counter.increment()
    await counter.increment()
    let valueAfterIncrements = await counter.value
    assert(valueAfterIncrements == 3)
    await counter.reset()
    let valueAfterReset = await counter.value
    assert(valueAfterReset == 0)
    print("Challenge 1 passed!")
}


// ============================================================
// MARK: - Challenge 2 (Easy): async let — Parallel Fetching
// ============================================================
/*
 Task: Use async let to run two async functions concurrently,
 then combine their results into a PlayerProfile.

 async let starts both tasks at the same time rather than
 waiting for one to finish before starting the other.
 You must await the bindings before using their values.

 Do NOT modify fetchUsername(), fetchHighScore(), or PlayerProfile.

 Requirements:
 Implement func loadProfile() async -> PlayerProfile
   - Use async let to call fetchUsername() and fetchHighScore() in parallel
   - Return a PlayerProfile assembled from both results
 */

// MARK: Pre-defined (do not modify)

struct PlayerProfile {
    let username: String
    let highScore: Int
}

func fetchUsername() async -> String { "AcePlayer" }
func fetchHighScore() async -> Int { 4200 }

// MARK: Your solution (Challenge 2)

func loadProfile() async -> PlayerProfile {
    async let username = fetchUsername()
    async let highScore = fetchHighScore()

    return await PlayerProfile(username: username, highScore: highScore)
}


// MARK: Tests (Challenge 2) — uncomment as you go

Task {
    let profile = await loadProfile()
    assert(profile.username == "AcePlayer", "username mismatch")
    assert(profile.highScore == 4200, "highScore mismatch")
    print("Challenge 2 passed!")
}


// ============================================================
// MARK: - Challenge 3 (Easy): withTaskGroup — Concurrent Processing
// ============================================================
/*
 Task: Use withTaskGroup to process an array of scores concurrently.

 withTaskGroup(of:) lets you spawn child tasks and collect their
 results. Add one child task per item using group.addTask { },
 then iterate over the group with for await to gather results.

 Do NOT modify grade() or the test Task below.

 Requirements:
 Implement func gradeAll(_ scores: [Int]) async -> [String]
   - For each score in scores, add a child task that calls grade(score)
   - Collect all returned strings and return them as an array
   - The returned array does NOT need to match the original order
 */

// MARK: Pre-defined (do not modify)

func grade(_ score: Int) async -> String {
    if score >= 90 { return "A" }
    if score >= 80 { return "B" }
    if score >= 70 { return "C" }
    return "F"
}

// MARK: Your solution (Challenge 3)

func gradeAll(_ scores: [Int]) async -> [String] {
    var array = [String]()
    await withTaskGroup(of: String.self) { group in
        for score in scores {
            group.addTask {
               return await grade(score)
            }
        }
        
        for await str in group {
            array.append(str)
        }
    }
    return array
}

// MARK: Tests (Challenge 3) — uncomment as you go

Task {
    let results = await gradeAll([95, 83, 71, 60])
    assert(results.sorted() == ["A", "B", "C", "F"])
    print("Challenge 3 passed!")
}
