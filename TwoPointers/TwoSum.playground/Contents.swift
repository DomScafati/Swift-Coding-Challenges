import UIKit
// You're a cashier at a grocery store. A customer hands you a list of item prices (Int) and a gift card balance (Int). Return the indices of the two items that together cost exactly the gift card balance, so the customer can spend it down to zero.

// sorted option, pointer on either side
func sortedTwoSum(_ prices: [Int],_ balance: Int) -> [Int] {
    let sortedPrices = prices.sorted()
    var left = 0
    var right = sortedPrices.count - 1
    
    while left < right {
        let guess = sortedPrices[left] + sortedPrices[right]
        if guess == balance {
            return [left, right]
        } else if guess < balance {
            left += 1
        } else {
            right -= 1
        }
    }
    return []
}

func unsortedTwoSum(_ prices: [Int], _ balance: Int) -> [Int] {
    var left = 0
    var right = 1
    while left < prices.count {
        while right < prices.count {
            let guess = prices[left] + prices[right]
            if guess == balance && left != right {
                return [left, right]
            }
            right += 1
        }
        right = left + 2  // reset right to always be ahead of left
        left += 1
    }
    return []
}

func hashTwoSum(_ prices: [Int], _ balance: Int) -> [Int] {
    var seen = [Int: Int]() // dictionary mapping price -> index
    
    for (index, price) in prices.enumerated() {
        let complement = balance - price // what value do we need to complete the pair?
        if let complementIndex = seen[complement] { // have we seen that value before?
            return [complementIndex, index] // if yes, we found our pair!
        }
        seen[price] = index // if no, store this price and index for later
    }
    
    return []
}

let prices1 = [3, 5, 2, 7, 4, 8]
let balance = 10
sortedTwoSum(prices1, balance)
unsortedTwoSum(prices1, balance)
//expected output: 3

