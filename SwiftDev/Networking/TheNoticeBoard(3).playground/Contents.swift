import Foundation

// Swift Dev Challenge
//
// You build a "fetch a to-do note" feature, one piece at a time:
//   1. Errors       → a TodoError enum, and code that throws it
//   2. Network      → an async function that downloads one note
//   3. Cache        → an actor that remembers notes already downloaded
//   4. Concurrency  → download several notes at the same time

// The town notice board shows to-do notes from a free test server.
// You write all the types yourself. Challenges 2, 3 and 4 use the
// real internet, so be online.
//
// The server sends one note as JSON. This is note number 1:
//
//   { "userId": 1, "id": 1, "title": "delectus aut autem", "completed": false }
//
// Its address is  baseURL + "/todos/1".  A note that doesn't exist
// (like /todos/99999) comes back with status 404.
//
// How the pieces fit together:
//
//   TodoService.todo(id:)
//     ├─ is the note in TodoCache?  → return it (no network)
//     └─ not in the cache?          → fetchTodo(id:)
//                                        ├─ download the data
//                                        ├─ checkStatus → is the reply OK?
//                                        └─ decodeTodo  → JSON becomes a Todo
//                                     → save it in TodoCache → return it
//
//   Any step can throw a TodoError.


// ============================================================
// MARK: - Shared helpers (do not modify)
// ============================================================

let baseURL = "https://jsonplaceholder.typicode.com"

/// Makes a fake reply with the given status code.
func response(_ status: Int) -> HTTPURLResponse {
    HTTPURLResponse(url: URL(string: baseURL)!, statusCode: status, httpVersion: nil, headerFields: nil)!
}

/// Runs the work and returns the error it throws, or nil.
func thrown(_ work: @Sendable () async throws -> Void) async -> Error? {
    do { try await work(); return nil } catch { return error }
}


// ============================================================
// MARK: - Challenge 1 (The Rulebook): Error Enum
// ============================================================
/*
 Goal: write the Todo type, an error enum, and two small functions
 that throw those errors.
 Everything goes in "Your solution (Challenge 1)".

 Step 1 — The model
   Make a struct called Todo that matches the JSON at the top.
   It needs id (Int), title (String) and completed (Bool).
   Make it Codable and Equatable.
   Leave out "userId". Swift ignores JSON keys you don't list.

 Step 2 — The error enum
   Make an enum called TodoError (Error and Equatable) with 4 cases:
     invalidResponse   the reply is not an HTTP reply
     notFound          the server said 404
     badStatus(Int)    any other bad status; keep the number
     decodingFailed    the JSON could not be turned into a Todo

 Step 3 — Check a reply
   func checkStatus(_ response: URLResponse) throws
   It looks at one server reply, then passes or throws:
     not an HTTPURLResponse → throw .invalidResponse
     status 200 to 299      → fine, just return
     status 404             → throw .notFound
     any other status       → throw .badStatus with that status code
   Cast with as? to get an HTTPURLResponse. That is the type that
   has the statusCode property.

 Step 4 — Decode the data
   func decodeTodo(_ data: Data) throws -> Todo
   Turn the JSON data into a Todo with JSONDecoder.
   If decoding fails, catch the error and throw .decodingFailed
   instead, so the caller only ever sees your own error type.
*/

// MARK: Your solution (Challenge 1)

struct Todo: Codable, Equatable {
    let userId: Int?
    let id: Int
    let title: String
    let isCompleted: Bool
    
    init(userId: Int? = nil,
         id: Int,
         title: String,
         completed: Bool) {
        self.userId = userId
        self.id = id
        self.title = title
        self.isCompleted = completed
    }
    
    enum CodingKeys: String, CodingKey {
        case userId, id, title
        case isCompleted = "completed"
    }
}

enum TodoError: Error, Equatable {
    case invalidResponse
    case notFound
    case badStatus(Int)
    case decodingFailed
    case invalidURL
}

func checkStatus(_ response: URLResponse) throws {
    guard let httpURLResponse = response as? HTTPURLResponse else {
        throw TodoError.invalidResponse
    }
    
    switch httpURLResponse.statusCode {
    case (200...299): return
    case 404: throw TodoError.notFound
    default: throw TodoError.badStatus(httpURLResponse.statusCode)
    }
}

func decodeTodo(_ data: Data) throws -> Todo {
    do {
        let result = try JSONDecoder().decode(Todo.self, from: data)
        return result
    } catch {
        throw TodoError.decodingFailed
    }
}

