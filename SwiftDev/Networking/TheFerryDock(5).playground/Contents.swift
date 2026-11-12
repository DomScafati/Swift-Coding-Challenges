import Foundation

// Swift Dev Challenge
//
// Vertical slice — four layers in one challenge, each one built on the last:
//   1. Status handling         → turn an HTTP reply into data or a typed error
//   2. Generic client          → one get<T: Decodable> for every endpoint
//   3. Pagination              → follow the server's nextPage until it ends
//   4. Token refresh           → on a 401, refresh once and retry once

// The Ferry Dock's booking app talks to a REST API, and the queues are
// growing. The app needs a proper client: check every reply, fetch any
// model with one call, read the whole ferry list page by page, and carry
// on when the login expires. The server is pretend: the tests use a
// scripted transport that replies from a list.


// ============================================================
// MARK: - Challenge 1 (The Ferry Dock): A Real API Client
// ============================================================
/*
 The models, the error type and a scripted transport are provided
 below. Build the client one step at a time; each step uses the ones
 before it.

 Step 1 — Status handling
   Write func validate(_ data: Data, _ response: URLResponse) throws -> Data
   If the response is not an HTTPURLResponse, throw APIError.invalidResponse.
   Status 200 through 299 returns the data. 401 throws .unauthorized, 404
   throws .notFound, any other status throws .badStatus with that code.

 Step 2 — Generic client
   Write class APIClient with these members:
     var token: String
     let transport: any Transport
     let refresh: () async throws -> String
     init(transport: any Transport, token: String, refresh: @escaping () async throws -> String)
     func get<T: Decodable>(_ type: T.Type, path: String) async throws -> T
   get sends a GET request to baseURL followed by the path, with the header
   "Authorization" set to "Bearer " followed by the token. It validates the
   reply with Step 1 and decodes the data as T, or throws .decodingFailed.
   Errors thrown by the transport pass up unchanged.

 Step 3 — Pagination
   Add func allFerries() async throws -> [Ferry] to APIClient. It is a new
   method on the same class, not a new object, and it uses your own get.
   Call get with the type FerryPage and the path "/v1/ferries?page=1".
   FerryPage has items (the ferries on that page) and nextPage (the next
   page number, or nil on the last page). Keep calling get with
   "/v1/ferries?page=N", where N is the nextPage from the last reply, until
   nextPage is nil. Return every ferry from every page in the order
   received. If get throws, let that same error come out of allFerries
   unchanged (do not replace it with a different error).

 Step 4 — Token refresh
   Change get so that if the request fails with .unauthorized, it calls
   refresh(), stores the result in token, and tries once more. One refresh
   and one retry per call at most. Any other error is thrown with no
   refresh, and so is a second .unauthorized. If refresh throws, throw that.
   allFerries should now survive an expired token with no changes.

 Hint: get is the only code that talks to the transport, so the refresh
 belongs there. Pagination just calls get.
*/

// MARK: Pre-defined (do not modify)

let baseURL = "https://api.ferrydock.test"

struct Ferry: Decodable, Equatable {
    let id: Int
    let name: String
}

struct FerryPage: Decodable {
    let items: [Ferry]
    let nextPage: Int?
}

enum APIError: Error, Equatable {
    case invalidResponse
    case unauthorized
    case notFound
    case badStatus(Int)
    case decodingFailed
}

protocol Transport {
    func send(_ request: URLRequest) async throws -> (Data, URLResponse)
}

/// Replies from a script, in order, and remembers every request it receives.
final class ScriptedTransport: Transport {
    var replies: [(status: Int, body: String)]
    var requests: [URLRequest] = []

    init(_ replies: [(status: Int, body: String)]) { self.replies = replies }

    func send(_ request: URLRequest) async throws -> (Data, URLResponse) {
        requests.append(request)
        let reply = replies.isEmpty ? (status: 500, body: "") : replies.removeFirst()
        return (Data(reply.body.utf8), response(reply.status))
    }
}

