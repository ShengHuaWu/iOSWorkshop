import Foundation
import JSONReader

enum BuildURLRequestError: Error {
    case invalidURL(String)
}

private let baseURLString = "https://api.stripe.com"

func buildURLRequest(for request: Request) throws -> URLRequest {
    var urlString = baseURLString + request.url
    
    if !request.body.isEmpty {
        urlString += "?" + request.body
    }
    
    guard let url = URL(string: urlString) else {
        throw BuildURLRequestError.invalidURL(urlString)
    }
    
    var urlRequest = URLRequest(url: url)
    urlRequest.httpMethod = request.method
    urlRequest.allHTTPHeaderFields = request.headers
    
    return urlRequest
}
