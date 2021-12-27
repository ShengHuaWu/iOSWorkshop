import Foundation

public enum JSONReaderError: Error {
    case fileNotFound
}

public final class JSONReader {
    public init() {}
    
    public func readFile() throws -> [Container] {
        guard let url = Bundle.module.url(forResource: "requestlog-charges", withExtension: "json") else {
            throw JSONReaderError.fileNotFound
        }
        
        let data = try Data(contentsOf: url)
        let containers = try JSONDecoder().decode([Container].self, from: data)
        
        return containers
    }
}
