import UIKit

// You're a parking attendant. You receive an unsorted log of car license plates (String) as they enter and exit. A plate appearing twice means the car has left. Return the first plate that never left.

func firstAvailable(_ log: [String]) -> String? {
    var dict = [String:Int]()
    
    for plate in log {
        dict[plate, default: 0] += 1
    }
    
    for plate in log {
        if dict[plate]! < 2 {
            return plate
        }
    }
    return nil
}

let log = ["A", "B", "A", "C", "B", "D"]
firstAvailable(log)
// expected output: "C"
