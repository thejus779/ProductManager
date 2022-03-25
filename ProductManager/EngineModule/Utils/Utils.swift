import Foundation

class JsonLoader {
    // Loads json data and parses them to Deodable from file
    func loadResourceJson<T>(filename: String, to type: T.Type, decoder: JSONDecoder = JSONDecoder()) throws -> T where T : Decodable {
        guard let url = Bundle.main.url(forResource: filename, withExtension: "json") else {
            throw PError.noData
        }
        let data = try Data(contentsOf: url)
        let object = try decoder.decode(T.self, from: data)
        return object
    }
}
