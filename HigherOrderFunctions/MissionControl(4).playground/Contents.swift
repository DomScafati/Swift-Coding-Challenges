import UIKit

// MARK: - Mission Control
//
// You're an engineer at a space agency. Each mission is given a fuel budget
// and a list of commands that adjust it over time. Your job is to process
// the command list and return the final fuel level.
//
// Each line in the command string is one of the following:
//
//   ADD n      — increase fuel by n
//   BURN n     — decrease fuel by n
//   DOUBLE     — double the current fuel level
//   RESET      — set fuel back to 0
//
// Rules:
// - Start with a fuel level of 0
// - Process commands top to bottom
// - Ignore any lines that are empty or unrecognized
// - Fuel can go negative (a BURN can exceed current fuel)

// MARK: - Your function


func finalFuelLevel(from commands: String) -> Int {
    let validCommands = Set(["ADD","DOUBLE","BURN","RESET"])
      var fuel = 0
      let lines = commands.components(separatedBy: "\n")
          .filter { !$0.isEmpty }
          .filter { line in
              let cmd = line.components(separatedBy: " ")[0]
              return validCommands.contains(cmd)
              
          }
      for line in lines {
          let parts = line.components(separatedBy: " ")
          let cmd = parts[0]
          if cmd == "ADD", let amt = Int(parts[1]) {
              fuel += amt
          } else if cmd == "BURN", let amt = Int(parts[1]) {
              fuel -= amt
          } else if cmd == "DOUBLE" {
              fuel *= 2
          } else if cmd == "RESET" {
              fuel = 0
          }
          // anything else is ignored
      }
      return fuel
  }

// MARK: - Test Cases

// Test 1
let mission1 = """
ADD 100
BURN 30
ADD 50
"""
// Expected output: 120

// Test 2
let mission2 = """
ADD 200
DOUBLE
BURN 50
RESET
ADD 10
"""
// Expected output: 10

// Test 3
let mission3 = """
ADD 40
BURN 100
DOUBLE
"""
// Expected output: -120

// Test 4 — edge case: garbage lines mixed in
let mission4 = """
ADD 60
LAUNCH
UNKNOWN 999
BURN 20
"""
// Expected output: 40

finalFuelLevel(from: mission1)
finalFuelLevel(from: mission2)
finalFuelLevel(from: mission3)
finalFuelLevel(from: mission4)

// MARK: - Hints
//
// 1. Split the string into lines with .components(separatedBy: "\n")
// 2. Filter out empty lines
// 3. For each line, split by " " to get the command and (optionally) a value
// 4. Use if/else or a switch on the command word to decide what to do
// 5. Keep a running var fuel = 0 and update it per command
