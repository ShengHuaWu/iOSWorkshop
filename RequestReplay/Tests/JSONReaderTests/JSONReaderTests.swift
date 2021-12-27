import XCTest
@testable import JSONReader

final class JSONReaderTests: XCTestCase {
    func testReadFile() throws {
        let reader = JSONReader()
        
        let containers = try reader.readFile()
        
        XCTAssertEqual(containers.count, 3)
        
        XCTAssertEqual(containers.first?.request.url, "/v1/charges")
        XCTAssertEqual(
            containers.first?.request.body,
            "amount=123&currency=usd&card[number]=4242424242424242&card[exp_month]=12&card[exp_year]=2025"
        )
        XCTAssertEqual(containers.first?.request.method, "POST")
        
        XCTAssertEqual(containers.first?.response.code, 200)
    }
}
