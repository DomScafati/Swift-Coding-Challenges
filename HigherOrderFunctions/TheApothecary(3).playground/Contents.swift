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

// The old alchemist who ran the Hollow Lantern apothecary has retired
// to a swamp, and left you the shop. The shelves are full, the ledger
// is a mess, and a party of adventurers arrives in an hour. Time to
// get the books in order.

// MARK: Pre-defined (do not modify)

struct Potion {
    let name: String
    let type: String
    let potency: Int
    let price: Int
    let stock: Int
}

let shelf: [Potion] = [
    Potion(name: "Healing Draught",  type: "healing", potency: 5, price: 20,  stock: 6),
    Potion(name: "Elixir of Vigor",  type: "buff",    potency: 7, price: 40,  stock: 0),
    Potion(name: "Dragonfire Tonic", type: "offense", potency: 9, price: 100, stock: 2),
    Potion(name: "Mist of Shadows",  type: "stealth", potency: 8, price: 60,  stock: 3),
    Potion(name: "Minor Healing",    type: "healing", potency: 2, price: 8,   stock: 12),
    Potion(name: "Stoneskin Brew",   type: "buff",    potency: 6, price: 32,  stock: 4),
    Potion(name: "Venom Vial",       type: "offense", potency: 8, price: 48,  stock: 0),
    Potion(name: "Gale Step",        type: "stealth", potency: 4, price: 24,  stock: 5)
]

// ============================================================
// MARK: - Challenge 1 (The Sign Board): What's In Stock
// ============================================================
/*
 Before opening, you want to chalk up a sign listing everything the
 customers can actually buy. A potion is for sale only if at least one
 bottle is left on the shelf.

 Return the names of every potion that is in stock, in the same order
 they appear on the shelf.

 func namesInStock(from potions: [Potion]) -> [String]

 Hint: one step to throw out what doesn't qualify, one step to turn
 what's left into names.
 */

// MARK: Your solution (Challenge 1)

func namesInStock(from potions: [Potion]) -> [String] {
    var tmp = potions.filter { potion in
        return potion.stock != 0
    }.map { potion in
        return potion.name
    }
    
    return tmp
}


// MARK: Tests (Challenge 1) — uncomment as you go
 assert(namesInStock(from: shelf) == ["Healing Draught", "Dragonfire Tonic", "Mist of Shadows", "Minor Healing", "Stoneskin Brew", "Gale Step"])
 assert(namesInStock(from: []) == [])
 print("Challenge 1 passed!")


// ============================================================
// MARK: - Challenge 2 (The Ledger): Shelf Value
// ============================================================
/*
 The tax collector is coming and wants to know what the shop's stock is
 worth. Every bottle of a potion sells for that potion's price, so a
 potion with a price of 20 and 6 bottles on the shelf is worth 120.

 Return the combined worth of all the bottles on the shelf.

 func shelfValue(of potions: [Potion]) -> Int

 Hint: work out each potion's worth first, then boil the whole list down
 to one number.
 */

// MARK: Your solution (Challenge 2)

func shelfValue(of potions: [Potion]) -> Int {
    var tmp = potions.reduce(0) { partialResult, potion in
        var potionTypeTotal = potion.price * potion.stock
        return partialResult + potionTypeTotal
    }
    
    return tmp
}

// MARK: Tests (Challenge 2) — uncomment as you go
 assert(shelfValue(of: shelf) == 844)
 assert(shelfValue(of: []) == 0)
 print("Challenge 2 passed!")


// ============================================================
// MARK: - Challenge 3 (The Price Hike): Rare Brews Cost More
// ============================================================
/*
 Word has spread that adventurers are coming, so you decide to raise the
 price of your stronger potions. Any potion whose potency is at least
 `minPotency` goes up by `percent` percent. The extra cost is
 `price * percent / 100` using whole-number math, so any fraction is
 dropped. Weaker potions keep their price. Nothing else about a potion
 changes.

 Return the full shelf, with every potion still in its original position
 and the new prices applied.

 func markUp(_ potions: [Potion], minPotency: Int, percent: Int) -> [Potion]

 Hint: a Potion's properties are all `let`, so you'll be building new
 Potion values rather than editing the old ones.
 */

// MARK: Your solution (Challenge 3)

func markUp(_ potions: [Potion], minPotency: Int, percent: Int) -> [Potion] {
    var tmp = potions.map { potion in
        var newPrice = potion.price
        var markupAmount = (percent * potion.price) / 100
        if potion.potency >= minPotency {
            newPrice += markupAmount
        }
        
        return Potion(name: potion.name,
                      type: potion.type,
                      potency: potion.potency,
                      price: newPrice,
                      stock: potion.stock)
    }
    return tmp
}

// MARK: Tests (Challenge 3) — uncomment as you go
 let hiked = markUp(shelf, minPotency: 8, percent: 25)
 assert(hiked.map { $0.price } == [20, 40, 125, 75, 8, 32, 60, 24])
 assert(hiked.map { $0.name } == shelf.map { $0.name })
 assert(hiked.map { $0.stock } == shelf.map { $0.stock })
 assert(shelf.map { $0.price } == [20, 40, 100, 60, 8, 32, 48, 24])
 assert(markUp(shelf, minPotency: 10, percent: 50).map { $0.price } == shelf.map { $0.price })
 print("Challenge 3 passed!")


// ============================================================
// MARK: - Challenge 4 (The Restock): Bottles By Type
// ============================================================
/*
 Your supplier delivers by category, not by potion, so you need to know
 how many bottles of each type you're holding. Every potion has a type
 such as "healing" or "stealth". A type whose potions are all sold out
 should still appear, with a count of zero.

 Return a dictionary mapping each type to the total number of bottles
 on the shelf across every potion of that type.

 func bottlesByType(in potions: [Potion]) -> [String: Int]

 Hint: reduce can build a dictionary as well as a number, and a dictionary
 lookup that misses can fall back to 0 with `?? 0`.
 */

// MARK: Your solution (Challenge 4)

func bottlesByType(in potions: [Potion]) -> [String: Int] {
    var dict = [String:Int]()
    potions.forEach { potion in
        dict[potion.type, default: 0] += potion.stock
    }
    
    return dict
}

func bottlesByTypeAlt(in potions: [Potion]) -> [String: Int] {
    let counts = potions.reduce(into: [String: Int]()) { result, potion in
        return result[potion.type, default: 0] += potion.stock
    }
    
    return counts
}

// MARK: Tests (Challenge 4) — uncomment as you go
 assert(bottlesByType(in: shelf) == ["healing": 18, "buff": 4, "offense": 2, "stealth": 8])
 assert(bottlesByType(in: shelf.filter { $0.stock == 0 }) == ["buff": 0, "offense": 0])
 assert(bottlesByType(in: []) == [:])
 print("Challenge 4 passed!")
