import SwiftUI

struct TripsView: View {
    @ObservedObject var store: TripStore

    var body: some View {
        List(store.trips) { trip in
            VStack(alignment: .leading) {
                Text("€\(trip.price, specifier: "%.2f")")
                Text("\(trip.distanceKm, specifier: "%.2f") km")
                Text("?? \(trip.pickupAddress)")
                Text("?? \(trip.dropoffAddress)")
            }
        }
    }
}
