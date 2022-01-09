import Combine
import Foundation

struct TransportClient {
    var getStations: (String) -> AnyPublisher<[Station], Error>
}

extension TransportClient {
    static var live: TransportClient {
        struct StationsResponse: Decodable {
            let stations: [Station]
        }
        
        return .init { query in
            guard let url = URL(string: "http://transport.opendata.ch/v1/locations?query=\(query)") else {
                fatalError("Unable to construct valid url from query: \(query)")
            }
            
            // https://developer.apple.com/documentation/foundation/urlsession/processing_url_session_data_task_results_with_combine
            return URLSession.shared
                .dataTaskPublisher(for: url)
                .tryMap { $0.data }
                .decode(type: StationsResponse.self, decoder: JSONDecoder())
                .map { $0.stations }
                .eraseToAnyPublisher()
        }
    }
}
