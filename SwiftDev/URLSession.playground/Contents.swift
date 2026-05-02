import UIKit
import Combine

enum CustomError: Error {
    case urlError
    case urlSessionError
    case responseError
    case decodingError
    case known(Error)
    case unknownError
}

// use Async/await
// throw errors
// return generic
func modernFetch<T: Decodable>(_ url: String) async throws -> T {
    guard let url = URL(string: url) else { throw CustomError.urlError }
    
    let (data, response) = try await URLSession.shared.data(from: url)
    
    guard let httpURLResponse = response as? HTTPURLResponse,
          (200...299).contains(httpURLResponse.statusCode) else {
        throw CustomError.responseError
    }
    
    guard let result = try? JSONDecoder().decode(T.self, from: data) else {
        throw CustomError.decodingError
    }
    
    return result
}

// use urlsession
// handle errors
// return Result
var callback: ((Result<String, CustomError>) -> Void)?

func callBackFetch(_ url: String, completion: @escaping (Result<String, CustomError>) -> Void) {

    guard let url = URL(string: url) else {
        completion(.failure(.urlError))
        return
    }

    URLSession.shared.dataTask(with: url) { data, response, _ in
        guard let myData = data,
              let httpResponse = response as? HTTPURLResponse,
              (200...299).contains(httpResponse.statusCode) else {
            completion(.failure(.urlSessionError))
            return
        }

        guard let finishedResult = String(data: myData, encoding: .utf8) else {
            completion(.failure(.unknownError))
            return
        }

        completion(.success(finishedResult))
    }
    .resume()
}

func combinFetch<T: Decodable>(_ urlString: String)-> AnyPublisher<T, CustomError> {
    guard let url = URL(string: urlString) else {
        return Fail(error: .urlError).eraseToAnyPublisher()
    }
    
    return URLSession.shared.dataTaskPublisher(for: url)
        .tryMap({ data, response in
            guard let httpUrlResponse = response as? HTTPURLResponse,
                  (200...299).contains(httpUrlResponse.statusCode) else {
                throw CustomError.responseError
            }
            return data
        })
        .decode(type: T.self, decoder: JSONDecoder())
        .mapError({ error in
            switch error {
            case is URLError: return CustomError.urlError
            case is DecodingError: return CustomError.decodingError
            default: return CustomError.unknownError
            }
        })
        .eraseToAnyPublisher()
}