func response(_ status: Int) -> HTTPURLResponse {
    HTTPURLResponse(url: URL(string: baseURL)!, statusCode: status, httpVersion: nil, headerFields: nil)!
}

/// Returns the error the work throws, or nil.
func thrown(_ work: () async throws -> Void) async -> Error? {
    do { try await work(); return nil } catch { return error }
}

// MARK: Your solution

func validate(_ data: Data, _ response: URLResponse) throws -> Data {
    guard let httpURLResponse = response as? HTTPURLResponse else {
        throw APIError.invalidResponse
    }
    
    switch httpURLResponse.statusCode {
    case (200...299): return data
    case 401: throw APIError.unauthorized
    case 404: throw APIError.notFound
    default: throw APIError.badStatus(httpURLResponse.statusCode)
    }
    
}

class APIClient {
    let transport: any Transport
    var token: String
    let refresh: () async throws -> String
    
    init(transport: any Transport,
         token: String,
         refresh: @escaping () async throws -> String) {
        self.token = token
        self.transport = transport
        self.refresh = refresh
    }
    
    func get<T: Decodable>(_ type: T.Type, path: String) async throws -> T {
        guard let url = URL(string: baseURL + path) else {
            throw APIError.notFound
        }

        for attempt in 1...2 { // at most two tries, by construction
            var request = URLRequest(url: url)
            request.httpMethod = "GET"
            request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")

            do {
                let (data, response) = try await transport.send(request)
                let validData = try validate(data, response)
                guard let result = try? JSONDecoder().decode(T.self, from: validData) else {
                    throw APIError.decodingFailed
                }
                return result
            } catch APIError.unauthorized where attempt == 1 {
                token = try await refresh() // first failure only: refresh, then loop for the retry
            }
        }

        throw APIError.unauthorized // never reached; the compiler requires something here
    }

    func allFerries() async throws -> [Ferry] {
        var path = "/v1/ferries?page="
        var page: Int = 1
        var finalPath: String { path + "\(page)" }
        var allFerries = [Ferry]()
        
        // get first page
        var currentPage = try await get(FerryPage.self, path: finalPath)
        allFerries.append(contentsOf: currentPage.items)
        
        // while nex page is NOT nil, keep calling GET
        while currentPage.nextPage != nil {
            page = currentPage.nextPage!
            
            let nextPage = try await get(FerryPage.self, path: finalPath)
            allFerries.append(contentsOf: nextPage.items)
            currentPage = nextPage
        }
        
        return allFerries
    }

    

}

// MARK: Tests — uncomment as you go

