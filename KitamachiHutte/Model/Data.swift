import Foundation

class OrderStore: ObservableObject {
    @Published var orders: [ReservationData] = []
}

//struct OrderStore {
//    let orders: [OrderEntity] = load("orderEntity.json")
//}

struct DataStore {
    let specials: [Special] = load("special.json")
}

// var orderStore = OrderStore()
let dataStore = DataStore()

func load<T: Decodable>(_ filename: String, as type: T.Type = T.self) -> T {
    let data: Data
    
    guard let file = Bundle.main.url(forResource: filename, withExtension: nil)
        else {
            fatalError("Couldn't find \(filename) in main bundle.")
    }
    
    do {
        data = try Data(contentsOf: file)
    } catch {
        fatalError("Couldn't load \(filename) from main bundle:\n\(error)")
    }
    
    do {
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601
        return try decoder.decode(T.self, from: data)
    } catch {
        fatalError("Couldn't parse \(filename) as \(T.self):\n\(error)")
    }
}
