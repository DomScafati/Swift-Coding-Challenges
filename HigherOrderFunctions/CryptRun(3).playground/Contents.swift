import Foundation

// Higher Order Functions Challenge
//
// Words/phrases that signal "Higher Order Functions":
// "transform / convert each item"                      → map
// "keep only / exclude / qualifying items"             → filter
// "combine into a single value / accumulate / total"   → reduce
// "apply an operation to every element"                → map / forEach
// "produce a new collection from an existing one"      → map / compactMap / flatMap
// "flatten nested collections into one"                → flatMap

// After a messy run through the Iron Crypt, your party's scribe hands you
// a crumpled parchment — a raw log of every command issued during the crawl.
// Someone needs to make sense of the carnage. That someone is you.

// ============================================================
// MARK: - Challenge 1 (CryptRun): Parse the Battle Log
// ============================================================
/*
 The command log is a single multi-line string — one command per line.
 Each command starts with a verb (attack, cast, pickup), followed by a
 target word, and zero or more flags in --key value format, like:

     attack goblin --damage 8 --weapon dagger
     cast fireball --power 10 --target goblin
     pickup shield

 Implement the four functions below. They build on the same idea, so
 read them in order before you start.

 // Returns every line from `log` whose first word matches `verb`.
 func lines(startingWith verb: String, in log: String) -> [String]

 // Returns the integer value of a named flag in a single command string,
 // or nil if the flag isn't present or its value can't be parsed as an Int.
 func flagValue(named flag: String, in command: String) -> Int?

 // Returns the sum of all --damage values found across all attack commands.
 func totalAttackDamage(in log: String) -> Int

 // Returns the distinct targets of a given verb — the first word after the
 // verb on each matching line. No duplicates; order does not matter.
 func targets(ofVerb verb: String, in log: String) -> [String]

 Hint: a command is just a sequence of words — once you split on whitespace,
 flags and their values are sitting right next to each other.
 */

// MARK: Pre-defined (do not modify)

let commandLog = """
attack goblin --damage 8 --weapon dagger
cast heal --power 5 --target self
attack skeleton --damage 12 --weapon sword
pickup gold --amount 30
attack goblin --damage 6 --weapon dagger
cast fireball --power 10 --target goblin
attack troll --damage 20 --weapon axe
cast heal --power 8 --target self
pickup shield
attack skeleton --damage 14 --weapon sword
"""

// MARK: Your solution (Challenge 1)


// Returns every line from `log` whose first word matches `verb`.
func lines(startingWith verb: String, in log: String) -> [String] {
    return log
        .components(separatedBy: "\n")
        .filter { $0.hasPrefix(verb + " ") }
}

// Returns the integer value of a named flag in a single command string,
// or nil if the flag isn't present or its value can't be parsed as an Int.
func flagValue(named flag: String, in command: String) -> Int? {
    let parts = command.components(separatedBy: " ")
    guard let index = parts.firstIndex(of: flag), index + 1 < parts.count else { return nil }
    
    return Int(parts[index + 1])
}


// Returns the sum of all --damage values found across all attack commands.
func totalAttackDamage(in log: String) -> Int {
    return lines(startingWith: "attack", in: log)
           .compactMap { flagValue(named: "--damage", in: $0) }
           .reduce(0) { $0 + $1 }
}

// Returns the distinct targets of a given verb — the first word after the
// verb on each matching line. No duplicates; order does not matter.
func targets(ofVerb verb: String, in log: String) -> [String] {
    var distinctTargets = Set<String>()
    var targetLines = lines(startingWith: verb, in: log)
    
    var finished = targetLines
        .forEach { line  in
            var parts = line.components(separatedBy: " ")
            distinctTargets.insert(parts[1])
        }
    
    return Array(distinctTargets)
}


// MARK: Tests (Challenge 1) — uncomment as you go

assert(lines(startingWith: "attack", in: commandLog).count == 5)
assert(lines(startingWith: "cast", in: commandLog).count == 3)
assert(lines(startingWith: "pickup", in: commandLog).count == 2)
assert(flagValue(named: "--damage", in: "attack goblin --damage 8 --weapon dagger") == 8)
assert(flagValue(named: "--power", in: "cast fireball --power 10 --target goblin") == 10)
assert(flagValue(named: "--missing", in: "attack goblin --damage 8") == nil)
assert(totalAttackDamage(in: commandLog) == 60)
assert(targets(ofVerb: "attack", in: commandLog).sorted() == ["goblin", "skeleton", "troll"])
assert(targets(ofVerb: "cast", in: commandLog).sorted() == ["fireball", "heal"])
print("Challenge Complete")
