import UIKit

// You're a DJ. You receive an unsorted list of song genre tags (String) and a number (Int). Return the genres that appear in the playlist more than that number of times.

func checkThresholdAmount(_ list: [String], threshhold: Int) -> Set<String> {
    var returnSet = Set<String>()
    var dict = [String:Int]()
    
    // get the counts
    for genre in list {
        dict[genre, default: 0] += 1
        if dict[genre]! > threshhold {
            returnSet.insert(genre)
        }
    }
    
    return returnSet
}


let genres1 = ["pop", "rock", "pop", "jazz", "rock", "pop", "classical"]
let threshold1 = 2
checkThresholdAmount(genres1, threshhold: threshold1)
// expected output: ["pop"]

let genres2 = ["hip-hop", "pop", "hip-hop", "pop", "jazz", "hip-hop"]
let threshold2 = 1
checkThresholdAmount(genres2, threshhold: threshold2)
// expected output: ["hip-hop", "pop"]

let genres3 = ["rock", "jazz", "classical"]
let threshold3 = 1
checkThresholdAmount(genres3, threshhold: threshold3)
// expected output: []
