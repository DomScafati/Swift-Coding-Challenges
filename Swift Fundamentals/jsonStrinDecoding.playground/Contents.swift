import UIKit

let jsonString = """
{
    "name": "Dom",
    "age": 30
}
"""

struct Person: Codable {
    let name: String
    let age: Int
}

enum CustomError: Error {
    case unknown
}

func fetch() throws {
    guard let data = jsonString.data(using: .utf8) else {
        throw CustomError.unknown
    }
    
    guard let result = try? JSONDecoder().decode(Person.self, from: data) else {
        throw CustomError.unknown
    }
    
    print(result.name)
    print(result.age)
}

