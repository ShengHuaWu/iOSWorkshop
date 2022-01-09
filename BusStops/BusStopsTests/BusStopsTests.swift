import Combine
import XCTest

@testable import BusStops

final class BusStopsTests: XCTestCase {
    private var cancellables: Set<AnyCancellable> = []
    
    func testTransportClientLive() {
        /*
         Response examples
         Station(id: "8500010", name: "Basel SBB", coordinate: Coordinate(x: 47.547412, y: 7.589577)),
         Station(id: "8500090", name: "Basel Bad Bf", coordinate: Coordinate(x: 47.56731, y: 7.606935))
         */
        
        let success = expectation(description: #function)
        
        TransportClient.live.getStations("Basel")
            .sink(
                receiveCompletion: { completion in
                    switch completion {
                    case .finished:
                        break
                        
                    case let .failure(error):
                        XCTFail("Fail because of: \(error.localizedDescription)")
                    }
                    success.fulfill()
                },
                receiveValue: { stations in
                    XCTAssertTrue(stations.count > 1)
                    XCTAssertEqual(stations.first?.id, "8500010")
                    XCTAssertEqual(stations.first?.name, "Basel SBB")
                    XCTAssertEqual(stations.first?.coordinate.x, 47.547412)
                    XCTAssertEqual(stations.first?.coordinate.y, 7.589577)
                }
            )
            .store(in: &self.cancellables)
        
        wait(for: [success], timeout: 5.0)
    }
}
