import Foundation

class TaxiMeter: ObservableObject {
    @Published var isRunning = false
    @Published var seconds = 0
    @Published var locationManager = LocationManager()

    var timer: Timer?
    var tripStore: TripStore?

    func start() {
        isRunning = true
        seconds = 0
        locationManager.start()

        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { _ in
            self.seconds += 1
        }
    }

    func stop() {
        isRunning = false
        timer?.invalidate()
        locationManager.stop()
    }

    func finishTrip() {
        let trip = Trip(
            date: Date(),
            distanceKm: locationManager.distanceKm,
            durationSec: seconds,
            price: price,
            pickupAddress: locationManager.currentAddress,
            dropoffAddress: locationManager.currentAddress
        )

        tripStore?.add(trip)
    }

    var price: Double {
        let minutes = Double(seconds) / 60
        return 2.5 + (locationManager.distanceKm * 1.2) + (minutes * 0.3)
    }
}
