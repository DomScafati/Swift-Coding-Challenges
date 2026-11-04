import Foundation

// Swift Dev Challenge
//
// Vertical slice — six layers in one challenge, each one built on the last:
//   1. Codable + CodingKeys    → model maps the feed's JSON names to its own
//   2. Protocol                → one contract for "something that fetches a story"
//   3. Dependency injection    → real network service that receives its loader
//   4. Actor                   → thread-safe store that remembers stories
//   5. Decorator               → a caching layer that wraps any fetcher
//   6. TaskGroup               → load many stories at once, in order

// The Gazette's wire desk pulls stories from a press-feed API. Reporters
// hit refresh constantly, so the desk must never ask the feed for a story
// it already holds. The front page needs several stories at once, loaded
// side by side rather than one after another.


// ============================================================
// MARK: - Challenge 1 (The Wire Desk): Networking Vertical Slice
// ============================================================
/*
 The feed is the real JSONPlaceholder API. One story lives at
 https://jsonplaceholder.typicode.com/posts/{id} and looks like this:

   { "userId": 1, "id": 1, "title": "...", "body": "..." }

 The Post struct, the DataLoading protocol and the APIError enum are
 provided below. Build the rest one step at a time; each step uses the
 ones before it.

 Step 1 — Codable
   In an extension on Post, add a CodingKeys enum with the cases id,
   authorId, headline and body. authorId reads the JSON key "userId" and
   headline reads the JSON key "title". id and body use their own names.

 Step 2 — Protocol
   Define a protocol called PostFetching that inherits from Sendable. It
   has one requirement: func post(id: Int) async throws -> Post

 Step 3 — Network service
   Create struct PostService that conforms to PostFetching. It has one
   property, loader, of type any DataLoading, set by init(loader:). In
   post(id:), build the URL "https://jsonplaceholder.typicode.com/posts/"
   followed by the id, then call loader.data(from:) with it. That returns
   the response's Data and a URLResponse. If the URLResponse is not an
   HTTPURLResponse, throw APIError.invalidResponse. If its statusCode is not
   200, throw APIError.badStatus with that status code. Decode the Data into
   a Post and return it, or throw APIError.decodingFailed if decoding fails.
   Make the request with loader, not URLSession.shared.

 Step 4 — Store
   Create actor PostStore that keeps posts by their id. It has two methods:
   save(_ post: Post) stores a post, and post(for id: Int) -> Post? returns
   the stored post with that id, or nil if there isn't one.

 Step 5 — Caching layer
   Create struct CachedPostService that conforms to PostFetching, with
   init(service: any PostFetching, store: PostStore). In post(id:), first
   look in store for that id and return the post if it is there, without
   calling service. Otherwise call service.post(id:), save the returned Post
   in store, and return it. If service.post(id:) throws, let that error
   propagate and save nothing. It works with any PostFetching, not just
   PostService.

 Step 6 — Front page
   Create struct NewsDesk with init(service: any PostFetching) and the method
   func frontPage(ids: [Int]) async throws -> [Post]. It calls
   service.post(id:) for every id at the same time and returns the posts in
   the same order as ids, not the order they finish in. If any call throws,
   frontPage throws that error. The ids have no duplicates, and an empty
   ids array returns an empty array.

 Hint: child tasks finish in any order, so you need a way to put the results
 back in the order of ids. NewsDesk only uses the PostFetching protocol, so it
 works the same with a PostService or a CachedPostService.
*/

// MARK: Pre-defined (do not modify)

struct Post: Decodable, Sendable {
    let id: Int
    let authorId: Int
    let headline: String
    let body: String
}

protocol DataLoading: Sendable {
    func data(from url: URL) async throws -> (Data, URLResponse)
}

extension URLSession: DataLoading {
    func data(from url: URL) async throws -> (Data, URLResponse) {
        try await data(from: url, delegate: nil)
    }
}

/// Wraps another loader and counts how many requests pass through it.
actor CountingLoader: DataLoading {
    private let base: any DataLoading
    private(set) var requestCount = 0

    init(base: any DataLoading) {
        self.base = base
    }

    func data(from url: URL) async throws -> (Data, URLResponse) {
        requestCount += 1
        return try await base.data(from: url)
    }
}

enum APIError: Error, Equatable {
    case invalidResponse
    case badStatus(Int)
    case decodingFailed
}

// MARK: Your solution

// Step 1 — Codable (extension on Post)

extension Post {
    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(Int.self, forKey: .id)
        self.authorId = try container.decode(Int.self, forKey: .authorId)
        self.headline = try container.decode(String.self, forKey: .headline)
        self.body = try container.decode(String.self, forKey: .body)
    }
    
    enum CodingKeys: String, CodingKey {
        case id
        case authorId = "userId"
        case headline = "title"
        case body
    }
}

// Step 2 — Protocol

protocol PostFetching: Sendable {
    func post(id: Int) async throws -> Post
}

// Step 3 — Network service

struct PostService: PostFetching {
    var loader: DataLoading
    var baseUrl = "https://jsonplaceholder.typicode.com/posts/"
    
