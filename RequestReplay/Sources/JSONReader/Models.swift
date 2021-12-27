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
}

public struct Response: Decodable {
    public let code: Int
}
