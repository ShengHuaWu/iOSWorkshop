struct Coordinate: Decodable {
    let x: Double
    let y: Double
}

struct Station: Decodable {
    let id: String
    let name: String
    let coordinate: Coordinate
}