// MARK: Tests (Challenge 1) — uncomment as you go
 Task {
     var error = await thrown { try checkStatus(response(200)) }
     assert(error == nil)
     error = await thrown { try checkStatus(response(204)) }
     assert(error == nil)                                     // any 200 to 299 is fine
     error = await thrown { try checkStatus(response(404)) }
     assert(error as? TodoError == .notFound)
     error = await thrown { try checkStatus(response(500)) }
     assert(error as? TodoError == .badStatus(500))
     error = await thrown { try checkStatus(response(301)) }
     assert(error as? TodoError == .badStatus(301))           // outside 200 to 299
     error = await thrown { try checkStatus(URLResponse()) }
     assert(error as? TodoError == .invalidResponse)          // not an HTTP reply

     let json = Data(#"{"userId":1,"id":5,"title":"Buy tea","completed":true}"#.utf8)
     let todo = try? decodeTodo(json)
     assert(todo?.id == 5)
     assert(todo?.title == "Buy tea")
     let notDone = Data(#"{"userId":1,"id":5,"title":"Buy tea","completed":false}"#.utf8)
     assert(todo != (try? decodeTodo(notDone)))               // "completed" is read from the JSON
     error = await thrown { _ = try decodeTodo(Data("nope".utf8)) }
     assert(error as? TodoError == .decodingFailed)           // not JSON at all
     error = await thrown { _ = try decodeTodo(Data(#"{"id":5}"#.utf8)) }
     assert(error as? TodoError == .decodingFailed)           // fields missing
     print("Challenge 1 passed!")
 }


// ============================================================
// MARK: - Challenge 2 (The Delivery): Async Network Call
// ============================================================
/*
 Goal: download one Todo from the server.
 It goes in "Your solution (Challenge 2)". It uses your code from
 Challenge 1.

 Write this function:
   func fetchTodo(id: Int) async throws -> Todo

 What it does, in order:
   1. Build the URL: baseURL + "/todos/" + the id   (like .../todos/3)
   2. Download it with URLSession.shared.data(from:), using try await.
      It gives back a (data, response) pair.
   3. Check the reply with your checkStatus.
   4. Turn the data into a Todo with your decodeTodo, and return it.

 Why async?   It waits for the network, so callers must use await.
 Why throws?  Any step can fail. Don't catch anything in this
              function. Let the errors go up to the caller.
*/

// MARK: Your solution (Challenge 2)

func fetchTodo(id: Int) async throws -> Todo {
    var urlString = baseURL + "/todos/" + "\(id)"
    guard let url = URL(string: urlString) else {
        throw TodoError.invalidURL
    }
    
    var (data, response) = try await URLSession.shared.data(from: url)
    try checkStatus(response)
    return try decodeTodo(data)
}

// MARK: Tests (Challenge 2) — uncomment as you go
 Task {
     do {
         let first = try await fetchTodo(id: 1)
         let expected1 = try decodeTodo(Data(#"{"userId":1,"id":1,"title":"delectus aut autem","completed":false}"#.utf8))
         assert(first == expected1)                            // same as decoding the real JSON
         let fourth = try await fetchTodo(id: 4)
         let expected4 = try decodeTodo(Data(#"{"userId":1,"id":4,"title":"et porro tempora","completed":true}"#.utf8))
         assert(fourth == expected4)
         let error = await thrown { _ = try await fetchTodo(id: 99999) }
         assert(error as? TodoError == .notFound)             // the server replies 404
         print("Challenge 2 passed!")
     } catch {
         print("Challenge 2 failed: \(error)")
     }
 }


// ============================================================
// MARK: - Challenge 3 (The Pinboard): Actor Cache
// ============================================================
/*
 Goal: never download the same note twice. Keep downloaded notes in
 a cache. Two actors, both in "Your solution (Challenge 3)".

 Why an actor? Many tasks may use the cache at once. An actor lets
 only one task in at a time, so its dictionary can't be corrupted.
 From outside an actor you call its members with await.

 Actor 1 — TodoCache
   It holds a dictionary: note id → Todo. It has 3 members:
     func get(_ id: Int) -> Todo?    the saved note, or nil if none
     func save(_ todo: Todo)         store the note under its id
     var count: Int                  how many notes are stored

 Actor 2 — TodoService
   It has a TodoCache inside it, and a counter:
     private(set) var networkCalls = 0     counts real downloads
   TodoService() must work with no arguments.
   It has one method:
     func todo(id: Int) async throws -> Todo
   What todo(id:) does, in order:
     1. Look in the cache (use await). Found? Return it and stop.
     2. Not found: add 1 to networkCalls, then call fetchTodo(id:).
     3. Save the result in the cache, then return it.
   If fetchTodo throws, let the error go up and save nothing.
*/

// MARK: Your solution (Challenge 3)

actor TodoCache {
    var store = [Int: Todo]()
    var count: Int {
        return store.count
    }
    
    func get(_ id: Int) -> Todo? {
        guard let result = store[id] else {
            return nil
        }
        return result
    }
    func save(_ todo: Todo) {
        var id = todo.id
        store[id] = todo
    }
}

actor TodoService {
    private(set) var networkCalls = 0
    var cache = TodoCache()
    
    func todo(id: Int) async throws -> Todo {
        if let cachedTodo = await cache.get(id) {
            return cachedTodo
        } else {
            networkCalls += 1
            let newTodo = try await fetchTodo(id: id)
            await cache.save(newTodo)
            return newTodo
        }
    }
}

// MARK: Tests (Challenge 3) — uncomment as you go
 Task {
     do {
         // the cache on its own
         let cache = TodoCache()
         var found = await cache.get(1)
         assert(found == nil)                                  // empty cache
         let note = try decodeTodo(Data(#"{"userId":1,"id":1,"title":"Water plants","completed":false}"#.utf8))
         let doneNote = try decodeTodo(Data(#"{"userId":1,"id":1,"title":"Water plants","completed":true}"#.utf8))
         await cache.save(note)
         found = await cache.get(1)
         assert(found == note)
         var count = await cache.count
         assert(count == 1)
         await cache.save(doneNote)
         count = await cache.count
         assert(count == 1)                                    // same id replaces, not adds
         found = await cache.get(1)
         assert(found == doneNote)

         // the service with the cache
         let service = TodoService()
         let first = try await service.todo(id: 1)
         assert(first.title == "delectus aut autem")
         var calls = await service.networkCalls
         assert(calls == 1)
         let again = try await service.todo(id: 1)
         assert(again == first)
         calls = await service.networkCalls
         assert(calls == 1)                                    // came from the cache
         _ = try await service.todo(id: 2)
         calls = await service.networkCalls
         assert(calls == 2)                                    // a new id goes to the network
         var error = await thrown { _ = try await service.todo(id: 99999) }
         assert(error as? TodoError == .notFound)
         calls = await service.networkCalls
         assert(calls == 3)
         error = await thrown { _ = try await service.todo(id: 99999) }
         calls = await service.networkCalls
         assert(calls == 4)                                    // failures are not cached
         print("Challenge 3 passed!")
     } catch {
         print("Challenge 3 failed: \(error)")
     }
 }


// ============================================================
// MARK: - Challenge 4 (The Rush Hour): Task Group
// ============================================================
/*
 Goal: download several notes at the same time, not one by one.
 Put this in "Your solution (Challenge 4)", inside an extension of
 your actor, so it becomes a new method of TodoService:

   extension TodoService { ... }

   func todos(ids: [Int]) async throws -> [Todo]

 What it does:
   - Starts one task per id, all at once.
   - Each task calls your own todo(id:), so the cache is used.
   - Returns every Todo sorted by id, smallest first. (Tasks finish
     in any order, so you must sort at the end.)
   - If any task throws, the whole function throws that error.
   - All the ids are different. An empty list gives an empty list.

 The tool for this:
   withThrowingTaskGroup(of: Todo.self) { group in ... }
     group.addTask { ... }                 starts one task
     for try await todo in group { ... }   receives each result
*/

// MARK: Your solution (Challenge 4)


// MARK: Tests (Challenge 4) — uncomment as you go
// Task {
//     do {
//         let service = TodoService()
//         let list = try await service.todos(ids: [3, 1, 2])
//         assert(list.map(\.id) == [1, 2, 3])                   // sorted, not in finish order
//         var calls = await service.networkCalls
//         assert(calls == 3)
//         let again = try await service.todos(ids: [2, 1])
//         assert(again.map(\.id) == [1, 2])
//         calls = await service.networkCalls
//         assert(calls == 3)                                    // all came from the cache
//         let none = try await service.todos(ids: [])
//         assert(none.isEmpty)                                  // empty input, empty output
//         let error = await thrown { _ = try await service.todos(ids: [4, 99999]) }
//         assert(error as? TodoError == .notFound)              // one failure fails the call
//         print("Challenge 4 passed!")
//     } catch {
//         print("Challenge 4 failed: \(error)")
//     }
// }
