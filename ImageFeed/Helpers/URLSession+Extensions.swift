import UIKit

extension URLSession {
    func data(for request: URLRequest,
            completion: @escaping (Result<Data, Error>) -> Void) -> URLSessionTask {
        let urlComplition: (Result<Data, Error>) -> Void = { result in
            DispatchQueue.main.async {
                completion(result)
            }
        }
        
        let task = dataTask(with: request) { data, response, error in
            if let data = data,
               let response = response,
               let statusCode = (response as? HTTPURLResponse)?.statusCode
            {
                if 200 ..< 300 ~= statusCode {
                    urlComplition(.success(data))
                } else {
                    urlComplition(.failure(NetworkError.httpStatusCode(statusCode)))
                }
            } else if let error = error {
                urlComplition(.failure(NetworkError.urlRequestError(error)))
            } else {
                urlComplition(.failure(NetworkError.urlSessionError))
            }
        }
        
        task.resume()
        return task
    }
}
