import UIKit

// Create a function that takes a multi-line input string. Each line has a song ID followed by a play count. return a list of the top 3 most played songs.

func topThreeSongs(from input: String) -> [String] {
    return input
        .components(separatedBy: "\n")   // split into lines
        .filter { !$0.isEmpty }          // drop empty lines
        .compactMap { line -> (id: String, plays: Int)? in
            let parts = line.components(separatedBy: " ")  // split each line by space
            guard parts.count == 2, let plays = Int(parts[1]) else { return nil }  // safely cast play count
            return (id: parts[0], plays: plays)
        }
        .sorted { $0.plays > $1.plays }  // sort descending by play count
        .prefix(3)                        // take top 3
        .map { $0.id }                       // convert ArraySlice to Array
}

// Test
let input = """

1001 50
1002 51
1003 30
1004 17

"""

let result = topThreeSongs(from: input)
print(result) // [(id: "1002", plays: 51), (id: "1001", plays: 50), (id: "1003", plays: 30)]
