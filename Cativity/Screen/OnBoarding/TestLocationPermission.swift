//
//  TestLocationPermission.swift
//  Cativity
//
//  Created by Yusup Hidayat Winata on 18/05/24.
//

import SwiftUI

struct TestLocationPermission: View {
        @StateObject private var locationPermission:LocationPermission=LocationPermission()
        var body: some View {
            VStack {
                
                switch locationPermission.authorizationStatus{
                    
                case .notDetermined:
                    Text("not determied")
                case .restricted:
                    Text("restricted")
                case .denied:
                    Text("denied")
                case .authorizedAlways:
                    VStack {
                        Text(locationPermission.cordinates?.latitude.description ?? "")
                        Text(locationPermission.cordinates?.longitude.description ?? "")
                        
                    }

                case .authorizedWhenInUse:
                    VStack {
                        Text(locationPermission.cordinates?.latitude.description ?? "")
                        Text(locationPermission.cordinates?.longitude.description ?? "")
                        
                    }

                    
                default:
                    Text("no")
                }
                
                Button {
                    locationPermission.requestLocationPermission()
                } label: {
                    Text("Ask Location Permission")
                        .padding()
                }
                
            }
            .buttonStyle(.bordered)
            
        }
}

#Preview {
    TestLocationPermission()
}
