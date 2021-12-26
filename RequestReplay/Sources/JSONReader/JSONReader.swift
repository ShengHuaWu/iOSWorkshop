import Foundation

public enum JSONReaderError: Error {
    case fileNotFound
}

public final class JSONReader {
    public init() {}
    
    public func readFile() throws -> URL {
        guard let url = Bundle.module.url(forResource: "requestlog-charges", withExtension: "json") else {
            throw JSONReaderError.fileNotFound
        }
        
        return url
    }
}
