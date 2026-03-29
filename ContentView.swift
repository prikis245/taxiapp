import SwiftUI

struct ContentView: View {
    @StateObject var meter = TaxiMeter()
    @StateObject var store = TripStore()

    @State private var showTrips = false

    var body: some View {
        NavigationStack {
            ZStack {
                LinearGradient(colors: [.black, .blue],
                               startPoint: .top,
                               endPoint: .bottom)
                .ignoresSafeArea()

                VStack(spacing: 20) {

                    Text("€\(meter.price, specifier: "%.2f")")
                        .font(.system(size: 60, weight: .bold))
                        .foregroundColor(.white)

                    Text("\(meter.seconds)s | \(meter.locationManager.distanceKm, specifier: "%.2f") km")
                        .foregroundColor(.white.opacity(0.7))

                    Text("?? \(meter.locationManager.currentAddress)")
                        .foregroundColor(.white.opacity(0.8))
                        .font(.caption)
                        .multilineTextAlignment(.center)

                    HStack {
                        Button(meter.isRunning ? "Stop" : "Start") {
                            if meter.isRunning {
                                meter.stop()
                                meter.tripStore = store
                                meter.finishTrip()
                            } else {
                                meter.tripStore = store
                                meter.start()
                            }
                        }
                        .padding()
                        .frame(width: 120)
                        .background(Color.green)
                        .foregroundColor(.white)
                        .cornerRadius(12)

                        Button("Waze") {
                            if let url = URL(string: "waze://") {
                                UIApplication.shared.open(url)
                            }
                        }
                        .padding()
                        .frame(width: 120)
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(12)
                    }

                    Spacer()
                }
                .padding()
            }
            .navigationTitle("Taxi App")
            .toolbar {
                Button("Trips") {
                    showTrips = true
                }
            }
            .sheet(isPresented: $showTrips) {
                TripsView(store: store)
            }
        }
    }
}
