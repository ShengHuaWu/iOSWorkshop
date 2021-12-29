import Foundation
import JSONReader

enum NetworkClientError: Error {
    case buildURLRequestFailure(BuildURLRequestError)
    case unexpectedFailure(Error)
    case networkFailure(String)
    case responseTypeInvalid(URLResponse?)
}

func sendRequest(
    _ request: Request,
    completion: @escaping (Result<Response, NetworkClientError>) -> Void
) {
    do {
        let urlRequest = try buildURLRequest(for: request)
        URLSession.shared.dataTask(with: urlRequest) { _, response, error in
            if let error = error {
                let message = """
                Error occurs when calling endpoint \(request.url)
                with body \(request.body):
                \(error.localizedDescription)
                """
                completion(.failure(.networkFailure(message)))
                return
            }
            
            guard let httpURLResposne = response as? HTTPURLResponse else {
                completion(.failure(.responseTypeInvalid(response)))
                return
            }
            
            completion(.success(Response(code: httpURLResposne.statusCode)))
        }.resume()
    } catch let error as BuildURLRequestError {
        completion(.failure(.buildURLRequestFailure(error)))
    } catch {
        completion(.failure(.unexpectedFailure(error)))
    }
}
