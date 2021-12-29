import Foundation

public struct Container: Decodable {
    public let request: Request
    public let response: Response
}

public struct Request: Decodable {
    public let url: String
    public let headers: [String: String]
    public let body: String
    public let method: String
    
    public init(
        url: String,
        headers: [String: String],
        body: String,
        method: String
    ) {
        self.url = url
        self.headers = headers
        self.body = body
        self.method = method
    }
}

public struct Response: Decodable {
    public let code: Int
    
    public init(code: Int) {
        self.code = code
    }
}
