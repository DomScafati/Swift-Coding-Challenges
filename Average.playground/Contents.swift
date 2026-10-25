import UIKit

class RunningAverage {
    private var allNums = [Int]()
    var lock = NSLock()
    
    func getAverage() -> Int {
        let total = allNums.reduce(0) { partialResult, currentNum in
            return partialResult + currentNum
        }
        
        if total == 0 {
            return total
        } else {
            return total / allNums.count
        }
    }
    
    func add(_ num: Int) {
        lock.lock()
        allNums.append(num)
        lock.unlock()
    }
}

// Example 1
var ra = RunningAverage()
ra.add(1)
ra.add(2)
ra.add(3)
print(ra.getAverage()) // Output: 2.0

// Example 2
ra = RunningAverage()
ra.add(5)
ra.add(10)
print(ra.getAverage()) // Output: 7.5
// Note: Int values cannot have a floating point. in swift Int simply drops every value after 7.
ra.add(15)
print(ra.getAverage()) // Output: 10.0

// Example 3
ra = RunningAverage()
print(ra.getAverage()) // Output: 0.0

//Explanation:
// for `getAveratge()`I used a higherOrderFunction .reduce to get a running total of all values in `allNums` and then simply divide the total value by the amount of values.
// For shared mutable state, i used an `NSLock()` object to prevent data races.
