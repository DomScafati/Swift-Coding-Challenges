import Foundation

// Swift Dev Challenge
//
// Topic: Closures
//
// A closure is a block of code you can pass around and call later,
// just like a function — but written inline. Two forms you'll see
// constantly:
//   1. Passed as a parameter  → the caller decides what happens
//   2. Stored as a property   → the owner calls it later (callback pattern)

// Welcome to RetroArcade — a tiny arcade cabinet that runs
// one game at a time. The cabinet doesn't know what game
// it's running; it just knows when to start and when to
// report a score.


// ============================================================
// MARK: - Challenge 1 (Insert Coin): Closure as a Parameter
// ============================================================
/*
 The arcade cabinet accepts any game as a closure. When a player
 inserts a coin, the cabinet runs whatever game was passed in and
 prints the result.

 Write a function that:
   - Takes a player name (String) and a game closure
   - The closure receives the player name and returns a score (Int)
   - The function prints: "<name> scored <score> points!"

 func insertCoin(player: String, game: (String) -> Int)

 Hint: call the closure the same way you'd call a function —
 just use the parameter name: game(player)
*/

// MARK: Pre-defined (do not modify)

let spaceInvaders: (String) -> Int = { player in
    return player.count * 100
}

let pinball: (String) -> Int = { player in
    return player.count * 250
}

// MARK: Your solution (Challenge 1)

func insertCoin(player: String, game: (String) -> Int) {
    print("\(player) scored \(game(player))")
}


// MARK: Tests (Challenge 1) — uncomment as you go

insertCoin(player: "Dom", game: spaceInvaders)  // "Dom scored 300 points!"
insertCoin(player: "Dom", game: pinball)        // "Dom scored 750 points!"
insertCoin(player: "Alex", game: spaceInvaders) // "Alex scored 400 points!"
print("Challenge 1 passed!")


// ============================================================
// MARK: - Challenge 2 (High Score): Stored Closure as a Callback
// ============================================================
/*
 The cabinet can notify an external scoreboard whenever a game ends.
 The scoreboard is wired up once, then the cabinet calls it
 automatically every time a game finishes.

 Complete the Arcade class below:
   - onGameOver is an optional closure stored as a property.
     It receives the player name and final score.
   - gameOver(player:score:) should call onGameOver if one is set,
     passing the player name and score through.

 Hint: call an optional closure the same way you optional-chain
 anything else — onGameOver?(player, score)
*/

// MARK: Pre-defined — fill in the marked function body only

class Arcade {
    var onGameOver: ((String, Int) -> Void)?

    func gameOver(player: String, score: Int) {
        // Your solution
        onGameOver?(player, score)
    }
}

// MARK: Tests (Challenge 2) — uncomment as you go

var lastPlayer = ""
var lastScore = 0

let arcade = Arcade()
arcade.onGameOver = { player, score in
    lastPlayer = player
    lastScore = score
}

arcade.gameOver(player: "Dom", score: 1500)
assert(lastPlayer == "Dom")
assert(lastScore == 1500)
arcade.gameOver(player: "Alex", score: 800)
assert(lastPlayer == "Alex")
assert(lastScore == 800)
print("Challenge 2 passed!")
