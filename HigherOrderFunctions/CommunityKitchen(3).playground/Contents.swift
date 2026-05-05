import Foundation

// Higher Order Functions Challenge
//
// Words/phrases that signal "Higher Order Functions":
// "transform / convert each item"                      → map
// "keep only / exclude / qualifying items"             → filter
// "combine into a single value / accumulate / total"   → reduce
// "apply an operation to every element"                → map / forEach
// "produce a new collection from an existing one"      → map / compactMap / flatMap

// You've joined the dev team for a community kitchen app.
// The kitchen hosts weekly events and needs tools to manage
// their growing recipe catalogue and meal planning.

// ============================================================
// MARK: - Challenge 1: Dietary Filter
// ============================================================
/*
 Story: Guests at the next event have different dietary needs.
 You need to filter the recipe catalogue to only show recipes
 that match a requested dietary tag.

 Task: Given a tag and a list of recipes, return only the recipes
 whose tags array contains that tag.

 Requirements:
 1. Implement: func filteredRecipes(tag: String, from list: [Recipe]) -> [Recipe]
    - Return recipes where tags contains the given tag
    - Preserve the original order
 */

// MARK: Pre-defined (do not modify)

struct Recipe {
    let name: String
    let tags: [String]
    let servings: Int
    let caloriesPerServing: Int
}

let recipeList: [Recipe] = [
    Recipe(name: "Lentil Soup",      tags: ["vegan", "gluten-free"], servings: 4, caloriesPerServing: 210),
    Recipe(name: "Cheese Omelette",  tags: ["vegetarian"],           servings: 1, caloriesPerServing: 340),
    Recipe(name: "Pasta Primavera",  tags: ["vegetarian"],           servings: 2, caloriesPerServing: 380),
    Recipe(name: "Black Bean Bowl",  tags: ["vegan", "gluten-free"], servings: 3, caloriesPerServing: 290),
    Recipe(name: "Chicken Wrap",     tags: [],                       servings: 1, caloriesPerServing: 450),
]

// MARK: Your solution (Challenge 1)

func filteredRecipes(tag: String, from list: [Recipe]) -> [Recipe] {
    let new = list.filter { recipe in
        if recipe.tags.contains(tag) {
            return true
        } else {
            return false
        }
    }
    return new
}

// MARK: Tests (Challenge 1) — uncomment as you go

let veganOptions = filteredRecipes(tag: "vegan", from: recipeList)
assert(veganOptions.count == 2)
assert(veganOptions.map { $0.name } == ["Lentil Soup", "Black Bean Bowl"])

let glutenFree = filteredRecipes(tag: "gluten-free", from: recipeList)
assert(glutenFree.count == 2)

let noMatch = filteredRecipes(tag: "meat", from: recipeList)
assert(noMatch.isEmpty)

print("Challenge 1 passed!")


// ============================================================
// MARK: - Challenge 2: Scale Ingredients
// ============================================================
/*
 Story: A volunteer wants to cook Lentil Soup for a different number
 of guests than the recipe was written for. Help them scale each
 ingredient amount up or down proportionally.

 Task: Given a list of ingredients and a serving conversion, return
 a new list with each amount scaled.

 Requirements:
 1. Implement: func scale(_ ingredients: [Ingredient], from originalServings: Int, to targetServings: Int) -> [Ingredient]
    - Produce a new array by scaling each ingredient's amount:
      newAmount = amount * (Double(targetServings) / Double(originalServings))
    - Round each result to 2 decimal places using:
      (value * 100).rounded() / 100
    - All other fields (name, unit) remain unchanged
 */

// MARK: Pre-defined (do not modify)

struct Ingredient {
    let name: String
    var amount: Double
    let unit: String
}

let soupIngredients: [Ingredient] = [
    Ingredient(name: "Red lentils", amount: 1.0, unit: "cup"),
    Ingredient(name: "Broth",       amount: 4.0, unit: "cups"),
    Ingredient(name: "Cumin",       amount: 0.5, unit: "tsp"),
]

// MARK: Your solution (Challenge 2)

func scale(_ ingredients: [Ingredient], from originalServings: Int, to targetServings: Int) -> [Ingredient] {
    
    var new: [Ingredient] = ingredients.compactMap { ingredient in
        let newAmount = ingredient.amount * (Double(targetServings) / Double(originalServings))
        var newIngredient = ingredient
        newIngredient.amount = (newAmount * 100).rounded() / 100
        return newIngredient
    }
    return new
}

// MARK: Tests (Challenge 2) — uncomment as you go

let halved = scale(soupIngredients, from: 4, to: 2)
assert(halved[0].amount == 0.5)
assert(halved[1].amount == 2.0)
assert(halved[2].amount == 0.25)
assert(halved.map { $0.name } == ["Red lentils", "Broth", "Cumin"])

let doubled = scale(soupIngredients, from: 4, to: 8)
assert(doubled[0].amount == 2.0)
assert(doubled[1].amount == 8.0)

print("Challenge 2 passed!")


// ============================================================
// MARK: - Challenge 3: Meal Plan Calories
// ============================================================
/*
 Story: The kitchen coordinator is reviewing tomorrow's meal plan —
 a list of recipes paired with how many servings will be prepared.
 They want to know the total calorie count across the whole plan.

 Task: Given a meal plan and the full recipe catalogue, return the
 total calories for the plan.

 Requirements:
 1. Implement: func totalCalories(for plan: [(recipeName: String, servings: Int)], in catalogue: [Recipe]) -> Int
    - For each plan entry, find the matching Recipe in catalogue by name
    - Multiply caloriesPerServing × servings and add to the running total
    - Skip any entry whose name is not found in the catalogue
 */

// MARK: Pre-defined (do not modify)

// recipeList defined above

let mealPlan: [(recipeName: String, servings: Int)] = [
    (recipeName: "Lentil Soup",     servings: 2),
    (recipeName: "Black Bean Bowl", servings: 1),
    (recipeName: "Cheese Omelette", servings: 1),
    (recipeName: "Mystery Stew",    servings: 3),  // not in catalogue — skip
]

// MARK: Your solution (Challenge 3)

func totalCalories(for plan: [(recipeName: String, servings: Int)], in catalogue: [Recipe]) -> Int {
    var totalCalories = 0
    
    for (name, servings) in plan {
        catalogue.filter { recipe in
            if recipe.name == name {
                return true
            } else {
                return false
            }
        }.forEach { recipe in
            totalCalories += (recipe.caloriesPerServing * servings)
        }
    }
    
    return totalCalories
}

// MARK: Tests (Challenge 3) — uncomment as you go

// Lentil Soup:     2 × 210 = 420
// Black Bean Bowl: 1 × 290 = 290
// Cheese Omelette: 1 × 340 = 340
// Total:                     1050
assert(totalCalories(for: mealPlan, in: recipeList) == 1050)
assert(totalCalories(for: [], in: recipeList) == 0)
assert(totalCalories(for: [(recipeName: "Mystery Stew", servings: 5)], in: recipeList) == 0)

print("Challenge 3 passed!")