    init(loader: DataLoading) {
        self.loader = loader
    }
    
    func post(id: Int) async throws -> Post {
        var urlString = baseUrl + "\(id)"
        guard let url = URL(string: urlString) else {
            throw APIError.decodingFailed
        }
        
        let (data, response) = try await loader.data(from: url)
        
        guard let httpURL = response as? HTTPURLResponse else {
            throw APIError.invalidResponse
        }
        
        guard httpURL.statusCode == 200 else {
            throw APIError.badStatus(httpURL.statusCode)
        }
        
        guard let post = try? JSONDecoder().decode(Post.self, from: data) else {
            throw APIError.decodingFailed
        }
        
        return post
    }
}

// Step 4 — Store

actor PostStore {
    private var stack: [Post] = []
    
    func save(_ post: Post) {
        stack.append(post)
    }
    
    func post(for id: Int) -> Post? {
        for post in stack {
            if id == post.id {
                return post
            }
        }
        return nil
    }
}

// Step 5 — Caching layer

struct CachedPostService: PostFetching {
    var service: PostFetching
    var store: PostStore
    
    init(service: any PostFetching,
         store: PostStore) {
        self.service = service
        self.store = store
    }
    
    func post(id: Int) async throws -> Post {
        if let existingPost = await store.post(for: id) {
            return existingPost
        }
        
        do {
            let newPost = try await service.post(id: id)
            await store.save(newPost)
            return newPost
        } catch {
            throw error
        }
    }
}

// Step 6 — Front page

struct NewsDesk {
    var service: PostFetching
    
    init(service: any PostFetching) {
        self.service = service
    }
    
    func frontPage(ids: [Int]) async throws -> [Post] {
        var posts: [Post] = []

        try await withThrowingTaskGroup(of: Post.self) { group in
            for id in ids {
                group.addTask {
                    return try await service.post(id: id)
                }
            }

            for try await post in group {
                posts.append(post)
            }
        }

        posts.sort { first, second in
            let firstPosition = ids.firstIndex(of: first.id) ?? 0
            let secondPosition = ids.firstIndex(of: second.id) ?? 0
            return firstPosition < secondPosition
        }
        return posts
    }
}

// MARK: Tests — uncomment as you go

 Task {
     do {
//         // Step 1 — decoding (offline)
         let sample = Data(#"{"userId": 3, "id": 9, "title": "Extra", "body": "Text"}"#.utf8)
         let decoded = try JSONDecoder().decode(Post.self, from: sample)
         assert(decoded.id == 9)
         assert(decoded.authorId == 3)              // "userId" maps to authorId
         assert(decoded.headline == "Extra")        // "title" maps to headline

//         // Step 3 — network service
         let wireLoader = CountingLoader(base: URLSession.shared)
         let wire = PostService(loader: wireLoader)
         let story = try await wire.post(id: 2)
         assert(story.authorId == 1)                // a real story, decoded
         assert(story.headline == "qui est esse")
         var requests = await wireLoader.requestCount
         assert(requests == 1)                      // one story, one request
         do {
             _ = try await wire.post(id: 9999)      // the feed answers 404
             assertionFailure("expected a throw")
         } catch {
             assert(error as? APIError == .badStatus(404))
         }
//
//         // Step 5 — caching layer
         let archiveLoader = CountingLoader(base: URLSession.shared)
         let archive = CachedPostService(service: PostService(loader: archiveLoader), store: PostStore())
         let first = try await archive.post(id: 1)
         requests = await archiveLoader.requestCount
         assert(requests == 1)                      // miss: went to the feed
         let again = try await archive.post(id: 1)
         assert(again.headline == first.headline)
         requests = await archiveLoader.requestCount
         assert(requests == 1)                      // hit: no new request
         _ = try await archive.post(id: 2)
         requests = await archiveLoader.requestCount
         assert(requests == 2)                      // a different story is a new miss
         _ = try? await archive.post(id: 9999)
         _ = try? await archive.post(id: 9999)
         requests = await archiveLoader.requestCount
         assert(requests == 4)                      // failures aren't cached: asked twice

//         // Step 6 — front page
         let deskLoader = CountingLoader(base: URLSession.shared)
         let cached = CachedPostService(service: PostService(loader: deskLoader), store: PostStore())
         let desk = NewsDesk(service: cached)
         _ = try await cached.post(id: 1)           // story 1 is already stored
         let page = try await desk.frontPage(ids: [12, 1, 7, 3])
         assert(page.map(\.id) == [12, 1, 7, 3])    // same order as asked for
         assert(page.map(\.authorId) == [2, 1, 1, 1])
         requests = await deskLoader.requestCount
         assert(requests == 4)                      // story 1 was stored: 3 new requests
         let empty = try await desk.frontPage(ids: [])
         assert(empty.isEmpty)                      // empty input, empty output
         do {
             _ = try await desk.frontPage(ids: [2, 9999, 5])
             assertionFailure("expected a throw")
         } catch {
             assert(error as? APIError == .badStatus(404))   // one failure fails the page
         }

         print("Challenge passed!")
     } catch {
         print("Failed: \(error)")
     }
 }
