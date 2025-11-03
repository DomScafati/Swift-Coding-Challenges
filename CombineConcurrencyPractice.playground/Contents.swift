import UIKit
import Combine

enum CustomError: Error {
    case known(Error)
    case unknown
}

func combineFetch(urlString: String) -> AnyPublisher<String, CustomError> {
    guard let url = URL(string: urlString) else {
        return Fail(error: CustomError.unknown).eraseToAnyPublisher()
    }
    
    return URLSession.shared.dataTaskPublisher(for: url)
        .tryMap { data, response in
            guard let httpUrl = response as? HTTPURLResponse,
                  (200...300).contains(httpUrl.statusCode) else {
                throw CustomError.unknown
            }
            
            return data
        }
        .decode(type: String.self, decoder: JSONDecoder())
        .mapError({ error -> CustomError in
            return .unknown
        })
        .receive(on: DispatchQueue.main)
        .eraseToAnyPublisher()
}

func get() {
    let cancellable = Set<AnyCancellable>()
    
    combineFetch(urlString: "www.test.com")
        .sink { completion in
            switch completion {
            case .finished: print("success")
            case .failure(let error): print("error: \(error)")
            }
        } receiveValue: { result in
            print("Result is \(result)")
        }

}
