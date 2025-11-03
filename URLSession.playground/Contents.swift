import UIKit
import Combine

var greeting = "Hello, playground"

enum CustomError: Error {
    case urlError
    case urlSessionError
    case responseError
    case decodingError
    case known(Error)
    case unknownError
}

func fetchAsync<T: Decodable>(urlString: String) async -> T? {
    do {
        
        guard let url = URL(string: urlString) else {
            throw CustomError.urlError
        }
        
        guard let (data, response) = try? await URLSession.shared.data(from: url) else {
            throw CustomError.urlSessionError
        }
        
        guard let httpURLResponse = response as? HTTPURLResponse,
              (200..<300).contains(httpURLResponse.statusCode) else {
            throw CustomError.responseError
        }
        
        guard let result = try? JSONDecoder().decode(T.self, from: data) else {
            throw CustomError.decodingError
        }
        
        return result
        
    } catch {
        debugPrint("💥ERROR:\n\(error)")
    }
    
    return nil
}

func fetchClassic<T: Decodable>(urlString: String, completion: @escaping (Result<T, CustomError>) -> Void) {
        guard let url = URL(string: urlString) else {
            return completion(.failure(CustomError.urlError))
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data,
                  let httpURLResponse = response as? HTTPURLResponse,
                  (200..<300).contains(httpURLResponse.statusCode),
                  error == nil else {
                return completion(.failure(CustomError.urlSessionError))
            }
            
            guard let result = try? JSONDecoder().decode(T.self, from: data) else {
                return completion(.failure(CustomError.decodingError))
            }
            
            return completion(.success(result))
        }
        
    return completion(.failure(CustomError.unknownError))
}

func fetchCombine<T: Decodable>(urlString: String) -> AnyPublisher<T, Error> {
    
}
