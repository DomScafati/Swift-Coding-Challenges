# Playgrounds

Personal training repo for interview-style coding challenges and Swift fundamentals. Challenges are Swift playgrounds filed by topic. The goal is for the owner to practise, so a challenge must be well-made and fair, and must not give the answer away.

## When asked for a challenge

1. **Actually create the files.** Never answer with only a chat description, an artifact, or a doc. Write the playground into the repo.
2. **The owner wants the file in the main checkout:** `/Users/dom/Documents/AppDevelopment/Playgrounds/<TopicFolder>/<StoryName>(N).playground/`, so they can open it right away. If the session runs in a git worktree and writes to the main checkout are blocked, write it in the worktree instead and say so up front, giving the full absolute path and how to get it into the main folder. Never leave the owner unable to find the file.
3. **Ask for the difficulty (1-10) if it wasn't given.** Never assume one.
4. **Look at the topic folder first.** Don't repeat a problem that already exists there.
5. **Verify before handing over** (see Verification).
6. Keep the reply short: the path, the challenge titles, and the difficulty. No long explanations.

### Topic folders
`BinarySearch/`, `BinaryTree/`, `Hashing/`, `HigherOrderFunctions/`, `LinkedList/`, `MatrixTraversal/`, `SlidingWindow/`, `Stacks/`, `TwoPointers/`, and `SwiftDev/` (Swift language topics, not algorithms). `CoreLocation/` also exists.

### Naming
`StoryName(N).playground` — the name is a short scene or story title (`TheBeacon`, `ScoutCamp`, `TheApothecary`), never a description of the algorithm. N is the difficulty (1-10).

Each playground contains `Contents.swift` and `contents.xcplayground`:

```xml
<?xml version="1.0" encoding="UTF-8" standalone="yes"?>
<playground version='7.0' target-platform='ios' swift-version='6' buildActiveScheme='true' executeOnSourceChanges='true' importAppTypes='true'/>
```

## Difficulty scale

The owner rates challenges 1-10.

- **1-4 — easy.** Classic textbook problems, one technique per challenge, usually a single pass. Gentle step from one challenge to the next. This is for building confidence.
- **5-6 — moderate.** Combines ideas or needs a real insight (for example counting occurrences with two boundary searches is about a 5).
- **7+ — advanced.**

For an easy file, choose the most conventional version of each problem. Do not pick clever variants or problems that need a trick to see.

## File layout

Copy this structure. See `BinarySearch/TheBeacon(2)` and `HigherOrderFunctions/TheApothecary(3)` for good examples.

1. `import Foundation`
2. A header block, `// <Topic> Challenge`, then `// Phrases/patterns that signal "<Topic>":` followed by 4-7 lines of `// "phrase in a problem statement" → technique/hint`, aligned in columns. (HOF files say "Words/phrases that signal".)
3. **One story, 2-4 lines of `//` comments, that frames all the challenges in the file.** Each challenge is a different scene inside the same story.
4. 2-4 challenges, easiest first. Each one is:
   ```
   // ============================================================
   // MARK: - Challenge N (Scene Title): Technique
   // ============================================================
   /*
    Prose description of the problem, in story terms. Enough to solve it
    unambiguously. State edge cases that matter (duplicates, empty input).

    func name(_ x: [Int]) -> Int

    Hint: one or two modest sentences.
   */

   // MARK: Pre-defined (do not modify)
   (test data, with the expected result in a trailing comment or an `// expected:` line)

   // MARK: Your solution (Challenge N)
   (left empty)

   // MARK: Tests (Challenge N) — uncomment as you go
   // assert(...)   // short comment saying what the case covers
   // print("Challenge N passed!")
   ```
5. Shared types used by several challenges go in a `// MARK: - Shared types (do not modify)` section (see `BinaryTree`, `LinkedList`).

### Style rules
- **Hints are modest.** One or two sentences that point at the approach without spelling out the steps. There is **no numbered "Requirements" list** (older files like `ScoutCamp(3)` have one; don't copy that).
- **Solution section is empty** and the test asserts are **commented out**, so the blank file compiles.
- Tests cover normal cases, boundaries (first/last element), and edge cases (empty, single item, no match).
- Pre-solved teaching challenges (like `TheWake(3)`) only when the owner asks.

## Content rules
- **Use the technique the way its name suggests.** Two pointers means the textbook shapes: converging from both ends, slow/fast in one list, or one pointer per sorted list for merge/intersection (two arrays are fine at any difficulty). Sliding window means a window over consecutive items. Pick problems where that technique is actually the natural tool, not a stand-in for a `Set` or `sorted()`.
- No curve balls. If the owner would be surprised that a problem is filed under the topic, pick another problem.
- No language gotchas. The challenge tests logic, not quirks like `Int` division truncation, operator order, or floating-point rounding. Use flat amounts and whole numbers, never percentages or fractions.
- No obscure protocols or APIs unless the task explains them fully.
- Prefer `[Int]` and simple types. Use strings only when the topic needs them, and then keep the string handling simple, because Swift string indexing is awkward.
- Unambiguous specs. If a test could have more than one valid answer, change the problem so the answer is unique.

## Verification (always do this)
1. Work out the expected value of **every** assert by hand against the test data. Don't trust intuition.
2. Write reference solutions into a scratch copy (use the scratchpad directory, not the repo), uncomment the tests, compile with `swiftc` and run. Every assert must pass.
3. Compile the real, blank file with `swiftc` and confirm it builds cleanly.
4. Check that the difficulty rating matches the scale above.

## Helping with a challenge
- Don't solve it unprompted. For explanations, use neutral examples unrelated to the challenge code.
- When the owner asks for the solution, give it. Show the code first, then a short explanation. No long walk-throughs: the owner has asked for short answers more than once.
- If the owner shares their attempt, point to the specific bug. Give the fix if they ask for it.

## Git
Don't commit unless asked. When asked, use the owner's message exactly as written, with no co-author footer or additions.
