import Foundation

struct Trip: Identifiable, Codable {
    var id = UUID()
    var date: Date
    var distanceKm: Double
    var durationSec: Int
    var price: Double
    var pickupAddress: String
    var dropoffAddress: String
}
