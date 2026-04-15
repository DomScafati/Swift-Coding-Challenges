import UIKit

func countDuplicates(_ array: [Int]) -> Int? {
    if array.isEmpty { return nil }
    
    let organizedArray = array.sorted()
    
    var leftPointer = 0
    var rightPointer = 0
    
    var mostDuplicatedNumber: Int?
    var highestCount = 1
    
    while leftPointer < organizedArray.count {
        // move rightPointer forward while values match
        while rightPointer < organizedArray.count &&
              organizedArray[rightPointer] == organizedArray[leftPointer] {
            rightPointer += 1
        }
        
        let count = rightPointer - leftPointer
        
        if count > highestCount {
            highestCount = count
            mostDuplicatedNumber = organizedArray[leftPointer]
        }
        
        leftPointer = rightPointer
    }
    
    return mostDuplicatedNumber
}

let arrayA = [1,2,3,4,5,6,7,8,9]
let arrayB = [1,4,7,10,13,16,19,22,100, 100]
let arrayC = [2,4,10,9,8,4,1, 10, 10]

print(countDuplicates(arrayA)) // none
print(countDuplicates(arrayB)) // 100
print(countDuplicates(arrayC)) // 10

