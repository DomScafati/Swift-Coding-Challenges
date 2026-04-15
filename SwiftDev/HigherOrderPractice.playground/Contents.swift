import UIKit

// Challenge 1 — Double It
// You have an array of numbers. Use a higher order function to return a new array where every number is doubled.

let numbers1 = [1, 2, 3, 4, 5]
numbers1.map { num in
    return num * 2
}

// Challenge 2 — Evens Only
// Filter the array down to only the even numbers.

let numbers2 = [1, 2, 3, 4, 5, 6, 7, 8]
numbers2.filter { $0 % 2 == 0 }

// Challenge 3 — Largest Number
// Find the largest number in the array.

let numbers3 = [1, 2, 3, 4, 5]
numbers3.reduce(0) { partialResult, num in
    if num > partialResult {
        return num
    }
    return partialResult
}
// Expected result: 5

// Challenge 4 — Longer than 3
// Use a higher order function to return only the words that have more than 3 characters.

let words1 = ["cat", "elephant", "ox", "bear", "dog", "hippopotamus"]
words1.filter { string in
    string.count > 3 ? true : false
}

// Expected result: ["elephant", "bear", "hippopotamus"]


// Challenge 5 — Uppercased Long Words
// Let's start chaining methods together now. Return an array of uppercased words, but only for words longer than 3 characters.

let words2 = ["cat", "elephant", "ox", "bear", "dog", "hippopotamus"]
// needs both a filter and a map
words2.filter{ $0.count > 3 }.map { $0.uppercased() }

// Expected result: ["ELEPHANT", "BEAR", "HIPPOPOTAMUS"]

// Challenge 6 — Total Character Count
// Let's chain three methods together. Find the total number of characters across all words longer than 3 characters.

let words3 = ["cat", "elephant", "ox", "bear", "dog", "hippopotamus"]
words3.filter { $0.count > 3 }.map { $0.count }.reduce(0) { partialResult, num in
    partialResult + num
}

// Expected result: 24  (elephant=8, bear=4, hippopotamus=12)
// Hint: filter → map → reduce

// Chellenge 7 - Group by First Letter
// Now you try it. Group the words by their first letter.

let words4 = ["cat", "elephant", "ox", "bear", "dog", "hippopotamus"]
Dictionary(grouping: words4) { word in
    return word.first!
}

// Expected result:
// ["c": ["cat"], "e": ["elephant"], "o": ["ox"], "b": ["bear"], "d": ["dog"], "h": ["hippopotamus"]]
//Hint: Look up Dictionary(grouping:by:) — the by part takes a closure!

// Challenge 8 — Flat Map
// This one introduces flatMap. You have a nested array and need to flatten it into a single array, with each number doubled.

let nested = [[1, 2, 3], [4, 5, 6], [7, 8, 9]]
nested.flatMap { array in
    array.map { $0 * 2 }
}
// Expected result: [2, 4, 6, 8, 10, 12, 14, 16, 18]
// Hint: flatMap both flattens and transforms in one step — think about what the closure should return!


// Challenge 9 — Sort by Last Name
// You have an array of full names. Sort them alphabetically by last name.

let names = ["Steve Rogers", "Tony Stark", "Natasha Romanoff", "Bruce Banner"]
names.sorted { str1, str2 in
    var lname1 = str1.split(separator: " ")
    var lname2 = str2.split(separator: " ")
    return lname1[1] < lname2[1]
}

// Expected result: ["Steve Rogers", "Tony Stark", "Natasha Romanoff", "Bruce Banner"]
// Sorted: ["Bruce Banner", "Steve Rogers", "Natasha Romanoff", "Tony Stark"]
// Hint: Use sorted(by:) — you'll need to extract the last name from each string inside the closure. Check out split(separator:) for splitting a string into parts!

// Challenge 10 — Top Earners
// You have an array of tuples representing employees and their salaries. Return the names of employees earning above average, sorted by salary descending.

let employees = [
    ("Alice", 120_000),
    ("Bob", 80_000),
    ("Carol", 95_000),
    ("Dave", 150_000),
    ("Eve", 60_000)
]
let total = employees.reduce(0) { $0 + $1.1 }
let average = total / employees.count
let result = employees
    .filter { $0.1 > average }
    .sorted { $0.1 > $1.1 }
    .map { $0.0 }
// Expected result: ["Dave", "Alice", "Carol"]
// Hint: You'll need reduce to calculate the average, then filter, sorted, and map — all chained together!
