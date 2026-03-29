import CoreLocation

class LocationManager: NSObject, ObservableObject, CLLocationManagerDelegate {
    private let manager = CLLocationManager()

    @Published var distanceKm: Double = 0
    @Published var currentAddress: String = "Loading..."

    private var lastLocation: CLLocation?
    private let geocoder = CLGeocoder()

    override init() {
        super.init()
        manager.delegate = self
        manager.desiredAccuracy = kCLLocationAccuracyBest
    }

    func start() {
        manager.requestWhenInUseAuthorization()
        manager.startUpdatingLocation()
    }

    func stop() {
        manager.stopUpdatingLocation()
    }

    func locationManager(_ manager: CLLocationManager,
                         didUpdateLocations locations: [CLLocation]) {

        guard let loc = locations.last else { return }

        if let last = lastLocation {
            distanceKm += loc.distance(from: last) / 1000
        }

        lastLocation = loc

        geocoder.reverseGeocodeLocation(loc) { places, _ in
            guard let p = places?.first else { return }

            DispatchQueue.main.async {
                self.currentAddress =
                "\(p.thoroughfare ?? ""), \(p.locality ?? "")"
            }
        }
    }
}
