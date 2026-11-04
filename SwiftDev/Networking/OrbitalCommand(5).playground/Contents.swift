import Foundation

// Swift Dev Challenge
//
// Vertical slice — all four layers in one challenge:
//   1. Codable + CodingKeys    → model owns its own decoding
//   2. Protocol                → abstract the service behind a contract
//   3. Dependency injection    → controller receives the protocol, not the concrete type
//   4. async/await + throws    → async fetch with structured error handling

// Interstellar Command has detected an incoming transmission from
// deep-space probe ARX-7. Mission control needs a clean networking
// layer to decode the signal, pass it through a service, and surface
// it to the dashboard — all without coupling any layer to another.


// ============================================================
// MARK: - Challenge 1 (Orbital Command): Networking Vertical Slice
// ============================================================
/*
 The raw transmission JSON and the MissionReport model shell are
 provided below. Your job is to wire up the full stack.

 Step 1 — Codable
   In an extension on MissionReport, add a CodingKeys enum that maps
   the snake_case JSON keys to the camelCase properties, then implement
   init(from decoder: Decoder) to decode each property from a keyed container.

 Step 2 — Protocol
   Define a protocol called MissionServiceProtocol with one requirement:
   an async throwing function that returns a MissionReport.
   Choose the function name and signature yourself.

 Step 3 — Concrete service
   Implement class MissionService: MissionServiceProtocol.
   Its fetch method should decode missionJSON into a MissionReport.
   On failure, throw MissionError.decodingFailed.

 Step 4 — Controller with dependency injection
   Implement class MissionController.
   Its init must accept a MissionServiceProtocol — not a MissionService.
   Add an async throwing method loadMission() -> MissionReport that
   calls through to the service and returns the result.

 Hint: the controller never touches JSONDecoder. It only speaks to
 the protocol — that's the point of dependency injection.
*/

// MARK: Pre-defined (do not modify)

let missionJSON = Data("""
{
  "mission_id": "ARX-7",
  "launch_site": "Orbital Platform 9",
  "crew_count": 4,
  "status": "en_route"
}
""".utf8)

struct MissionReport: Decodable {
    let missionId: String
    let launchSite: String
    let crewCount: Int
    let status: String
}

enum MissionError: Error {
    case decodingFailed
    case noData
}

// MARK: Your solution

// Step 1 — Codable (extension on MissionReport)

extension MissionReport {
    init(from decoder: any Decoder) throws {
        var container = try decoder.container(keyedBy: CodingKeys.self)
        self.missionId = try container.decode(String.self, forKey: .missionId)
        self.launchSite = try container.decode(String.self, forKey: .launchSite)
        self.crewCount = try container.decode(Int.self, forKey: .crewCount)
        self.status = try container.decode(String.self, forKey: .status)
    }
    
    enum CodingKeys: String, CodingKey {
        case missionId = "mission_id"
        case launchSite = "launch_site"
        case crewCount = "crew_count"
        case status
    }
}


// Step 2 — Protocol

protocol MissionServiceProtocol {
    func fetchMissionReport() async throws -> MissionReport
}


// Step 3 — Concrete service

class MissionService: MissionServiceProtocol {
    var dataToDecode: Data
    
    init(dataToDecode: Data) {
        self.dataToDecode = dataToDecode
    }
    
    func fetchMissionReport() async throws -> MissionReport {

        do {
            return try JSONDecoder().decode(MissionReport.self, from: dataToDecode)
            
        } catch {
            throw MissionError.decodingFailed
        }
    }
}

// Step 4 — Controller

class MissionController {
    var service: MissionServiceProtocol
    
    init(service: MissionServiceProtocol) {
        self.service = service
    }
    
    func loadMission() async throws -> MissionReport {
        guard let result = try? await service.fetchMissionReport() else {
            throw MissionError.decodingFailed
        }
        return result
    }
}

// MARK: Tests — uncomment as you go

Task {
    do {
        let controller = MissionController(service: MissionService(dataToDecode: missionJSON))
        let report = try await controller.loadMission()
        assert(report.missionId == "ARX-7")
        assert(report.launchSite == "Orbital Platform 9")
        assert(report.crewCount == 4)
        assert(report.status == "en_route")
        print("Challenge passed!")
    } catch {
        print("Failed: \(error)")
    }
}
