import Foundation

// Swift Dev Challenge
//
// Topic: Codable — decoding inside the model struct
//
// When a struct conforms to Decodable and implements init(from:),
// it owns its own decoding logic. The networking layer just passes
// raw Data to JSONDecoder — the struct decides how to map it.

// A small weather app fetches conditions from a remote API.
// The WeatherService hands back raw Data and knows nothing about
// the JSON shape. Your job is to make WeatherReport decode itself.


// ============================================================
// MARK: - Challenge 1 (The Forecast): init(from decoder: Decoder)
// ============================================================
/*
 The WeatherService below is pre-written — read it, but do not
 modify it. It returns raw Data and calls JSONDecoder once. The
 struct is responsible for knowing how to map the JSON to itself.

 Your job: conform WeatherReport to Decodable and implement
 init(from decoder: Decoder) so it maps correctly from this JSON:

   "location_name" → locationName  (String)
   "temp_celsius"  → tempCelsius   (Double)
   "humidity_pct"  → humidityPct   (Int)
   "condition"     → condition     (String)

 Steps:
 1. Add a CodingKeys enum inside WeatherReport that maps the
    snake_case JSON keys to the camelCase property names above.
 2. Implement init(from decoder: Decoder) — create a keyed
    container using CodingKeys, then decode each property from it.

 Hint: let container = try decoder.container(keyedBy: CodingKeys.self)
       then call container.decode(_:forKey:) for each property.
*/

// MARK: Pre-defined

let sampleJSON = Data("""
{
  "location_name": "Maplewood",
  "temp_celsius": 18.5,
  "humidity_pct": 62,
  "condition": "Partly Cloudy"
}
""".utf8)

struct WeatherReport: Decodable {
    let locationName: String
    let tempCelsius: Double
    let humidityPct: Int
    let condition: String
}

struct WeatherService {
    func fetchReport() throws -> WeatherReport {
        // Networking layer: fetches data and decodes it.
        // It has no knowledge of the JSON shape — WeatherReport handles that.
        return try JSONDecoder().decode(WeatherReport.self, from: sampleJSON)
    }
}

// MARK: Your solution (Challenge 1)

extension WeatherReport {
    enum CodingKeys: String, CodingKey {
        case locationName = "location_name"
        case tempCelsius = "temp_celsius"
        case humidityPct = "humidity_pct"
        case condition = "condition"
    }
    
    init(from decoder: any Decoder) throws {
        var box = try decoder.container(keyedBy: CodingKeys.self)
        self.locationName = try box.decode(String.self, forKey: .locationName)
        self.tempCelsius = try box.decode(Double.self, forKey: .tempCelsius)
        self.humidityPct = try box.decode(Int.self, forKey: .humidityPct)
        self.condition = try box.decode(String.self, forKey: .condition)
    }
}

// MARK: Tests (Challenge 1) — uncomment as you go

let service = WeatherService()
let report = try! service.fetchReport()
assert(report.locationName == "Maplewood")
assert(report.tempCelsius == 18.5)
assert(report.humidityPct == 62)
assert(report.condition == "Partly Cloudy")
print("Challenge 1 passed!")