func runTests() async throws {
    let ferryJSON = #"{"id":1,"name":"Marlin"}"#
    let marlin = Ferry(id: 1, name: "Marlin")
    let page1 = #"{"items":[{"id":1,"name":"Marlin"},{"id":2,"name":"Heron"}],"nextPage":2}"#
    let page2 = #"{"items":[{"id":3,"name":"Otter"}],"nextPage":null}"#

//    // Step 1 — status handling
    let data = try validate(Data("hi".utf8), response(204))
    assert(data == Data("hi".utf8))
    var error = await thrown { _ = try validate(Data(), response(401)) }
    assert(error as? APIError == .unauthorized)
    error = await thrown { _ = try validate(Data(), response(404)) }
    assert(error as? APIError == .notFound)
    error = await thrown { _ = try validate(Data(), response(500)) }
    assert(error as? APIError == .badStatus(500))
    error = await thrown { _ = try validate(Data(), URLResponse()) }
    assert(error as? APIError == .invalidResponse)

//    // Step 2 — generic client
    let t1 = ScriptedTransport([(200, ferryJSON), (200, "[\(ferryJSON)]")])
    let api = APIClient(transport: t1, token: "abc", refresh: { "unused" })
    let ferry = try await api.get(Ferry.self, path: "/v1/ferries/1")
    assert(ferry == marlin)
    assert(t1.requests[0].url?.absoluteString == "https://api.ferrydock.test/v1/ferries/1")
    assert(t1.requests[0].value(forHTTPHeaderField: "Authorization") == "Bearer abc")
    let list = try await api.get([Ferry].self, path: "/v1/ferries")      // works for any Decodable
    assert(list == [marlin])
    error = await thrown { _ = try await APIClient(transport: ScriptedTransport([(200, "nope")]), token: "t", refresh: { "x" }).get(Ferry.self, path: "/v1/ferries/1") }
    assert(error as? APIError == .decodingFailed)
    error = await thrown { _ = try await APIClient(transport: ScriptedTransport([(404, "")]), token: "t", refresh: { "x" }).get(Ferry.self, path: "/v1/ferries/9") }
    assert(error as? APIError == .notFound)

//    // Step 3 — pagination
    let t2 = ScriptedTransport([(200, page1), (200, page2)])
    let all = try await APIClient(transport: t2, token: "t", refresh: { "x" }).allFerries()
    assert(all.map(\.id) == [1, 2, 3])
    assert(t2.requests.map { $0.url?.absoluteString } == [
        "https://api.ferrydock.test/v1/ferries?page=1",
        "https://api.ferrydock.test/v1/ferries?page=2",
    ])
    let t3 = ScriptedTransport([(200, #"{"items":[],"nextPage":null}"#)])
    let none = try await APIClient(transport: t3, token: "t", refresh: { "x" }).allFerries()
    assert(none.isEmpty && t3.requests.count == 1)
    let t4 = ScriptedTransport([(200, page1), (500, ""), (200, page2)])
    error = await thrown { _ = try await APIClient(transport: t4, token: "t", refresh: { "x" }).allFerries() }
    assert(error as? APIError == .badStatus(500))
    assert(t4.requests.count == 2)                          // it stopped at the failure

    // Step 4 — token refresh
    var refreshes = 0
    let t5 = ScriptedTransport([(401, ""), (200, ferryJSON)])
    let session = APIClient(transport: t5, token: "old", refresh: { refreshes += 1; return "fresh" })
    let again = try await session.get(Ferry.self, path: "/v1/ferries/1")
    assert(again == marlin)
    assert(t5.requests.map { $0.value(forHTTPHeaderField: "Authorization") } == ["Bearer old", "Bearer fresh"])
    assert(refreshes == 1 && session.token == "fresh")

    refreshes = 0
    let t6 = ScriptedTransport([(401, ""), (401, ""), (200, ferryJSON)])
    error = await thrown { _ = try await APIClient(transport: t6, token: "old", refresh: { refreshes += 1; return "fresh" }).get(Ferry.self, path: "/v1/ferries/1") }
    assert(error as? APIError == .unauthorized)
    assert(refreshes == 1 && t6.requests.count == 2)        // one refresh, one retry, then give up

    refreshes = 0
    let t7 = ScriptedTransport([(404, ""), (200, ferryJSON)])
    error = await thrown { _ = try await APIClient(transport: t7, token: "old", refresh: { refreshes += 1; return "fresh" }).get(Ferry.self, path: "/v1/ferries/1") }
    assert(error as? APIError == .notFound)
    assert(refreshes == 0 && t7.requests.count == 1)        // other errors never refresh

    error = await thrown { _ = try await APIClient(transport: ScriptedTransport([(401, "")]), token: "old", refresh: { throw URLError(.timedOut) }).get(Ferry.self, path: "/v1/ferries/1") }
    assert((error as? URLError)?.code == .timedOut)         // a failing refresh is thrown

    refreshes = 0
    let t8 = ScriptedTransport([(200, page1), (401, ""), (200, page2)])
    let paged = APIClient(transport: t8, token: "old", refresh: { refreshes += 1; return "fresh" })
    let everything = try await paged.allFerries()
    assert(everything.map(\.id) == [1, 2, 3])               // the token expired on page 2
    assert(t8.requests.map { $0.value(forHTTPHeaderField: "Authorization") } == ["Bearer old", "Bearer old", "Bearer fresh"])
    assert(refreshes == 1)

    print("Challenge passed!")
}

Task {
    do {
        try await runTests()
    } catch {
        print("Failed: \(error)")
    }
}
