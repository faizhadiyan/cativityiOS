//
//  BottomSheetMap.swift
//  Cativity
//
//  Created by Wahyu Untoro on 16/05/24.
//

import Foundation
import SwiftUI
import MapKit

struct BottomSheetMap: View {
    @State private var selectedCoordinate = CLLocationCoordinate2D(latitude: 37.7749, longitude: -122.4194)
    
    @Binding var onSave : (CLLocation, LocationType) -> Void
    @Binding var onDismiss : () -> Void
    @Binding var locationType: LocationType
    @State private var isInitialLocationSet = true
    
    @ObservedObject var locationManager = LocationManager()
    @State private var region = MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: 37.7749, longitude: -122.4194),
        span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
    )
    
    var body: some View {
        NavigationView {
            VStack {
                MapView(selectedCoordinate: $selectedCoordinate, region: $region, isFirstOpen: $isInitialLocationSet)
                                    .onAppear {
                                        if let location = locationManager.location {
                                            region = MKCoordinateRegion(
                                                center: location.coordinate,
                                                span: MKCoordinateSpan(latitudeDelta: 0.005, longitudeDelta: 0.005) // Adjust the zoom level here
                                            )
                                            selectedCoordinate = location.coordinate
                                            
                                            isInitialLocationSet = false
                                        }
                                    }
            }
            .navigationTitle("Pilih Lokasi")
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarItems(leading: Button("Atur Lokasi", systemImage: "chevron.backward", action: {
                onDismiss()
            }).labelStyle(.titleAndIcon), trailing: Button("Simpan", action: {
                onSave(CLLocation(latitude: selectedCoordinate.latitude, longitude: selectedCoordinate.longitude), locationType)
            }))
            .navigationBarColor(UIColor.white)
        }
    }
}

#Preview {
    BottomSheetMap(onSave: .constant({ CLLocation, LocationType in
        
    }), onDismiss: .constant {
        
    },  locationType: .constant(.campus))
}
