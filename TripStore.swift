import Foundation

class TripStore: ObservableObject {
    @Published var trips: [Trip] = []

    private let key = "trips"

    init() { load() }

    func add(_ trip: Trip) {
        trips.insert(trip, at: 0)
        save()
    }

    func save() {
        if let data = try? JSONEncoder().encode(trips) {
            UserDefaults.standard.set(data, forKey: key)
        }
    }

    func load() {
        if let data = UserDefaults.standard.data(forKey: key),
           let decoded = try? JSONDecoder().decode([Trip].self, from: data) {
            trips = decoded
        }
    }
}
