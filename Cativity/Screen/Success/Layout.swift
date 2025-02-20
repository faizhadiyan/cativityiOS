//
//  Layout.swift
//  Cativity
//
//  Created by Yusup Hidayat Winata on 16/05/24.
//

import SwiftUI
import CoreLocation
import SwiftData

struct LocationCoordinate: Equatable {
    var latitude: Double
    var longitude: Double
    
    init(_ coordinate: CLLocationCoordinate2D) {
        self.latitude = coordinate.latitude
        self.longitude = coordinate.longitude
    }
    
    init(latitude: Double, longitude: Double) {
        self.latitude = latitude
        self.longitude = longitude
    }
    
    var coordinate: CLLocationCoordinate2D {
        CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
    }
}

struct Layout: View {
    @Environment(\.modelContext) private var context
    @Query private var items: [LocationModel]
    
    @State private var homeLocation: LocationCoordinate = LocationCoordinate(latitude: 0, longitude: 0)
    @State private var campusLocation: LocationCoordinate = LocationCoordinate(latitude: 0, longitude: 0)
    @State private var userLocation: LocationCoordinate = LocationCoordinate(latitude: 0, longitude: 0)
    
    @StateObject private var locationManagerDelegate = LocationManagerDelegate()
    
    private func loadLocation() {
        if let home = items.first(where: { $0.type == .home }) {
            homeLocation = LocationCoordinate(latitude: Double(home.latitude) ?? 0, longitude: Double(home.longitude) ?? 0)
        }
        if let campus = items.first(where: { $0.type == .campus }) {
            campusLocation = LocationCoordinate(latitude: Double(campus.latitude) ?? 0, longitude: Double(campus.longitude) ?? 0)
        }
    }
    
    private func updateUserLocation() {
        locationManagerDelegate.locationManager.requestWhenInUseAuthorization()
        if CLLocationManager.locationServicesEnabled() {
            locationManagerDelegate.locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            locationManagerDelegate.locationManager.startUpdatingLocation()
        }
    }
    
    var body: some View {
        VStack {
            if (userLocation.latitude == homeLocation.latitude && userLocation.longitude == homeLocation.longitude) || (userLocation.latitude == campusLocation.latitude && userLocation.longitude == campusLocation.longitude) {
                SuccessScreenLayout()
            } else {
                FailScreenLayout()
            }
        }
        .onAppear {
            loadLocation()
            updateUserLocation()
        }
        .onChange(of: locationManagerDelegate.userLocation) { newLocation in
            userLocation = newLocation
        }
    }
}

class LocationManagerDelegate: NSObject, ObservableObject, CLLocationManagerDelegate {
    @Published var userLocation: LocationCoordinate = LocationCoordinate(latitude: 0, longitude: 0)
    var locationManager = CLLocationManager()
    
    override init() {
        super.init()
        locationManager.delegate = self
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.last {
            userLocation = LocationCoordinate(location.coordinate)
        }
    }
}

#Preview {
    Layout()
}
