import XCTest
@testable import JSONReader

@testable import RequestReplay

final class RequestBuilderTests: XCTestCase {
    func testBuildURLRequest() throws {
        let request = Request(
            url: "/v1/charges",
            headers: ["Authorization": "Bearer test_xyz"],
            body: "card[number]=4242424200003006&amount=123&currency=usd",
            method: "POST"
        )
        
        let urlRequest = try buildURLRequest(for: request)
        
        XCTAssertEqual(urlRequest.url?.path, "/v1/charges")
        XCTAssertEqual(urlRequest.url?.query, "card%5Bnumber%5D=4242424200003006&amount=123&currency=usd")
        XCTAssertEqual(urlRequest.allHTTPHeaderFields, ["Authorization": "Bearer test_xyz"])
        XCTAssertEqual(urlRequest.httpMethod, "POST")
    }
}
