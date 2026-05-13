import Foundation

// Swift Dev Challenge — Property Observers & Lazy Properties
//
// When to reach for these:
// "automatically react when a value changes"        → didSet
// "know what the value was before it changed"       → didSet gives you oldValue
// "inspect or log the incoming value"               → willSet gives you newValue
// "expensive to compute, only needed sometimes"     → lazy var (runs once, then cached)
// "a side-effect should follow every assignment"    → didSet

// It's quiz night at The Crown. The host tracks live scores on a laptop,
// ranks shift automatically as answers come in, and player profile cards
// are only generated when someone makes the podium.


// ============================================================
// MARK: - Challenge 1 (Round One): didSet
// ============================================================
/*
 Implement a class ScoreTracker with three properties:
   var score: Int       — starts at 0
   var rank: String     — starts at "Bronze"
   var history: [Int]   — starts empty

 Add a didSet to score so that every time score is assigned:
   - rank updates: "Gold" if score >= 50, "Silver" if score >= 25, "Bronze" otherwise
   - the new score value is appended to history

 Hint: didSet runs after the new value is already stored — just read self.score.
 */

// MARK: Pre-defined (do not modify)
// (no pre-defined data for this challenge — write ScoreTracker below)

// MARK: Your solution (Challenge 1)

class ScoreTracker {
    var score: Int = 0 {
        didSet {
            history.append(score)
            if score >= 50 {
                rank = "Gold"
            } else if score >= 25 {
                rank = "Silver"
            } else {
                rank = "Bronze"
            }
        }
    }

    var rank: String  = "Bronze"
    var history: [Int] = []
}

// MARK: Tests (Challenge 1) — uncomment as you go

 let tracker = ScoreTracker()
 tracker.score = 10
 assert(tracker.rank == "Bronze")
 assert(tracker.history == [10])
 tracker.score = 30
 assert(tracker.rank == "Silver")
 tracker.score = 55
 assert(tracker.rank == "Gold")
 assert(tracker.history == [10, 30, 55])
 print("Challenge 1 passed!")


// ============================================================
// MARK: - Challenge 2 (The Podium): lazy var
// ============================================================
/*
 Implement a class PlayerProfile with these stored properties:
   let name: String
   let totalGames: Int
   let winRate: Double     — a value between 0.0 and 1.0

 Add a lazy var badge: String that builds this formatted string:
   "[name] — [totalGames] games, [winRate as a whole %]% win rate"
   e.g. "Priya — 42 games, 73% win rate"

 badge must be a lazy var, not a computed property.
 Hint: Int(winRate * 100) converts to a whole-number percentage.
 */

// MARK: Pre-defined (do not modify)
// (no pre-defined data for this challenge — write PlayerProfile below)

// MARK: Your solution (Challenge 2)

class PlayerProfile {
    let name: String
    let totalGames: Int
    let winRate: Double
    
    lazy var badge: String = {
        let percentageWR = Int(winRate * 100)
        
        return "\(name) — \(totalGames) games, \(percentageWR)% win rate"
    }()
    
    init(name: String, totalGames: Int, winRate: Double) {
        self.name = name
        self.totalGames = totalGames
        self.winRate = winRate
    }
}


// MARK: Tests (Challenge 2) — uncomment as you go

 var profile = PlayerProfile(name: "Priya", totalGames: 42, winRate: 0.73)
 assert(profile.badge == "Priya — 42 games, 73% win rate")
 var profile2 = PlayerProfile(name: "Dom", totalGames: 10, winRate: 0.50)
 assert(profile2.badge == "Dom — 10 games, 50% win rate")
 print("Challenge 2 passed!")


// ============================================================
// MARK: - Challenge 3 (Streak Watch): willSet + didSet
// ============================================================
/*
 Implement a class StreakCounter with these properties:
   var streak: Int          — starts at 0
   var previousStreak: Int  — starts at 0
   var lastChange: Int      — starts at 0

 Add both observers to streak:
   - willSet: save the current streak into previousStreak before it changes
              (inside willSet, the old value is still in self.streak — newValue is coming in)
   - didSet:  set lastChange to (streak - oldValue)

 Hint: willSet gives you newValue. didSet gives you oldValue.
 You don't need newValue or oldValue here — just read self.streak at the right moment.
 */

// MARK: Pre-defined (do not modify)
// (no pre-defined data for this challenge — write StreakCounter below)

// MARK: Your solution (Challenge 3)

class StreakCounter {
    var streak: Int = 0 {
        willSet { newValue
            previousStreak = self.streak
        }
        
        didSet { oldValue
            self.lastChange = self.streak - oldValue
        }
    }
    var previousStreak: Int = 0
    var lastChange: Int = 0
}

// MARK: Tests (Challenge 3) — uncomment as you go

 let counter = StreakCounter()
 counter.streak = 5
 assert(counter.previousStreak == 0)
 assert(counter.lastChange == 5)
 counter.streak = 8
 assert(counter.previousStreak == 5)
 assert(counter.lastChange == 3)
 counter.streak = 2
 assert(counter.previousStreak == 8)
 assert(counter.lastChange == -6)
 print("Challenge 3 passed!")
