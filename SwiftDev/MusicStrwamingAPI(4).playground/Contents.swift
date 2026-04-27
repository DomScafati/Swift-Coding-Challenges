import UIKit
import Foundation

// MARK: - Instructions
/*
 Task: Implement Decodable for a music streaming API response.
 The Track structure represents a song in a music app. Provide Decodable initializers to make the structures fully decodable from JSON.
 
 Requirements:
 Track

 title and artistName must not be nil — if missing, do not allow Track to initialize
 durationSeconds must not be nil — if missing, do not allow Track to initialize
 albumArtURL is optional
 If genres is missing or empty, default to []

 StreamingPlatform enum

 Supported platforms are spotify ("SPOTIFY"), appleMusic ("APPLE_MUSIC")
 Any other string should decode as unknown
 
 */

// MARK: - Pre-defined structures (do not modify)

public struct Track {
    let title: String
    let artistName: String
    let durationSeconds: Int
    let albumArtURL: URL?
    let genres: [String]
    let platform: StreamingPlatform
    let releasedAt: Date?
}

public enum StreamingPlatform: Equatable {
    case spotify
    case appleMusic
    case unknown
}

// MARK: - JSON test data

let fullJSON = """
{
    "track_title": "Blinding Lights",
    "artist_name": "The Weeknd",
    "duration_seconds": 200,
    "album_art_url": "https://example.com/art.jpg",
    "genres": ["pop", "synth-pop"],
    "streaming_platform": "SPOTIFY",
    "released_at": "2019-11-29T00:00:00"
}
""".data(using: .utf8)!

let missingGenresJSON = """
{
    "track_title": "Save Your Tears",
    "artist_name": "The Weeknd",
    "duration_seconds": 215,
    "streaming_platform": "APPLE_MUSIC"
}
""".data(using: .utf8)!

let unknownPlatformJSON = """
{
    "track_title": "Starboy",
    "artist_name": "The Weeknd",
    "duration_seconds": 230,
    "streaming_platform": "TIDAL"
}
""".data(using: .utf8)!

// MARK: - Your solution goes here

extension Track: Decodable {
    public init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        // Manditory
        self.title = try container.decode(String.self, forKey: .title)
        self.artistName = try container.decode(String.self, forKey: .artistName)
        self.durationSeconds = try container.decode(Int.self, forKey: .durationSeconds)
        
        // Optional
        self.albumArtURL = try container.decodeIfPresent(URL.self, forKey: .albumArtURL)
        
        if let dateString = try container.decodeIfPresent(String.self, forKey: .releasedAt) {
            let formatter = DateFormatter()
            formatter.locale = Locale(identifier: "en_US_POSIX")
            formatter.timeZone = TimeZone(secondsFromGMT: 0)
            formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
            self.releasedAt = formatter.date(from: dateString)
        } else {
            self.releasedAt = nil
        }
        
        if let genres = try? container.decode([String].self, forKey: .genres) {
            self.genres = genres
        } else {
            self.genres = []
        }
        
        // instructions unclear on how to handle the following
        self.platform = try container.decode(StreamingPlatform.self, forKey: .platform)
    }
    
    enum CodingKeys: String, CodingKey {
        case title = "track_title"
        case artistName = "artist_name"
        case durationSeconds = "duration_seconds"
        case albumArtURL = "album_art_url"
        case genres
        case platform = "streaming_platform"
        case releasedAt = "released_at"
    }
}

extension StreamingPlatform: Decodable {
    public init(from decoder: any Decoder) throws {
        let container = try decoder.singleValueContainer()
        
        let string = try container.decode(String.self)
        switch string {
        case "SPOTIFY": self = .spotify
        case "APPLE_MUSIC": self = .appleMusic
        default: self = .unknown
        }
    }
}

// MARK: - Tests (uncomment as you go)

let decoder = JSONDecoder()
do {
    let track1 = try decoder.decode(Track.self, from: fullJSON)
    assert(track1.title == "Blinding Lights")
    assert(track1.genres == ["pop", "synth-pop"])
    assert(track1.platform == .spotify)
    assert(track1.albumArtURL != nil)
    assert(track1.releasedAt != nil)

    let track2 = try decoder.decode(Track.self, from: missingGenresJSON)
    assert(track2.genres == [])
    assert(track2.platform == .appleMusic)
    assert(track2.releasedAt == nil)

    let track3 = try decoder.decode(Track.self, from: unknownPlatformJSON)
    assert(track3.platform == .unknown)

    print("All tests passed!")

} catch {
    print(error)
}
